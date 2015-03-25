
package ikutil;

import ikutil.IkEntity;

class IkComponent 
{
	public var owner(default, null):IkEntity;
	public var enabled:Bool = true;
	
	public function new() {}

	@:allow(ikutil.IkEntity)
	private function init(owner:IkEntity):Void
	{
		this.owner = owner;
	}

	public function update():Void {}

	@:allow(ikutil.IkEntity)
	private function draw():Void {}

	public function destroy():Void {}
}