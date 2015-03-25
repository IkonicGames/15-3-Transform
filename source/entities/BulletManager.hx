
package entities;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxPoint;
import flixel.addons.nape.FlxNapeState;
import nape.callbacks.CbEvent;
import nape.callbacks.InteractionCallback;
import nape.callbacks.InteractionListener;
import nape.callbacks.InteractionType;

class BulletManager extends FlxTypedGroup<Enemy>
{
	function new()
	{
		super();

		var hitListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, GC.CB_BULLET, GC.CB_SHOOTABLE, onBulletHit);
		FlxNapeState.space.listeners.add(hitListener);

		var boundsListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, GC.CB_BULLET, GC.CB_BOUNDS, onBoundsHit);
		FlxNapeState.space.listeners.add(boundsListener);
	}
	
	public function shoot(owner:FlxSprite, fromX:Float, fromY:Float, toX:Float, toY:Float)
	{
		var bullet = new Bullet(owner, fromX, fromY, toX, toY);
		FlxG.state.add(bullet);
	}

	function onBulletHit(cb:InteractionCallback):Void
	{
		if(cb.int1.userData.owner != cb.int2.userData.data)
		{
			cast(cb.int1.userData.data, FlxObject).kill();
			cast(cb.int2.userData.data, FlxObject).hurt(1);
		}
	}

	function onBoundsHit(cb:InteractionCallback):Void
	{
		cast(cb.int1.userData.data, FlxObject).kill();
	}
}