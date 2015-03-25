
package states;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.ui.FlxButton;


class PauseState extends FlxSubState
{

	function new()
	{
		super();

		add(new FlxButton(FlxG.width / 2, 100, "Resume", onResumeGame));
	}

	function onResumeGame():Void
	{
		this.close();
	}
}