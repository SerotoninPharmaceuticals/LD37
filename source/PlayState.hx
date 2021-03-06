package;

import flixel.text.FlxText;
import sprites.FinishedScreen;
import sprites.Door;
import flixel.util.FlxSpriteUtil;
import sprites.TitleScreen;
import sprites.NewsReader;
import sprites.ShadowOverlay;
import flixel.util.FlxTimer;
import openfl.display.BlendMode;
import sprites.RoomOverlay;
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
  var isStarting = true;
  var isPausing = false;
  var isGameOver = false;
  var isGameFinished = false;
  var hasShownFinishedTitle = false;

  var currentDay = 0;
  var readyObject:FlxSprite;
  var toiletSound:FlxSound;
  var ambientSound:FlxSound;
  var pressSound: FlxSound;
  var doorSound: FlxSound;
  
  var blackScreen:FlxSprite;
  var titleScreen:TitleScreen;
  var gameoverScreen:FlxSprite;

  var player:Player;
  var wall:Wall;
  var bed:Bed;
  var food:Food;
  var water:Water;
  var toilet:Toilet;
  var newspaper:Newspaper;
  var dashboard:Dashboard;
  var lifeObjects:FlxTypedGroup<LifeObject>;
  var newsReader:NewsReader;
  var door:Door;

  var colorOverlay:RoomOverlay;
  var shadowOverlay:ShadowOverlay;
  var lightOverlay:RoomOverlay;
  var colliders: Array<FlxSprite>;
  
  var existChange:Float;
  var isExisting = false;

  override public function create():Void {
    FlxG.mouse.useSystemCursor = true;
    super.create();

    GameData.load();
    if (GameConfig.debugMode) { GameData.reset(); }

    loadSound();

    currentDay = getElapsedDays(GameData.data.elapsed);

    blackScreen = new FlxSprite(GameConfig.roomImgX + 4, GameConfig.roomImgY + 4);
    blackScreen.makeGraphic(GameConfig.roomImgWidth - 8, GameConfig.roomImgHeight - 8, GameConfig.blackScreen);
    titleScreen = new TitleScreen();

    wall = new Wall();

    dashboard = new Dashboard();
    newsReader = new NewsReader();
    door = new Door();

    bed = new Bed();
    bed.canAction = function():Bool { return bed.checkFacing(player) && !player.getIsBusy() && bed.isFresh; }

    food = new Food();
    food.canAction = function():Bool { return !GameData.data.ateToday && food.checkFacing(player) && !player.getIsBusy() && food.isFresh; }

    water = new Water();
    water.canAction = function():Bool { return !GameData.data.drankToday && water.checkFacing(player) && !player.getIsBusy() && water.isFresh; }

    toilet = new Toilet();
    toilet.canAction = function():Bool { return toilet.checkFacing(player) && !player.getIsBusy() && toilet.isFresh; }

    newspaper = new Newspaper();
    newspaper.canAction = function():Bool { return !player.getIsBusy() && newspaper.checkFacing(player) && newspaper.isFresh; }

    lifeObjects = new FlxTypedGroup<LifeObject>();
    lifeObjects.add(toilet);
    lifeObjects.add(water);
    lifeObjects.add(food);
    lifeObjects.add(newspaper);
    lifeObjects.add(bed);

    colorOverlay = new RoomOverlay("assets/images/roomAmbientColor.png");
    shadowOverlay = new ShadowOverlay([
      0.80, 0.80, 0.78, 0.78, 0.75, 0.70,
      0.72, 0.65, 0.60, 0.60, 0.55, 0.48,
      0.48, 0.48, 0.55, 0.58, 0.62, 0.66,
      0.70, 0.75, 0.80, 0.78, 0.81, 0.83
    ], 84, 84);

    lightOverlay = new RoomOverlay("assets/images/roomLighting.png", 84, 84, true, BlendMode.OVERLAY);

    loadPlayer();

    add(wall);

    add(colorOverlay);
    add(door);

    add(player);
    add(bed.bedHead);

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
    add(newsReader);

    add(blackScreen);
    add(titleScreen);

    setupWatch();

    FlxG.watch.add(this, 'colliders');

    colliders = [wall];
    for(obj in lifeObjects) {
      colliders.push(obj);
    }
  }

  function loadSound() {
    #if flash
    toiletSound = FlxG.sound.load("assets/sounds/toilet.mp3", 0.8);
    ambientSound = FlxG.sound.load("assets/sounds/bg.mp3", 1, true);
    pressSound = FlxG.sound.load("assets/sounds/keypress.mp3", 1);
    doorSound = FlxG.sound.load("assets/sounds/dooropen.mp3", 0.65);
    #else
    toiletSound = FlxG.sound.load("assets/sounds/toilet.ogg", 0.8);
    ambientSound = FlxG.sound.load("assets/sounds/bg.ogg", 1, true);
    pressSound = FlxG.sound.load("assets/sounds/keypress.ogg", 1);
    #end
    ambientSound.play();
  }

  function loadPlayer() {
    player = new Player(GameConfig.playerX, GameConfig.playerY);
    player.requestSleep = function(callback:Void->Void) {
      fadeBlackScreen(0.2, 0.6, function() {
        callback();
        GameData.data.sleptToday = true;
      }, function() {
        bed.goBed(player);
      });
    }
    player.requestWakeup = function(callback:Void->Void) {
      if(!isGameOver) fadeBlackScreen(0.2, 0.8, function() {
        callback();
      }, function() {
        bed.leaveBed(player);
      });
    }
    player.requestToDrink = function(callback:Void->Void) {
      water.turnOffLuminosity();
      callback();
      GameData.data.drankToday = true;
    }
    player.requestToEat = function(callback:Void->Void) {
      food.turnOffLuminosity();
      callback();
      GameData.data.ateToday = true;
    }
    player.requestToToilet = function(callback:Void->Void) {
      fadeBlackScreen(0.3, 0.6, function() {
        if(!isGameOver) toiletSound.play();
        callback();
        GameData.data.toiletedToday = true;
      });
    }
    player.requestToRead = function(callback:Void->Void) {
      newsReader.showNews();
      callback();
    }
  }

  function fadeBlackScreen(fadeDuration:Float, blackDuration:Float, onFinished:Void -> Void, onBlack:Void -> Void = null) {
    blackScreen.revive();
    FlxSpriteUtil.fadeIn(blackScreen, fadeDuration, true, function(t) {
      if (onBlack == null) { return; }
      onBlack();
    });
    var timer = new FlxTimer();
    timer.start(blackDuration, function(t) {
      FlxSpriteUtil.fadeOut(blackScreen, fadeDuration, function(t) {
        blackScreen.kill();
        blackScreen.alpha = 1;
        onFinished();
      });
    });
  }

  override public function update(elapsed:Float):Void {
    if (isPausing) { return; }
    if (isStarting) {
      titleScreen.updateWhenPause(elapsed);
      if (FlxG.keys.anyJustPressed([X])) {
        pressSound.play();
        blackScreen.kill();
        titleScreen.hideInStartScreen();
        isStarting = false;
      }
      return;
    }
    if (isGameOver) {
      if (FlxG.keys.anyJustPressed([R])) {
        pressSound.play();
        var hideGameoverScreen = new FlxSprite(blackScreen.x, blackScreen.y);
        hideGameoverScreen.loadGraphicFromSprite(blackScreen);
        add(hideGameoverScreen);
        FlxSpriteUtil.fadeIn(hideGameoverScreen, 0.6, true);
        var timer = new FlxTimer();
        timer.start(0.8, function(t) {
          GameData.reset();
          FlxG.resetGame();
        });
      }
      return;
    }
    if (isGameFinished) {
      if (!hasShownFinishedTitle && !player.overlaps(colorOverlay)) {
        hasShownFinishedTitle = true;
        showFinishedTitle();
      }
    }

    super.update(elapsed);
    var totalElapsed = GameData.data.elapsed;
    totalElapsed += elapsed;

    for(obj in colliders) {
      FlxG.collide(player, obj);
    }

    detectObjects();

    if (!isGameFinished) {
      updateStatuses(elapsed);

      var _currentDay = getElapsedDays(totalElapsed);

      GameData.data.elapsed = totalElapsed;

      if (_currentDay != currentDay) {
        currentDay = _currentDay;
        if (currentDay == GameConfig.totalDays + 1) {
          finishGame();
          FlxG.log.add("Game finished");
        } else {
          resetDayState();
        }
      }
    }
  }

  function detectObjects() {
    readyObject = null;
    var nearbyObject:LifeObject = null;
    lifeObjects.forEach(function(obj:LifeObject) {
      if (obj.checkHitbox(player) && obj.config.playerFacing == player.facing) {
        nearbyObject = obj;
        if (obj.canAction()) {
          readyObject = obj;
          obj.readyForAction(player);
          FlxG.watch.addQuick("nearby", obj);
          if (FlxG.keys.anyJustPressed([X])) {
            obj.action();
          }
        }
      }
    });
    lifeObjects.forEach(function(obj:LifeObject) {
      if (readyObject != obj) {
        obj.notReadyForAction();
      }
      if (nearbyObject != obj) {
        obj.isFresh = true;
      }
    });
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
    
    if (isExisting){
      GameConfig.currentExist -= elapsed * existChange / GameConfig.existingDuration;
    }
	
    food = Math.max(-1, Math.min(GameConfig.initialFood, food));
    water = Math.max(-1, Math.min(GameConfig.initialWater, water));
    tiredness = Math.max(-1, Math.min(GameConfig.initialTiredness, tiredness));
    toilet = Math.max(-1, Math.min(GameConfig.initialToilet, toilet));

    GameData.data.food = food;
    GameData.data.tiredness = tiredness;
    GameData.data.water = water;
    GameData.data.toilet = toilet;

    if (
      food <= GameConfig.statusValueToDie ||
      water <= GameConfig.statusValueToDie ||
      tiredness <= GameConfig.statusValueToDie ||
      toilet <= GameConfig.statusValueToDie
    ) {
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

    titleScreen.showDay();
    titleScreen.fadeIn(0.5);
    var timer = new FlxTimer();
    timer.start(1.5, function(t) {
      titleScreen.fadeOut(0.5);
    });

    setupAmbientSoundForToday();

    FlxG.log.add("Day:" + getElapsedDays(GameData.data.elapsed));
    GameData.save();
  }

  function gameover() {
    FlxG.log.add("over");
    blackScreen.kill();
    titleScreen.kill();
    gameoverScreen = new FlxSprite();
    gameoverScreen.loadGraphic("assets/images/gameover.png");
    gameoverScreen.screenCenter();
    add(gameoverScreen);
    isGameOver = true;
    FlxSpriteUtil.fadeIn(gameoverScreen, 0.3, true, function(t) {
      player.isGameOver = true;
      dashboard.gameover();
    });
  }

  function finishGame() {
    isGameFinished = true;
    door.open();
    doorSound.play();
    wall.open();
    var timer = new FlxTimer();
    timer.start(1.5, function(t) {
      shadowOverlay.open();
      lightOverlay.open();
    });
  }

  function setupAmbientSoundForToday() {
    var random = Math.random();
    FlxG.log.add(random);
    if (random < 0.35) {
      FlxG.log.add("will play sound at:");
      var ambientSound = FlxG.sound.load(
        GameConfig.ambientSounds[Math.round(Math.random() * (GameConfig.ambientSounds.length - 1))],
        0.8
      );
      var timer = new FlxTimer();
      var delay = (Math.random() * 0.5 + 0.2) * GameConfig.elapsedEachDay;
      FlxG.log.add(delay);
      timer.start(delay, function(t) {
        ambientSound.play();
        isExisting = true;
        existChange = GameConfig.currentExist - (1 + Math.random() * 8);
        var timer = new FlxTimer();
        timer.start(GameConfig.existingDuration, function(t) {
          isExisting = false;
        });
      });
    }
  }

  function showFinishedTitle() {
    var screen = new FinishedScreen();
    add(screen);
    remove(player);
    screen.add(player);
    colliders = screen.colliders;
  }

  function getElapsedToday(totalElapsed:Float):Float {
    return totalElapsed % GameConfig.elapsedEachDay;
  }

  function getElapsedDays(totalElapsed:Float):Int {
    return Math.floor(totalElapsed / GameConfig.elapsedEachDay);
  }

  function setupWatch() {
//    FlxG.watch.add(GameData.data, 'toilet');
//    FlxG.watch.add(GameData.data, 'tiredness');
//    FlxG.watch.add(GameData.data, 'food');
//    FlxG.watch.add(GameData.data, 'water');
//
//    FlxG.watch.add(GameData.data, 'toiletedToday');
//    FlxG.watch.add(GameData.data, 'sleptToday');
//    FlxG.watch.add(GameData.data, 'ateToday');
//    FlxG.watch.add(GameData.data, 'drankToday');

//      for(obj in lifeObjects) {
//        obj.hitbox.alpha = 0.5;
//        add(obj.hitbox);
//      }
  }

}
