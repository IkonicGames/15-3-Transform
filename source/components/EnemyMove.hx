package components;

import flixel.FlxG;
import flixel.FlxSprite;
import ikutil.IkComponent;
import flixel.addons.nape.FlxNapeVelocity;
import flixel.util.FlxAngle;

class EnemyMove extends IkComponent
{
	public var target(default, null):FlxSprite;

	public var speed:Float;

	public function new()
	{
		super();
	}

	override public function update():Void
	{
		if(target != null)
		{
			updateMovement();
			updateRotation();
		}
	}

	public function setTarget(target:FlxSprite):Void
	{
		this.target = target;
	}

	inline function updateMovement():Void
	{
		FlxNapeVelocity.moveTowardsObject(owner, target, speed);
		owner.body.velocity.length = speed;
	}

	inline function updateRotation():Void
	{
		owner.body.rotation = FlxAngle.angleBetween(owner, target, false);
	}
}
