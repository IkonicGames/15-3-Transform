package data;

class EnemyData 
{
	public static function fromXML(xml:Xml):EnemyData
	{
		var ed = new EnemyData();
		ed.type = xml.get("type");
		ed.scoreValue = Std.parseInt(xml.get("score"));
		ed.color= Std.parseInt(xml.get("color"));
		ed.speed = Std.parseFloat(xml.get("speed"));
		ed.gun = xml.get("gun");
		ed.health = Std.parseInt(xml.get("health"));
		ed.radius = Std.parseInt(xml.get("radius"));
		ed.bitePerSec = Std.parseFloat(xml.get("bitePerSec"));
		ed.biteDamage = Std.parseInt(xml.get("biteDamage"));
		ed.sprite = xml.get("sprite");

		return ed;
	}

	private function new() {}

	public var type(default, null):String;
	public var scoreValue(default, null):Int;
	public var color(default, null):Int;
	public var speed(default, null):Float;
	public var gun(default, null):String;
	public var health(default, null):Int;
	public var radius(default, null):Int;
	public var bitePerSec(default, null):Float;
	public var biteDamage(default, null):Int;
	public var sprite(default, null):String;
}