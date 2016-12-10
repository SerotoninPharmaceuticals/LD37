package;

import flixel.FlxGame;
import flixel.FlxG;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		FlxG.mouse.useSystemCursor = true;
		addChild(new FlxGame(0, 0, PlayState));
	}
}
