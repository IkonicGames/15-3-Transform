package ;

import flixel.util.FlxPoint;
import nape.callbacks.CbType;
import nape.dynamics.InteractionFilter;
import data.EnemyData;
import data.WaveData;
import data.GunData;
import haxe.xml.Fast;
import haxe.ds.StringMap;
import openfl.Assets;

class GC 
{
	public static var LEVEL_DIMS(default, null):FlxPoint;

	public static var PLR_HEALTH(default, null):Float;
	public static var PLR_SPEED(default, null):Float;
	public static var PLR_BITE_DAMAGE(default, null):Float;
	public static var PLR_BITE_PER_SEC(default, null):Float;

	public static var BULLET_SPEED(default, null):Float;
	public static var BULLET_WEIGHT(default, null):Float;

	public static var WAVES(default, null):Array<WaveData>;
	public static var ENEMIES(default, null):StringMap<EnemyData>;
	public static var GUNS(default, null):StringMap<GunData>;

	public static var CB_EDIBLE(default, null):CbType = new CbType();
	public static var CB_BITER(default, null):CbType = new CbType();
	public static var CB_BULLET(default, null):CbType = new CbType();
	public static var CB_SHOOTABLE(default, null):CbType = new CbType();
	public static var CB_BOUNDS(default, null):CbType = new CbType();

	public static inline var GROUP_PLAYER:Int = 1 << 0;
	public static inline var GROUP_ENEMY:Int = 1 << 1;
	public static inline var GROUP_BOUNDS:Int = 1 << 2;

	public static var FILTER_PLAYER(default, null):InteractionFilter = new InteractionFilter(GROUP_PLAYER);
	public static var FILTER_ENEMY(default, null):InteractionFilter = new InteractionFilter(GROUP_ENEMY, ~GROUP_BOUNDS);
	public static var FILTER_BOUNDS(default, null):InteractionFilter = new InteractionFilter(GROUP_BOUNDS, ~GROUP_ENEMY);

	static var _init:Bool;
	public static function init():Void
	{
		if(_init)
			return;

		_init = true;

		// load config.xml
		WAVES = new Array<WaveData>();
		ENEMIES = new StringMap<EnemyData>();
		GUNS = new StringMap<GunData>();

		var xml = Xml.parse(Assets.getText(AssetPaths.config__xml));
		var fast = new Fast(xml.firstElement());

		for(element in fast.elements)
		{
			switch(element.name)
			{
				case "enemies":
					for(enemyFast in element.elements)
					{
						var enemy = EnemyData.fromXML(enemyFast.x);
						ENEMIES.set(enemy.type, enemy);
					}

				case "waves":
					for(waveFast in element.elements)
					{
						var wave = WaveData.fromXML(waveFast.x);
						WAVES.push(wave);
					}

				case "guns":
					for(gunFast in element.elements)
					{
						var gun = GunData.fromXML(gunFast.x);
						GUNS.set(gun.type, gun);
					}

				case "player":
					PLR_HEALTH = Std.parseFloat(element.att.health);
					PLR_SPEED = Std.parseFloat(element.att.speed);
					PLR_BITE_DAMAGE = Std.parseFloat(element.att.biteDamage);
					PLR_BITE_PER_SEC = Std.parseFloat(element.att.bitePerSec);
					
				case "dims":
					LEVEL_DIMS = new FlxPoint(Std.parseFloat(element.att.x), Std.parseFloat(element.att.y));

				case "bullet":
					BULLET_SPEED = Std.parseFloat(element.att.speed);
					BULLET_WEIGHT = Std.parseFloat(element.att.weight);
			}
		}
	}
}
