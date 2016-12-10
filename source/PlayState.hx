package;

import flixel.FlxG;
import flixel.FlxState;

class PlayState extends FlxState {
  var isPaused = true;
  var currentDay = 0;
  var player:Player;

  override public function create():Void {
    FlxG.mouse.useSystemCursor = true;
    super.create();
    GameData.load();
    FlxG.log.add(GameData.data.elapsed);

    player = new Player(FlxG.width/2, FlxG.height/2);
    add(player);
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);

    var totalElapsed = GameData.data.elapsed;
    totalElapsed += elapsed;
    GameData.data.elapsed = totalElapsed;

    FlxG.log.add(getElapsedDays(totalElapsed));
    FlxG.log.add(getElapsedToday(totalElapsed));

    GameData.save();
  }

  function getElapsedToday(totalElapsed:Float):Float {
    return totalElapsed % GameConfig.elapsedEachDay;
  }

  function getElapsedDays(totalElapsed:Float):Float {
    return Math.floor(totalElapsed / GameConfig.elapsedEachDay);
  }
}
