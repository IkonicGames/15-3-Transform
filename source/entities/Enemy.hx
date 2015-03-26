package entities;

import components.Biter;
import components.EnemyMove;
import data.EnemyData;
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

	// Components
	var biter:Biter;
	var enemyMove:EnemyMove;

	var enemyManager:EnemyManager;

	function new()
	{
		super(0, 0, null, false);

		onDeath = new FlxTypedSignal<Enemy -> Void>();

		enemyManager = Locator.enemyManager;

		enemyMove = cast this.addComponent(new EnemyMove());
		biter = cast this.addComponent(new Biter());
	}

	override public function kill():Void
	{
		super.kill();
		onDeath.dispatch(this);
	}

	public function setTarget(target:FlxSprite):Void
	{
		enemyMove.setTarget(target);
		biter.setTarget(target);
	}

	public function bite(target:FlxSprite):Void
	{
		biter.bite(target);
	}

	public function setData(data:EnemyData):Void
	{
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

			loadGraphic(AssetPaths.humanoid1__png, true, 8, 8);
			animation.add("run", [0,1,2,3,4,5,6,7,8,9], 12, true);
			animation.play("run", true, FlxRandom.intRanged(0, 9));
			scale.set(4, 4);
			color = FlxColor.RED;
		}
	}
}
