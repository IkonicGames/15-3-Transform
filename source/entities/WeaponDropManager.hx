
package entities;

import entities.WeaponDrop;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxArrayUtil;
import flixel.util.FlxRandom;
import flixel.group.FlxTypedGroup;

class WeaponDropManager extends FlxTypedGroup<WeaponDrop>
{
	var player:Player;

	function new()
	{
		super();

		Locator.enemyManager.enemyDiedSignal.add(onEnemyDied);
	}
	
	function onEnemyDied(enemy:FlxSprite):Void
	{
		if(!FlxRandom.chanceRoll(GC.DROP_SPAWN_CHANCE))
			return;
		var wd = new WeaponDrop();
		wd.x = enemy.x;
		wd.y = enemy.y;
		wd.setPlayer(player);
		this.add(wd);

		var type = FlxArrayUtil.getRandom(GC.GUN_TYPES);
		wd.setData(GC.GUNS.get(type));
	}

	public function setPlayer(player:Player):Void
	{
		this.player = player;
	}
}