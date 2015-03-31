
package ;

import entities.Enemy;

class ScoreManager 
{
	public var score(default, null):Int;

	public function new()
	{
		score = 0;

		Locator.enemyManager.enemyDiedSignal.add(onEnemyDied);
	}

	function onEnemyDied(enemy:Enemy):Void
	{
		score += enemy.scoreValue;
	}
}