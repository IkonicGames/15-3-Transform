
package entities;

import data.GunData;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxTimer;
import flixel.util.FlxMath;
import flixel.util.FlxSpriteUtil;
import flixel.tweens.FlxTween;

class WeaponDrop extends FlxSprite
{
	var player:Player;
	var type:String;
	var timer:FlxTimer;

	function new()
	{
		super();

		timer = new FlxTimer(GC.DROP_LIVE_TIME, onTimerComplete);
	}

	override public function update():Void
	{
		super.update();

		if(FlxMath.distanceBetween(this, player) < 25)
		{
			player.giveGun(type);
			this.destroy();
		}
	}

	function onTimerComplete(timer:FlxTimer):Void
	{
		FlxSpriteUtil.fadeOut(this, GC.DROP_FADE_TIME, false, onFadeComplete);
	}

	function onFadeComplete(tween:FlxTween):Void
	{
		this.destroy();
	}

	public function setData(data:GunData):Void
	{
		this.loadGraphic("assets/images/" + data.type + "_pickup.png");
		type = data.type;
	}

	public function setPlayer(player:Player):Void
	{
		this.player = player;
	}
}