package;

import openfl.display.BlendMode;
import openfl.display.BlendMode;
import sprites.RoomOverlay;
import sprites.ActionAnimation;
import GameData;
import sprites.Newspaper;
import sprites.Toilet;
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
  var nearbyObject:FlxSprite;

  var player:Player;
  var wall:Wall;
  var bed:Bed;
  var food:Food;
  var water:Water;
  var toilet:Toilet;
  var newspaper:Newspaper;
  var dashboard:Dashboard;
  var lifeObjects:FlxTypedGroup<LifeObject>;
  var actionAnimation:ActionAnimation;

  var colorOverlay:RoomOverlay;
  var shadowOverlay:RoomOverlay;
  var lightOverlay:RoomOverlay;

  override public function create():Void {
    FlxG.mouse.useSystemCursor = true;
    super.create();

    GameData.load();
    if (GameConfig.debugMode) { GameData.reset(); }
    currentDay = getElapsedDays(GameData.data.elapsed);

    var bg = new FlxSprite();
    bg.loadGraphic("assets/images/room.png");
    bg.screenCenter();

    wall = new Wall();

    dashboard = new Dashboard();

    bed = new Bed();
    bed.canAction = function():Bool { return !GameData.data.sleptToday && !player.getIsBusy(); }

    food = new Food();
    food.canAction = function():Bool { return !GameData.data.ateToday && !player.getIsBusy(); }

    water = new Water();
    water.canAction = function():Bool { return !GameData.data.drankToday && !player.getIsBusy(); }

    toilet = new Toilet();
    toilet.canAction = function():Bool { return !GameData.data.toiletedToday && !player.getIsBusy(); }

    newspaper = new Newspaper();
    toilet.canAction = function():Bool { return !player.getIsBusy(); }

    lifeObjects = new FlxTypedGroup<LifeObject>();
    lifeObjects.add(toilet);
    lifeObjects.add(water);
    lifeObjects.add(food);
    lifeObjects.add(newspaper);
    lifeObjects.add(bed);

    actionAnimation = new ActionAnimation();

    colorOverlay = new RoomOverlay("assets/images/roomAmbientColor.png");
    shadowOverlay = new RoomOverlay("assets/images/roomAmbientColor.png", BlendMode.MULTIPLY);
    lightOverlay = new RoomOverlay("assets/images/roomAmbientColor.png", BlendMode.OVERLAY);

    setupWatch();

    loadPlayer();

    add(wall);
//    add(bg);
    add(colorOverlay);

    add(bed);
    add(food);
    add(water);
    add(toilet);
    add(newspaper);

    add(player);

//    add(shadowOverlay);
//    add(lightOverlay);

    add(dashboard);
    add(actionAnimation);
  }

  function loadPlayer() {
    player = new Player(GameData.data.playerX, GameData.data.playerY);
    player.requestSleep = function(callback:Void->Void) {
      player.setPosition(bed.x + bed.width / 2, bed.y + bed.height / 2);
      GameData.data.isSleeping = true;
      GameData.data.sleptToday = true;
      callback();
    }
    player.requestWakeup = function(callback:Void->Void) {
      player.setPosition(bed.x + bed.width / 2 - player.width / 2, bed.y + bed.height + 5);
      GameData.data.isSleeping = false;
      callback();
    }
    player.requestToDrink = function(callback:Void->Void) {
      actionAnimation.animation.finishCallback = function(name:String) {
        actionAnimation.animation.finishCallback = null;
        callback();
        GameData.data.drankToday = true;
      }
      actionAnimation.playDrink();
    }
    player.requestToEat = function(callback:Void->Void) {
      actionAnimation.animation.finishCallback = function(name:String) {
        callback();
        GameData.data.ateToday = true;
      }
      actionAnimation.playEat();
    }
    player.requestToToilet = function(callback:Void->Void) {
      // TODO: get food
      callback();
      GameData.data.toiletedToday = true;
    }
    player.requestToRead = function(callback:Void->Void) {
      // TODO: get news
      callback();
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
      currentDay = _currentDay;
    }

    GameData.data.elapsed = totalElapsed;
    GameData.data.playerX = player.x;
    GameData.data.playerY = player.y;
    GameData.save();
  }

  function detectObjects() {
    nearbyObject = null;
    for(obj in lifeObjects) {
      if (obj.canAction() && obj.checkHitbox(player)) {
        nearbyObject = obj;
        obj.nearby(player);
        FlxG.watch.addQuick("nearby", obj);
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
    GameData.data.tiredness -= elapsedInDay * GameConfig.tirednessReduceEachDay;
    GameData.data.water -= elapsedInDay * GameConfig.waterReduceEachDay;
    GameData.data.toilet -= elapsedInDay * GameConfig.toiletReduceEachDay;

    if (player.isEating) {
      GameData.data.food += elapsedInDay * GameConfig.foodGainWhenEatingInDay;
    } else if (player.isSleeping){
      GameData.data.tiredness += elapsedInDay * GameConfig.tirednessGainWhenSleepInDay;
    } else if (player.isDrinking){
      GameData.data.water += elapsedInDay * GameConfig.waterGainWhenDrinkingInDay;
    } else if (player.isToileting){
      GameData.data.toilet += elapsedInDay * GameConfig.toiletGainWhenToiletingInDay;
    }
  }
  function resetDayState() {
    GameData.data.sleptToday = false;
    GameData.data.ateToday = false;
    GameData.data.drankToday = false;
    GameData.data.toiletedToday = false;
    FlxG.log.add("Day:" + getElapsedDays(GameData.data.elapsed));
  }

  function getElapsedToday(totalElapsed:Float):Float {
    return totalElapsed % GameConfig.elapsedEachDay;
  }

  function getElapsedDays(totalElapsed:Float):Int {
    return Math.floor(totalElapsed / GameConfig.elapsedEachDay);
  }

  function setupWatch() {
    if (GameConfig.debugMode) {
      FlxG.watch.add(GameData.data, 'toilet');
      FlxG.watch.add(GameData.data, 'tiredness');
      FlxG.watch.add(GameData.data, 'food');
      FlxG.watch.add(GameData.data, 'water');

      FlxG.watch.add(GameData.data, 'toiletedToday');
      FlxG.watch.add(GameData.data, 'sleptToday');
      FlxG.watch.add(GameData.data, 'ateToday');
      FlxG.watch.add(GameData.data, 'drankToday');

//      for(obj in lifeObjects) {
//        obj.hitbox.alpha = 0.5;
//        add(obj.hitbox);
//      }
    }
  }

}
