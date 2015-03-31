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
import flixel.util.FlxRandom;
import flixel.util.FlxVelocity;
import nape.phys.Body;

class Gun extends FlxSprite
{
	public var type(default, null):String;
	public var reloadPct(get, never):Float;

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
	var shootTarget:FlxVector;
	var isReloading:Bool;

	public function new()
	{
		super();

		this.makeGraphic(4, 4);
		this.color = flixel.util.FlxColor.RED;

		target = FlxPoint.get();
		shootTarget = FlxVector.get();
		position = FlxVector.get();
		timer = new FlxTimer(0.1, onTimerCompleted, 0);
		canShoot = false;
		bulletManager = Locator.bulletManager;
		isReloading = false;
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

		clipRemaining = clipSize;
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

		isReloading = false;
		canShoot = false;

		for(i in 0...shotCount)
		{
			// var angle = FlxAngle.angleBetweenPoint(this, target, true);
			// var t = FlxAngle.getCartesianCoords(1, angle);
			shootTarget.set(target.x - x, target.y - y);
			shootTarget.rotateByDegrees(FlxRandom.floatRanged(-spread / 2, spread / 2));
			shootTarget.add(x, y);
			bulletManager.shoot(parent, x, y, shootTarget.x, shootTarget.y);
		}
		clipRemaining--;

		if(clipRemaining > 0)
			timer.reset(1 / fireRate);
		else
			reload();
	}

	function reload():Void
	{
		isReloading = true;
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

	function get_reloadPct():Float
	{
		if(isReloading)
			return timer.progress;

		return 1;
	}
}
