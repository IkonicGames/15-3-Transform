package ikutil;

import ikutil.IkEntity;

class IkComponent 
{
	public var owner(default, null):IkEntity;
	public var enabled(default, null):Bool;
	
	public function new() {}

	@:allow(ikutil.IkEntity)
	private function init(owner:IkEntity):Void
	{
		this.owner = owner;

		setEnabled(true);
	}

	public function update():Void {}

	@:allow(ikutil.IkEntity)
	private function draw():Void {}

	public function destroy():Void {}

	public function setEnabled(enabled:Bool):Bool
	{
		return this.enabled = enabled;
	}
}