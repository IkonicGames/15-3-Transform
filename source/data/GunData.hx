
package data;

class GunData 
{
	public static function fromXML(xml:Xml):GunData
	{
		var gun = new GunData();
		gun.type = xml.get("type");
		gun.fireRate = Std.parseFloat(xml.get("fireRate"));
		gun.shotCount = Std.parseInt(xml.get("shotCount"));
		gun.clipSize = Std.parseInt(xml.get("clipSize"));
		gun.reloadTime = Std.parseFloat(xml.get("reloadTime"));
		gun.spread = Std.parseFloat(xml.get("spread"));

		return gun;
	}

	function new() {}
	
	public var type(default, null):String;
	public var fireRate(default, null):Float;
	public var shotCount(default, null):Int;
	public var clipSize(default, null):Int;
	public var reloadTime(default, null):Float;
	public var spread(default, null):Float;
}