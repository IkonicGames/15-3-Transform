package components;

import flixel.FlxG;
import ikutil.IkComponent;
import flixel.util.FlxVector;
import flixel.util.FlxAngle;

class PlayerMove extends IkComponent
{
	public var speed:Float;
	public var isMoving(default, null):Bool;

	var direction:FlxVector;
	
	public function new()
	{
		super();

		direction = FlxVector.get();
	}
	
	override public function update():Void
	{
		updateMovement();
		updateRotation();
	}

	function updateMovement():Void
	{
		direction.set(0, 0);
		if(FlxG.keys.pressed.W) direction.y -= 1;
		if(FlxG.keys.pressed.S) direction.y += 1;
		if(FlxG.keys.pressed.A) direction.x -= 1;
		if(FlxG.keys.pressed.D) direction.x += 1;

		isMoving = direction.length != 0;
		if(isMoving)
			direction.normalize();

		owner.body.velocity.setxy(direction.x * speed, direction.y * speed);
	}

	function updateRotation():Void
	{
		owner.body.rotation = FlxAngle.angleBetweenMouse(owner, false);
	}

}