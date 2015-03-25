
package states;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.ui.FlxButton;

class GameOverState extends FlxSubState
{
	var playAgainBtn:FlxButton;

	function new()
	{
		super();

		playAgainBtn = new FlxButton(30, 100, "Play Again", onPlayAgain);
		this.add(playAgainBtn);
	}
	
	function onPlayAgain():Void
	{
		FlxG.switchState(new PlayState());
	}
}