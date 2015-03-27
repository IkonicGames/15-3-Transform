package entities;

import components.Biter;
import components.PlayerMove;
import components.Shooter;
import flixel.addons.nape.FlxNapeState;
import flixel.FlxG;
import flixel.util.FlxSignal;
import flixel.util.FlxVector;
import ikutil.IkEntity;
import nape.callbacks.CbEvent;
import nape.callbacks.InteractionCallback;
import nape.callbacks.InteractionListener;
import nape.callbacks.InteractionType;

class Player extends IkEntity
{
	public var onDied(default, null):FlxSignal;

	var playerMove:PlayerMove;
	var biter:Biter;
	var shooter:Shooter;
	var direction:FlxVector;
	var isMoving:Bool;

	var biteListener:InteractionListener;

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

		biter = cast this.addComponent(new Biter());
		biter.biteDamage = GC.PLR_BITE_DAMAGE;
		biter.bitesPerSec = GC.PLR_BITE_PER_SEC;
		biter.setEnabled(false);

		biteListener = new InteractionListener(CbEvent.ONGOING, InteractionType.COLLISION,
			GC.CB_BITER, GC.CB_EDIBLE, onTouchEnemy);
	}

	override public function update():Void
	{
		super.update();

		shooter.setTarget(FlxG.mouse.x, FlxG.mouse.y);
		shooter.shoot();
	}

	override public function kill():Void
	{
		super.kill();

		onDied.dispatch();
	}

	function onTouchEnemy(cb:InteractionCallback):Void
	{
		if(cb.int2.userData.data != null)
			biter.bite(cast cb.int2.userData.data);
	}

	public function setZombie():Void
	{
		shooter.setEnabled(false);
		biter.setEnabled(true);
		FlxNapeState.space.listeners.add(biteListener);
	}
}
