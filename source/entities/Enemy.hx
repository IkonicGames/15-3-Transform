package entities;

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

	var biteTimer:FlxTimer;
	var canBite:Bool;

	var enemyManager:EnemyManager;
	var enemyMove:EnemyMove;

	function new()
	{
		super(0, 0, null, false);

		onDeath = new FlxTypedSignal<Enemy -> Void>();

		biteTimer = new FlxTimer(0, onBiteRefresh);
		canBite = true;

		enemyManager = Locator.enemyManager;

		enemyMove = cast this.addComponent(new EnemyMove());
	}

	override public function kill():Void
	{
		super.kill();
		onDeath.dispatch(this);
	}

	function onBiteRefresh(timer:FlxTimer):Void
	{
		canBite = true;
	}

	public function setTarget(target:FlxSprite):Void
	{
		enemyMove.setTarget(target);
	}

	public function setData(data:EnemyData):Void
	{
		type = data.type;
		enemyMove.speed = data.speed;
		health = data.health;
		biteDamage = data.biteDamage;
		bitePerSec = data.bitePerSec;
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

	public function bite(target:FlxSprite):Void
	{
		if(target == this.target && canBite)
		{
			target.hurt(biteDamage);
			biteTimer.reset(1 / bitePerSec);
			canBite = false;
		}
	}

}
