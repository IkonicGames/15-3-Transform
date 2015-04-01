package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.addons.ui.FlxUIButton;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import openfl.Lib;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	var playButton:FlxUIButton;

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();

		playButton = cast add(new FlxUIButton(FlxG.width / 2, FlxG.height / 2, "Play", onPlayClicked));
		playButton.x -= playButton.width / 2;

		var title = new FlxText(0, FlxG.height * 0.3, FlxG.width, "Zombie Bonus Round", 32);
		title.alignment = "center";
		this.add(title);
		var tween = FlxTween.tween(title.scale, {x:1.1, y:1.1}, 0.5, {type:FlxTween.PINGPONG, ease:FlxEase.sineInOut});

		var creditsButton = new FlxUIButton(FlxG.width / 2, FlxG.height * 0.75, "Music: LestatV3 - 12 5 13 Golias", onMusicClicked);
		creditsButton.resize(300, 25);
		creditsButton.getLabel().size = 12;
		creditsButton.x -= creditsButton.width / 2;
		this.add(creditsButton);
	}

	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}	

	function onPlayClicked():Void
	{
		FlxG.switchState(new PlayState());
	}

	function onMusicClicked():Void
	{
		Lib.getURL(new flash.net.URLRequest("https://soundcloud.com/lestatv3/12-05-13-golias"));
	}
}
