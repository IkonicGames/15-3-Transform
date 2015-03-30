
package ;

import entities.BulletManager;
import entities.EnemyManager;
import entities.WeaponDropManager;
import ui.GameHUD;

class Locator 
{
	public static var bulletManager(default, null):BulletManager;
	public static var enemyManager(default, null):EnemyManager;
	public static var weaponDropManager(default, null):WeaponDropManager;
	public static var gameHUD(default, null):GameHUD;

	public static function registerBulletManager(bm:BulletManager):BulletManager
	{
		if(bulletManager != null)
			throwError(BulletManager);
		bulletManager = bm;
		return bulletManager;
	}

	public static function releaseBulletManager(bm:BulletManager):Void
	{
		if(bulletManager == bm)
			bulletManager = null;
	}

	public static function registerEnemyManager(em:EnemyManager):EnemyManager
	{
		if(enemyManager != null)
			throwError(EnemyManager);
		enemyManager = em;
		return enemyManager;
	}

	public static function releaseEnemyManager(em:EnemyManager):Void
	{
		if(enemyManager == em)
			enemyManager = null;
	}

	public static function registerGameHUD(ghud:GameHUD):GameHUD
	{
		if(gameHUD != null)
			throwError(GameHUD);
		gameHUD = ghud;
		return ghud;
	}

	public static function releaseGameHUD(ghud:GameHUD):GameHUD
	{
		if(gameHUD == ghud)
			gameHUD = null;

		return ghud;
	}

	public static function registerWeaponDropManager(wd:WeaponDropManager):WeaponDropManager
	{
	    if(weaponDropManager != null)
	    	throwError(WeaponDropManager);
	    			
    	weaponDropManager = wd;
    	return weaponDropManager;
	}

	public static function releaseWeaponDropManager(wd:WeaponDropManager):WeaponDropManager
	{
	    if(weaponDropManager == wd)
	    	weaponDropManager = null;

	    return wd;
	}

	private static inline function throwError(c:Class<Dynamic>):Void
	{
		throw "Only one instance of " + Type.getClassName(c) + " may be registered at a time.";
	}
}