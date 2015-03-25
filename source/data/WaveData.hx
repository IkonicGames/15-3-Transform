
package data;

import haxe.ds.StringMap;

class WaveData
{
	public static function fromXML(xml:Xml):WaveData
	{
		var wave = new WaveData();
		wave.duration = Std.parseFloat(xml.get("duration"));
		for(enemy in xml.elementsNamed("enemy"))
			wave.enemies.set(enemy.get("type"), Std.parseInt(enemy.get("count")));

		return wave;
	}

	public function new()
	{
		enemies = new StringMap<Int>();
	}

	public var duration:Float;
	public var enemies:StringMap<Int>;
}
