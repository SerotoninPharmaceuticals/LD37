package;

import flixel.util.FlxSpriteUtil;
import sprites.TitleScreen;
import sprites.NewsReader;
import sprites.ShadowOverlay;
import flixel.util.FlxTimer;
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
import flixel.system.FlxSound;

class PlayState extends FlxState {
  var isPausing = true;
  var isGameOver = false;
  var currentDay = 0;
  var nearbyObject:FlxSprite;
  var toiletSound:FlxSound;
  var ambientSound:FlxSound;

  var blackScreen:FlxSprite;
  var titleScreen:TitleScreen;

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
  var newsReader:NewsReader;

  var colorOverlay:RoomOverlay;
  var shadowOverlay:ShadowOverlay;
  var lightOverlay:RoomOverlay;

  override public function create():Void {
    FlxG.mouse.useSystemCursor = true;
    super.create();

    GameData.load();
    loadSound();
    if (GameConfig.debugMode) { GameData.reset(); }
    currentDay = getElapsedDays(GameData.data.elapsed);

    blackScreen = new FlxSprite(GameConfig.roomImgX, GameConfig.roomImgY);
    blackScreen.makeGraphic(GameConfig.roomImgWidth, GameConfig.roomImgHeight, GameConfig.blackScreen);
    titleScreen = new TitleScreen();

    wall = new Wall();

    dashboard = new Dashboard();
    newsReader = new NewsReader();

    bed = new Bed();
    bed.canAction = function():Bool { return !GameData.data.sleptToday && bed.checkFacing(player) && !player.getIsBusy(); }

    food = new Food();
    food.canAction = function():Bool { return !GameData.data.ateToday && food.checkFacing(player) && !player.getIsBusy(); }

    water = new Water();
    water.canAction = function():Bool { return !GameData.data.drankToday && water.checkFacing(player) && !player.getIsBusy(); }

    toilet = new Toilet();
    toilet.canAction = function():Bool { return !GameData.data.toiletedToday && toilet.checkFacing(player) && !player.getIsBusy(); }

    newspaper = new Newspaper();
    newspaper.canAction = function():Bool { return !player.getIsBusy() && newspaper.checkFacing(player); }

    lifeObjects = new FlxTypedGroup<LifeObject>();
    lifeObjects.add(toilet);
    lifeObjects.add(water);
    lifeObjects.add(food);
    lifeObjects.add(newspaper);
    lifeObjects.add(bed);

    actionAnimation = new ActionAnimation();

    colorOverlay = new RoomOverlay("assets/images/roomAmbientColor.png");
    shadowOverlay = new ShadowOverlay([
      0.80, 0.80, 0.78, 0.78, 0.75, 0.70,
      0.72, 0.65, 0.60, 0.60, 0.55, 0.48,
      0.48, 0.48, 0.55, 0.58, 0.62, 0.66,
      0.70, 0.75, 0.80, 0.78, 0.81, 0.83
    ], 84, 84);

    lightOverlay = new RoomOverlay("assets/images/roomLighting.png", 84, 84, true, BlendMode.OVERLAY);

    setupWatch();

    loadPlayer();

    add(wall);
    add(colorOverlay);

    add(player);

    add(shadowOverlay);
    add(lightOverlay);

    add(food.luminosity);
    add(water.luminosity);
    add(newspaper.luminosity);
    add(bed);
    add(food);
    add(water);
    add(toilet);
    add(newspaper);

    add(dashboard);
    add(actionAnimation);
    add(newsReader);

    add(blackScreen);
    add(titleScreen);
  }

