
package ikutil;

import flixel.FlxSprite;
import haxe.ds.StringMap;

#if IK_USE_NAPE
import flixel.addons.nape.FlxNapeSprite;
class IkEntity extends FlxNapeSprite
#else
import flixel.FlxSprite;
class IkEntity extends FlxSprite
#end
{
	var components:StringMap<IkComponent>;

#if IK_USE_NAPE
	function new(?X:Float = 0, ?Y:Float = 0, ?SimpleGraphic:Dynamic = null, ?CreateRectangularBody:Bool = false, ?EnablePhysics:Bool = true)
#else
	function new(?X:Float = 0, ?Y:Float = 0, ?SimpleGraphic:Dynamic = null)
#end
	{
#if IK_USE_NAPE
		super(X, Y, SimpleGraphic, CreateRectangularBody, EnablePhysics);
#else
		super(X, Y, SimpleGraphic);
#end

		components = new StringMap<IkComponent>();
	}

	override public function update():Void
	{
		super.update();

		for(c in components)
			if(c.enabled)
				c.update();
	}

	override public function draw():Void
	{
		super.draw();
		for(c in components)
			if(c.enabled)
				c.draw();
	}
	
	public function addComponent(component:IkComponent):IkComponent
	{
		var className = Type.getClassName(Type.getClass(component));
		if(components.exists(className))
			throw "Entities can only contain one of any type of IkComponent: " + className;

		component.init(this);
		components.set(className, component);

		return component;
	}

	public function removeComponent(component:IkComponent):IkComponent
	{
		var className = Type.getClassName(Type.getClass(component));
		if(!components.exists(className))
			return null;

		var component = components.get(className);
		components.remove(className);

		return component;
	}

	public function getComponent(type:Class<IkComponent>):IkComponent
	{
		var className = Type.getClassName(type);
		if(!components.exists(className))
			return null;

		return components.get(className);
	}
}
