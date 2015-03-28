
package data;

import haxe.ds.StringMap;
import flixel.util.FlxStringUtil;
import flixel.animation.FlxAnimationController;

class SpriteData 
{
	public static function fromXML(xml:Xml):SpriteData
	{
		var data = new SpriteData();

		data.image = "assets/images/" + xml.get("name") + ".png";
		data.frameWidth = Std.parseInt(xml.get("frameWidth"));
		data.frameHeight = Std.parseInt(xml.get("frameHeight"));
		data.animations = new Array<AnimData>();
		for(anim in xml.elements())
			data.animations.push(AnimData.fromXML(anim));

		return data;
	}
	
	function new() {}

	public var image(default, null):String;
	public var frameWidth(default, null):Int;
	public var frameHeight(default, null):Int;
	public var animations:Array<AnimData>;

	public function addAnimToController(controller:FlxAnimationController):Void
	{
		for(anim in animations)
			controller.add(anim.name, anim.frames, anim.frameRate, anim.loop);
	}
}

class AnimData
{
	public static function fromXML(xml:Xml):AnimData
	{
		var data = new AnimData();

		data.name = xml.get("name");
		data.frames = FlxStringUtil.toIntArray(xml.get("frames"));
		data.frameRate = Std.parseInt(xml.get("frameRate"));
		data.loop = xml.get("loop") == "true";

		return data;
	}

	public function new() {}

	public var name(default, null):String;
	public var frames(default, null):Array<Int>;
	public var frameRate(default, null):Int;
	public var loop(default, null):Bool;
}