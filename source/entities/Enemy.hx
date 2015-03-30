package entities;

import components.Biter;
import components.EnemyMove;
import components.Shooter;
import data.EnemyData;
import data.SpriteData;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxRandom;
import flixel.util.FlxSignal;
import flixel.util.FlxTimer;
import ikutil.IkEntity;

class Enemy extends IkEntity
{
	public var type(default, null):String;
	public var onDeath(default, null):FlxTypedSignal<Enemy -> Void>;

	var target:FlxSprite;
	var speed:Float;
	var radius:Int;
	var biteDamage:Int;
	var bitePerSec:Float;

	var enemyData:EnemyData;

	// Components
	var biter:Biter;
	var enemyMove:EnemyMove;
	var shooter:Shooter;

	var enemyManager:EnemyManager;

	function new()
	{
		super(0, 0, null, false);

		onDeath = new FlxTypedSignal<Enemy -> Void>();

		enemyManager = Locator.enemyManager;

		enemyMove = cast this.addComponent(new EnemyMove());
		enemyMove.setEnabled(false);
		biter = cast this.addComponent(new Biter());
		biter.setEnabled(false);
	}

	override public function update():Void
	{
		super.update();

		if(shooter != null && target != null)
			shooter.setTarget(target.x, target.y);
	}

	override public function kill():Void
	{
		if(!alive)
			return;
			
		super.kill();

		if(shooter != null)
			shooter.setEnabled(false);

		onDeath.dispatch(this);
	}

	override public function destroy():Void
	{
		shooter.destroy();
		super.destroy();
	}

	public function setTarget(target:FlxSprite):Void
	{
		this.target =  target;
		enemyMove.setTarget(target);
		biter.setTarget(target);
	}

	public function bite(target:FlxSprite):Void
	{
		biter.bite(target);
	}

	public function setData(data:EnemyData, isHuman:Bool):Void
	{
		enemyData = data;
		type = data.type;
		enemyMove.speed = data.speed;
		health = data.health;
		biter.biteDamage = data.biteDamage;
		biter.bitesPerSec = data.bitePerSec;
		if(radius != data.radius)
		{
			// TODO: think kthorugh this more...
			radius = data.radius;
			createCircularBody(radius);
			physicsEnabled = true;
			body.userData.data = this;
			body.cbTypes.add(GC.CB_BITER);
			body.cbTypes.add(GC.CB_SHOOTABLE);
			body.setShapeFilters(GC.FILTER_ENEMY);

			var sprite = GC.ANIMATION_CONTROLLERS.get(data.sprite);
			loadGraphic(sprite.image, true, sprite.frameWidth, sprite.frameHeight);
			sprite.addAnimToController(animation);
			animation.play("run");
			color = data.color;

			enemyMove.setEnabled(true);
			biter.setEnabled(true);
		}

		if(isHuman)
			setHuman();
	}

	public function setHuman():Void
	{
		if(!alive)
			return;

		biter.setEnabled(false);
		body.cbTypes.add(GC.CB_EDIBLE);
		shooter = cast this.addComponent(new Shooter());
		shooter.setGun(enemyData.gun, 8, 8);
		shooter.autoShoot = true;
	}
}
