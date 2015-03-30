
package entities;

import flixel.FlxSprite;
import flixel.util.FlxPoint;
import flixel.util.FlxAngle;
import flixel.util.FlxColor;
import flixel.addons.nape.FlxNapeSprite;
import flixel.addons.nape.FlxNapeVelocity;

class Bullet extends FlxNapeSprite
{
	function new(owner:FlxSprite, X:Float, Y:Float, toX:Float, toY:Float)
	{
		super(X, Y);

		this.makeGraphic(4, 4);
		this.color = FlxColor.BLUE;

		this.createCircularBody(GC.BULLET_RADIUS, nape.phys.BodyType.DYNAMIC);
		this.body.mass = GC.BULLET_MASS;
		this.physicsEnabled = true;
		this.body.cbTypes.add(GC.CB_BULLET);
		this.body.userData.owner = owner;
		this.body.userData.data = this;
		this.body.isBullet = true;
		this.body.setShapeFilters(GC.FILTER_BULLET);

		FlxNapeVelocity.moveTowardsPoint(this, FlxPoint.get(toX, toY), GC.BULLET_SPEED);
		this.body.velocity.length = GC.BULLET_SPEED;
	}
}
