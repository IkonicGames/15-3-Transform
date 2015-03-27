
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

	override public function setEnabled(enabled:Bool):Bool
	{
		if(this.enabled == enabled || owner.body == null)
			return enabled;

		if(enabled)
			owner.body.cbTypes.add(GC.CB_BITER);
		else
			owner.body.cbTypes.remove(GC.CB_BITER);

		return super.setEnabled(enabled);
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
		if(!enabled)
			return;
		// if there is no target, bite everything.
		// if there is a target, only bite the target.
		if((target == null || target == this.target) && canBite)
		{
			target.hurt(biteDamage);
			timer.reset(1 / bitesPerSec);
			canBite = false;
		}
	}
}