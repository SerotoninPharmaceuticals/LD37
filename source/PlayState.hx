package;

import sprites.Water;
import sprites.LifeObject;
import flixel.group.FlxGroup;
import sprites.Food;
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
  var food:Food;
  var water:Water;
  var dashboard:Dashboard;
  var lifeObjects:FlxTypedGroup<LifeObject>;

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

    bed = new Bed();
    add(bed);

    food = new Food();
    add(food);

    water = new Water();
    add(water);

    lifeObjects = new FlxTypedGroup<LifeObject>();
    lifeObjects.add(food);
    lifeObjects.add(bed);
    lifeObjects.add(water);

    loadPlayer();
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

  override public function update(elapsed:Float):Void {
    super.update(elapsed);
    var totalElapsed = GameData.data.elapsed;
    totalElapsed += elapsed;

    FlxG.collide(player, wall);
    for(obj in lifeObjects) {
      FlxG.collide(player, obj);
    }

    detectObjects();
    updateStatuses(elapsed);

    var _currentDay = getElapsedDays(totalElapsed);
    if (_currentDay != currentDay) {
      resetDayState();
    }

    GameData.data.elapsed = totalElapsed;
    GameData.data.playerX = player.x;
    GameData.data.playerY = player.y;
    GameData.save();
  }

  function detectObjects() {
    nearbyObject = null;
    for(obj in lifeObjects) {
      if (obj.checkHitbox(player.getPosition())) {
        nearbyObject = obj;
        obj.nearby(player);
        if (FlxG.keys.anyJustPressed([X])) {
          obj.action();
        }
        break;
      }
    }
    for(obj in lifeObjects) {
      if (nearbyObject != obj) {
        obj.alway();
      }
    }

  }

  function updateStatuses(elapsed:Float) {
    var elapsedInDay = elapsed / GameConfig.elapsedEachDay;

    // Food
    GameData.data.food -= elapsedInDay * GameConfig.foodReduceEachDay;

    // Tiredness
    if (player.isSleeping) {
      GameData.data.tiredness += elapsedInDay * GameConfig.tirednessGainWhenSleepInDay;
    } else {
      GameData.data.tiredness -= elapsedInDay * GameConfig.tirednessReduceEachDay;
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