  function loadSound() {
    #if flash
    toiletSound = FlxG.sound.load("assets/sounds/toilet.mp3", 0.8);
    ambientSound = FlxG.sound.load("assets/sounds/bg.mp3", 1, true);
    #else
    toiletSound = FlxG.sound.load("assets/sounds/toilet.ogg", 0.8);
    ambientSound = FlxG.sound.load("assets/sounds/bg.ogg", 1, true);
    #end
    ambientSound.play();
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
        water.turnOffLuminosity();
        callback();
        GameData.data.drankToday = true;
      }
      actionAnimation.playDrink();
    }
    player.requestToEat = function(callback:Void->Void) {
      actionAnimation.animation.finishCallback = function(name:String) {
        food.turnOffLuminosity();
        callback();
        GameData.data.ateToday = true;
      }
      actionAnimation.playEat();
    }
    player.requestToToilet = function(callback:Void->Void) {
      blackScreen.revive();
      toiletSound.play();
      var timer = new FlxTimer();
      timer.start(0.3, function(t) {
        blackScreen.kill();
        callback();
        GameData.data.toiletedToday = true;
      });
    }
    player.requestToRead = function(callback:Void->Void) {
      callback();
      newsReader.showNews();
    }
  }

  override public function update(elapsed:Float):Void {
    if (isPausing) {
      if (FlxG.keys.anyJustPressed([X])) {
        FlxSpriteUtil.fadeOut(blackScreen, 0.5);
        titleScreen.fadeOut(0.5);
        isPausing = false;
      }
      return;
    }
    if (isGameOver) {
      if (FlxG.keys.anyJustPressed([R])) {
        GameData.reset();
        FlxG.resetGame();
      }
      return;
    }

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
    var food = GameData.data.food;
    var tiredness = GameData.data.tiredness;
    var water = GameData.data.water;
    var toilet = GameData.data.toilet;

    // Food
     food -= elapsedInDay * GameConfig.foodReduceEachDay;
     tiredness -= elapsedInDay * GameConfig.tirednessReduceEachDay;
     water -= elapsedInDay * GameConfig.waterReduceEachDay;
     toilet -= elapsedInDay * GameConfig.toiletReduceEachDay;

    if (player.isEating) {
      food += elapsed * GameConfig.foodGainWhenEatingInElapsed;
    } else if (player.isSleeping){
      tiredness += elapsed * GameConfig.tirednessGainWhenSleepInElapsed;
    } else if (player.isDrinking){
      water += elapsed * GameConfig.waterGainWhenDrinkingInElapsed;
    } else if (player.isToileting){
      toilet += elapsed * GameConfig.toiletGainWhenToiletingInElapsed;
    }

    food = Math.max(-1, Math.min(GameConfig.initialFood, food));
    water = Math.max(-1, Math.min(GameConfig.initialWater, water));
    tiredness = Math.max(-1, Math.min(GameConfig.initialTiredness, tiredness));
    toilet = Math.max(-1, Math.min(GameConfig.initialToilet, toilet));

    GameData.data.food = food;
    GameData.data.tiredness = tiredness;
    GameData.data.water = water;
    GameData.data.toilet = toilet;

    if (food == -1 || water == -1 || tiredness == -1 || toilet == -1) {
      gameover();
    }
  }
  function resetDayState() {
    GameData.data.sleptToday = false;
    GameData.data.ateToday = false;
    GameData.data.drankToday = false;
    GameData.data.toiletedToday = false;
    for(obj in lifeObjects) {
      obj.turnOnLuminosity();
    }

    FlxSpriteUtil.fadeIn(blackScreen, 0.5);
    titleScreen.showDay();
    titleScreen.fadeIn(0.5);
    var timer = new FlxTimer();
    timer.start(1, function(t) {
      FlxSpriteUtil.fadeOut(blackScreen, 0.5);
      titleScreen.fadeOut(0.5);
    });


    FlxG.log.add("Day:" + getElapsedDays(GameData.data.elapsed));
  }

  function gameover() {
    var gameoverScreen = new FlxSprite();
    gameoverScreen.loadGraphic("assets/images/gameover.png");
    gameoverScreen.screenCenter();
    add(gameoverScreen);
    isGameOver = true;
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
