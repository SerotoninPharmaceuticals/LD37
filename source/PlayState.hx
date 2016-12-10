package;

import flixel.FlxG;
import flixel.FlxState;

class PlayState extends FlxState
{
	override public function create():Void
	{
    FlxG.mouse.useSystemCursor = true;
    super.create();
    GameData.load();
    FlxG.log.add(GameData.data.elapsed);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
    GameData.data.elapsed += elapsed;
    #if !flash
    GameData.save();
    #end
	}
}
