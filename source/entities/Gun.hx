package entities;

import data.GunData;
import entities.BulletManager;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxAngle;
import flixel.util.FlxPoint;
import flixel.util.FlxTimer;
import flixel.util.FlxVector;
import nape.phys.Body;

class Gun extends FlxSprite
{
	public var type(default, null):String;

	var parent:FlxSprite;
	var position:FlxVector;
	var rightAngleDiff:Float;

	// gundata
	var fireRate:Float;
	var reloadTime:Float;
	var clipSize:Int;
	var shotCount:Int;
	var spread:Float;

	var bulletManager:BulletManager;
	var canShoot:Bool;
	var timer:FlxTimer;
	var clipRemaining:Int;
	var target:FlxPoint;

	public function new()
	{
		super();

		this.makeGraphic(4, 4);
		this.color = flixel.util.FlxColor.BLUE;

		target = FlxPoint.get();
		position = FlxVector.get();
		timer = new FlxTimer(0.1, onTimerCompleted, 0);
		canShoot = false;
		bulletManager = Locator.bulletManager;
	}

	override public function update():Void
	{
		super.update();

		updatePosRot();
	}

	function onTimerCompleted(timer:FlxTimer):Void
	{
		canShoot = true;
	}

	public function setData(gunData:GunData):Void
	{
		type = gunData.type;
		fireRate = gunData.fireRate;
		shotCount = gunData.shotCount;
		clipSize = gunData.clipSize;
		reloadTime = gunData.reloadTime;
		spread = gunData.spread;

		reload();
	}

	public function setReleativePos(X:Float = 0, Y:Float = 0):Void
	{
		position.set(X, Y);
		rightAngleDiff = position.degrees;
	}

	public function setParent(parent:FlxSprite):Void
	{
		this.parent = parent;
	}

	public function updateTarget(tX:Float, tY:Float):Void
	{
		target.set(tX, tY);
	}

	public function shoot():Void
	{
		if(!canShoot)
			return;

		canShoot = false;

		bulletManager.shoot(parent, x, y, target.x, target.y);
		clipRemaining--;

		if(clipRemaining > 0)
			timer.reset(1 / fireRate);
		else
			reload();
	}

	function reload():Void
	{
		clipRemaining = clipSize;
		timer.reset(reloadTime);
	}

	function updatePosRot():Void
	{
		position.degrees = rightAngleDiff + parent.angle;
		this.angle = parent.angle;
		x = parent.x + parent.origin.x + position.x - origin.x;
		y = parent.y + parent.origin.y + position.y - origin.y;
	}
}
