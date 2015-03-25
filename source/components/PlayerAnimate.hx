
package components;

import components.PlayerMove;
import flixel.FlxG;
import ikutil.IkComponent;
import ikutil.IkEntity;

class PlayerAnimate extends IkComponent
{
	var playerMove:PlayerMove;

	public function new()
	{
		super();
	}

	override public function init(owner:IkEntity):Void
	{
		super.init(owner);

		owner.loadGraphic(AssetPaths.humanoid1__png, true, 8, 8);
		owner.animation.add("stand", [0], 24, true);
		owner.animation.add("run", [0,1,2,3,4,5,6,7,8,9], 24, true);
		owner.scale.set(4, 4);
		owner.color = 0xFF0000FF;

		playerMove = cast owner.getComponent(PlayerMove);
	}

	override public function update():Void
	{
		if(playerMove.isMoving)
			owner.animation.play("run");
		else
			owner.animation.play("stand");
	}
}
