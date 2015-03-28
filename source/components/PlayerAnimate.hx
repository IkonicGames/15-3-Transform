
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

		var sprite = GC.ANIMATION_CONTROLLERS.get("humanoid1");
		owner.loadGraphic(sprite.image, true, sprite.frameWidth, sprite.frameHeight);
		sprite.addAnimToController(owner.animation);

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
