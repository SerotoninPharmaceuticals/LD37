package;

import sprites.Bed;
import sprites.Wall;
import flixel.FlxG;
import flixel.FlxState;
import sprites.Player;

class PlayState extends FlxState {
  var isPaused = true;
  var currentDay = 0;
  var player:Player;
  var wall:Wall;
  var bed:Bed;

  override public function create():Void {
    FlxG.mouse.useSystemCursor = true;
    super.create();
    GameData.load();
    GameData.reset();
    player = new Player(GameData.data.playerX, GameData.data.playerY);
    add(player);

    wall = new Wall();
    add(wall);

    FlxG.log.add(FlxG.width);
    bed = new Bed(GameConfig.bedX, GameConfig.bedY);
    add(bed);
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);

    FlxG.collide(player, wall);
    FlxG.collide(player, bed);

    var totalElapsed = GameData.data.elapsed;
    totalElapsed += elapsed;
    GameData.data.elapsed = totalElapsed;

    GameData.save();
  }

  function getElapsedToday(totalElapsed:Float):Float {
    return totalElapsed % GameConfig.elapsedEachDay;
  }

  function getElapsedDays(totalElapsed:Float):Float {
    return Math.floor(totalElapsed / GameConfig.elapsedEachDay);
  }
}
