
package states;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.ui.FlxButton;
import flixel.text.FlxText;

class GameOverState extends FlxSubState
{
	function new()
	{
		super();

		var button:FlxButton = new FlxButton(FlxG.width * 0.6, FlxG.height * 0.6, "Play Again", onPlayAgain);
		button.scrollFactor.set(0, 0);
		this.add(button);

		var text:FlxText = new FlxText(0, FlxG.height / 3, FlxG.width, "Game Over", 24);
		text.alignment = "center";
		text.scrollFactor.set(0, 0);
		this.add(text);

		text = new FlxText(FlxG.width * 0.2, FlxG.height * 0.55, FlxG.width * 0.2, "Score", 24);
		text.alignment = "center";
		text.scrollFactor.set(0, 0);
		this.add(text);

		text = new FlxText(FlxG.width * 0.2, FlxG.height * 0.6, FlxG.width * 0.2, Std.string(Locator.scoreManager.score), 24);
		text.alignment = "center";
		text.scrollFactor.set(0, 0);
		this.add(text);
	}
	
	function onPlayAgain():Void
	{
		FlxG.resetState();
		// FlxG.switchState(new PlayState());
	}
}