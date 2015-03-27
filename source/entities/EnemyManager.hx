
package entities;

import data.WaveData;
import data.EnemyData;
import entities.Enemy;
import flixel.FlxG;
import flixel.addons.nape.FlxNapeState;
import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxRandom;
import flixel.util.FlxTimer;
import flixel.util.FlxPoint;
import haxe.ds.StringMap;
import nape.callbacks.CbEvent;
import nape.callbacks.InteractionCallback;
import nape.callbacks.InteractionListener;
import nape.callbacks.InteractionType;
import openfl.Assets;

class EnemyManager extends FlxTypedGroup<Enemy>
{
	var waves:Array<WaveData>;
	var currentWave:Int;

	var target:FlxSprite;
	var enemyTypes:StringMap<EnemyData>;
	var activeEnemies:StringMap<Int>;
	var biteListener:InteractionListener;

	var timer:FlxTimer;

	var isHuman:Bool;

	function new()
	{
		super();

		waves = GC.WAVES;
		enemyTypes = GC.ENEMIES;
		activeEnemies = new StringMap<Int>();
		for(enemyType in enemyTypes.keys())
			activeEnemies.set(enemyType, 0);
		
		timer = new FlxTimer(waves[0].duration, onTimerCompleted);

		//physics
		biteListener = new InteractionListener(CbEvent.ONGOING, InteractionType.COLLISION,
			GC.CB_BITER, GC.CB_EDIBLE, onEnemyTouchPlayer);
		FlxNapeState.space.listeners.add(biteListener);
	}

	override public function update():Void
	{
		super.update();

		verifyEnemyCount();
	}

	function onTimerCompleted(timer:FlxTimer):Void
	{
		currentWave++;
		this.timer.reset(waves[currentWave].duration);
	}

	function onEnemyDied(enemy:Enemy):Void
	{
		var count = activeEnemies.get(enemy.type);
		count--;
		activeEnemies.set(enemy.type, count);
	}

	function onEnemyTouchPlayer(cb:InteractionCallback):Void
	{
		if(Std.is(cb.int1.userData.data, Enemy) && Std.is(cb.int2.userData.data, FlxSprite))
		{
			var enemy = cast(cb.int1.userData.data, Enemy);
			var target = cast(cb.int2.userData.data, FlxSprite);
			enemy.bite(target);
		}
	}

	public function setTarget(target:FlxSprite):Void
	{
		this.target = target;
	}

	public function setHuman():Void
	{
		isHuman = true;
		FlxNapeState.space.listeners.remove(biteListener);

		FlxG.state.forEachOfType(Enemy, function(enemy) {
			enemy.setHuman();
		});
	}

	function verifyEnemyCount():Void
	{
		for(key in enemyTypes.keys())
		{
			if(!waves[currentWave].enemies.exists(key))
				continue;

			var total = waves[currentWave].enemies.get(key);
			while(activeEnemies.get(key) < total)
				spawnEnemy(key);
		}
	}

	function spawnEnemy(type:String):Void
	{
		var enemy = new Enemy();
		this.add(enemy);
		enemy.onDeath.add(onEnemyDied);
		enemy.setTarget(target);
		enemy.setData(enemyTypes.get(type), isHuman);
		activeEnemies.set(type, activeEnemies.get(type) + 1);

		var pos = getSpawnPosition();
		enemy.body.position.setxy(pos.x, pos.y);
	}

	function getSpawnPosition():FlxPoint
	{
		var pos = FlxPoint.get();
		var side = FlxRandom.intRanged(0, 3);
		switch(side)
		{
			case 0: // top
				pos.x = FlxRandom.float() * GC.LEVEL_DIMS.x;
				pos.y = -30;

			case 1: // bottom
				pos.x = FlxRandom.float() * GC.LEVEL_DIMS.x;
				pos.y = GC.LEVEL_DIMS.y + 30;

			case 2: // left
				pos.x = -30;
				pos.y = FlxRandom.float() * GC.LEVEL_DIMS.y;

			case 3: // right
				pos.x = GC.LEVEL_DIMS.x + 30;
				pos.y = FlxRandom.float() * GC.LEVEL_DIMS.y;
		}

		return pos;
	}
}
