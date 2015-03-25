
package ui;

import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;

class GameHUD extends FlxGroup
{
	var healthBar:FlxBar;

	public function new()
	{
		super();
	}
	
	public function setPlayer(player:FlxSprite):Void
	{
		healthBar = new FlxBar(5, 5, 1, 120, 10);
		this.add(healthBar);
		healthBar.scrollFactor.set(0, 0);
		healthBar.setParent(player, "health", false);
		healthBar.setRange(0, GC.PLR_HEALTH);
		healthBar.createFilledBar(FlxColor.BLACK, FlxColor.RED, true, FlxColor.BLACK);
		healthBar.percent = 1;
	}
}