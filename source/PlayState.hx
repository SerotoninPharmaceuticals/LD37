package;

import sprites.Dashboard;
import flixel.FlxSprite;
import sprites.Bed;
import sprites.Wall;
import flixel.FlxG;
import flixel.FlxState;
import sprites.Player;

class PlayState extends FlxState {
  var isPaused = true;
  var currentDay = 0;
  var sleptToday = false;
  var nearbyObject:FlxSprite;

  var player:Player;
  var wall:Wall;
  var bed:Bed;
  var dashboard:Dashboard;

  override public function create():Void {
    FlxG.mouse.useSystemCursor = true;
    super.create();

    GameData.load();
    if (GameConfig.debugMode) { GameData.reset(); }
    currentDay = getElapsedDays(GameData.data.elapsed);

    dashboard = new Dashboard();
    add(dashboard);

    wall = new Wall();
    add(wall);

    bed = new Bed(GameConfig.bedX, GameConfig.bedY);
    add(bed);

    loadPlayer();
  }

  public function detectObjects() {
    if (bed.checkHitbox(player.getPosition())) {
      nearbyObject = bed;
      bed.nearby(player);
      if (FlxG.keys.anyJustPressed([X])) {
        bed.action();
      }
    } else {
      nearbyObject = null;
      bed.alway();
    }
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);
    var totalElapsed = GameData.data.elapsed;
    totalElapsed += elapsed;

    FlxG.collide(player, wall);
    FlxG.collide(player, bed);

    detectObjects();

    var _currentDay = getElapsedDays(totalElapsed);
    if (_currentDay != currentDay) {
      resetDayState();
    }

    GameData.data.elapsed = totalElapsed;
    GameData.data.playerX = player.x;
    GameData.data.playerY = player.y;
    GameData.save();
  }

  function loadPlayer() {
    player = new Player(GameData.data.playerX, GameData.data.playerY);
    add(player);
    player.onSleep = function() {
      player.setPosition(bed.x + bed.width / 2, bed.y + bed.height / 2);
      GameData.data.isSleeping = true;
      GameData.data.sleptToday = true;
    }
    player.onWakeup = function() {
      player.setPosition(bed.x + bed.width / 2 - player.width / 2, bed.y + bed.height + 5);
      GameData.data.isSleeping = false;
    }
  }

  function resetDayState() {
    sleptToday = false;
    GameData.data.sleptToday = sleptToday;
  }

  function getElapsedToday(totalElapsed:Float):Float {
    return totalElapsed % GameConfig.elapsedEachDay;
  }

  function getElapsedDays(totalElapsed:Float):Int {
    return Math.floor(totalElapsed / GameConfig.elapsedEachDay);
  }
}
