
package components;

import ikutil.IkComponent;
import ikutil.IkEntity;
import entities.Gun;
import flixel.FlxG;
import flixel.util.FlxPoint;

class Shooter extends IkComponent
{
	public var autoShoot:Bool;

	var gun:Gun;

	public function new()
	{
		super();
	}
	
	public function setGun(type:String, offX:Float, offY:Float):Void
	{
		if(gun == null)
		{
			gun = new Gun();
			FlxG.state.add(gun);
		}

		gun.setData(GC.GUNS.get(type));
		gun.setParent(owner);
		gun.setReleativePos(offX, offY);
	}

	override public function update():Void
	{
		if(autoShoot)
			shoot();
	}

	override public function setEnabled(enabled:Bool):Bool
	{
		if(this.enabled == enabled)
			return enabled;

		if(gun != null)
			gun.kill();

		return super.setEnabled(enabled);
	}

	public function setTarget(x:Float, y:Float):Void
	{
		gun.updateTarget(x, y);
	}

	public function shoot():Void
	{
		if(enabled)
			gun.shoot();
	}
}