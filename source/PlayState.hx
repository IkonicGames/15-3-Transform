package;

import entities.BulletManager;
import entities.EnemyManager;
import entities.Player;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import flixel.addons.nape.FlxNapeState;
import states.PauseState;
import ui.GameHUD;
import states.GameOverState;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxNapeState
{
	var player:Player;
	var enemyManager:EnemyManager;
	var bulletManager:BulletManager;
	var gameHUD:GameHUD;

	override public function create():Void
	{
		super.create();
		GC.init();
		
		this.createWalls(0, 0, GC.LEVEL_DIMS.x, GC.LEVEL_DIMS.y)
			.setShapeFilters(GC.FILTER_BOUNDS)
			.cbTypes.add(GC.CB_BOUNDS);

		bulletManager = Locator.registerBulletManager(new BulletManager());
		enemyManager = Locator.registerEnemyManager(new EnemyManager());
		gameHUD = Locator.registerGameHUD(new GameHUD());

		player = cast add(new Player());
		player.body.position.setxy(GC.LEVEL_DIMS.x / 2, GC.LEVEL_DIMS.y / 2);
		player.onDied.add(onPlayerDied);

		enemyManager.setTarget(player);
		gameHUD.setPlayer(player);

		add(enemyManager);
		add(bulletManager);
		add(gameHUD);

		FlxG.camera.focusOn(FlxPoint.get(GC.LEVEL_DIMS.x / 2, GC.LEVEL_DIMS.y / 2));
		// FlxG.camera.setBounds(0, 0, GC.LEVEL_DIMS.x, GC.LEVEL_DIMS.y);
		FlxG.camera.follow(player);

		this.velocityIterations = 10;
		this.positionIterations = 10;

		this.napeDebugEnabled = true;
	}

	override public function destroy():Void
	{
		super.destroy();

		Locator.releaseBulletManager(bulletManager);
		Locator.releaseEnemyManager(enemyManager);
		Locator.releaseGameHUD(gameHUD);
	}

	override public function update():Void
	{
		super.update();

		if(FlxG.keys.justPressed.P)
			this.openSubState(new PauseState());
	}

	function onPlayerDied():Void
	{
		this.openSubState(new GameOverState());
	}
}
