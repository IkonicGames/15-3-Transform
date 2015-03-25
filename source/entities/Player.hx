package entities;

import components.PlayerMove;
import components.Shooter;
import flixel.FlxG;
import flixel.util.FlxSignal;
import flixel.util.FlxVector;
import ikutil.IkEntity;

class Player extends IkEntity
{
	public var onDied(default, null):FlxSignal;

	var playerMove:PlayerMove;
	var shooter:Shooter;
	var direction:FlxVector;
	var isMoving:Bool;

	function new()
	{
		super(0, 0, null, false);

		direction = new FlxVector();

		this.createCircularBody(8, nape.phys.BodyType.DYNAMIC);
		this.physicsEnabled = true;
		this.body.mass = 2;
		this.body.userData.data = this;
		this.body.cbTypes.add(GC.CB_EDIBLE);
		this.body.cbTypes.add(GC.CB_SHOOTABLE);
		this.body.setShapeFilters(GC.FILTER_PLAYER);

		this.health = GC.PLR_HEALTH;
		onDied = new FlxSignal();

		playerMove = cast this.addComponent(new PlayerMove());
		this.addComponent(new components.PlayerAnimate());

		shooter = cast this.addComponent(new Shooter());
		shooter.setGun("pistol", 8, 8);
	}

	override public function update():Void
	{
		super.update();

		shooter.setTarget(FlxG.mouse.x, FlxG.mouse.y);
	}

	override public function kill():Void
	{
		super.kill();

		onDied.dispatch();
	}
}
