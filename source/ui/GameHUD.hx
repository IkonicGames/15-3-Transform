
package ui;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import entities.Player;
import entities.Gun;

class GameHUD extends FlxGroup
{
	var healthBar:FlxBar;
	var score:FlxText;

	var playerGun:Gun;
	var reloadBar:FlxBar;

	public function new()
	{
		super();

		score = new FlxText(0, 5, FlxG.width, "0", 18);
		score.scrollFactor.set(0, 0);
		score.alignment = "center";
		this.add(score);

		reloadBar = new FlxBar(FlxG.width / 2 - 50, 30, 1, 100, 10);
		reloadBar.centerOffsets();
		reloadBar.scrollFactor.set(0, 0);
		reloadBar.setRange(0, 1);
		reloadBar.createFilledBar(FlxColor.BLACK, FlxColor.BLUE, true, FlxColor.BLACK);
		this.add(reloadBar);
		// reloadBar.visible = false;
	}

	override public function update():Void
	{
		reloadBar.visible = playerGun.reloadPct != 1;
		score.text = Std.string(Locator.scoreManager.score);

		super.update();
	}
	
	public function setPlayer(player:Player):Void
	{
		healthBar = new FlxBar(5, 5, 1, 120, 10);
		this.add(healthBar);
		healthBar.scrollFactor.set(0, 0);
		healthBar.setParent(player, "health", false);
		healthBar.setRange(0, GC.PLR_HEALTH);
		healthBar.createFilledBar(FlxColor.BLACK, FlxColor.RED, true, FlxColor.BLACK);
		healthBar.percent = 1;

		reloadBar.setParent(player.getGun(), "reloadPct", false);
		playerGun = player.getGun();
	}
}