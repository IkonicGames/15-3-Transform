
package components;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxTimer;
import ikutil.IkComponent;

class Biter extends IkComponent
{
	public var biteDamage:Float;
	public var bitesPerSec:Float;

	var target:FlxSprite;

	var timer:FlxTimer;
	var canBite:Bool;

	public function new()
	{
		super();

		timer = new FlxTimer(0, onBiteRefresh);
		canBite = true;
	}

	function onBiteRefresh(timer:FlxTimer):Void
	{
		canBite = true;
	}

	public function setTarget(target:FlxSprite):Void
	{
		this.target = target;
	}

	public function bite(target:FlxSprite):Void
	{
		if(target == this.target && canBite)
		{
			target.hurt(biteDamage);
			timer.reset(1 / bitesPerSec);
			canBite = false;
		}
	}
}