package ;

import flixel.FlxObject;
import flixel.util.FlxColor;

typedef LifeObjectConfig = {
  @:optional var x:Float;
  @:optional var y:Float;
  @:optional var hitboxOffsetX:Float;
  @:optional var hitboxOffsetY:Float;
  @:optional var luminosityOffsetX:Float;
  @:optional var luminosityOffsetY:Float;
  @:optional var normal:String;
  @:optional var hitbox:String;
  @:optional var highlight:String;
  @:optional var luminosity:String;
  @:optional var playerFacing:Int;
};


class GameConfig {
  public static var debugMode:Bool = false;

  // Color
  public static var textWhite = FlxColor.WHITE;
  public static var textGray:FlxColor = 0xFF313131;
  public static var blackScreen:FlxColor = 0xFF101010;
  public static var shadowOverlay:FlxColor = 0xFF1E1F20;
  public static var statusRed:FlxColor = 0xFF9C2A46;

  // Time
  public static var elapsedEachDay:Float = debugMode ? 2 : 60;
  public static var totalDays:Int = 36523;

  // Size
  public static var roomImgWidth = 84;
  public static var roomImgHeight= 84;
  public static var roomWidth = 80;
  public static var roomHeight = 79;
  public static var statusLineHeight = 15;
  public static var statusTitleLineHeight = 4;
  public static var statusDotHeight = 5;
  public static var statusDotWidth = 2;
  public static var statusDotSpace = 2;
  public static var statusDotCount = 13;
  public static var newsReaderWidth = 160;

  // Position
  public static var roomImgX = 600 / 2 - roomImgWidth / 2;
  public static var roomImgY = 600 / 2 - roomImgHeight / 2;
  public static var roomX = 600 / 2 - roomWidth / 2;
  public static var roomY = 600 / 2 - roomHeight / 2;
  public static var roomRight = 600 / 2 + roomWidth / 2;
  public static var roomBottom = 600 / 2 + roomHeight / 2;

  public static var playerX = roomX + roomWidth / 2 + 4;
  public static var playerY = roomY + roomHeight / 2 + 4;

  public static var dashboardX = roomRight + 8;
  public static var dashboardY = roomImgY + 3;

  public static var animationX = dashboardX;
  public static var animationY = dashboardY + statusLineHeight * 4 + 3;

  public static var newsReaderX = roomImgX - 9;
  public static var newsReaderY = roomBottom + 10;

  // Status
  // - food
  public static var foodTitleGeneratorSeed:Int = 105;
  public static var initialFood:Float = 10;
  public static var foodReduceEachDay:Float = 3;
  static var _foodGainEachEating:Float = 3;
  static var _eatingHour:Float = 0.3;
  public static var eatingDuration:Float = 2.4;
  public static var foodGainWhenEatingInElapsed:Float = _foodGainEachEating / eatingDuration;

  // - bed
  public static var tirednessTitleGeneratorSeed:Int = 99;
  public static var initialTiredness:Float = 10;
  public static var tirednessReduceEachDay:Float = 2;
  static var _tirednessGainEachSleep:Float = 2;
  static var _sleepHour:Float = 8;
  public static var sleepingDuration:Float = elapsedEachDay * _sleepHour / 24;
  public static var tirednessGainWhenSleepInElapsed:Float = _tirednessGainEachSleep / sleepingDuration;

  // - water
  public static var initialWater:Float = 10;
  public static var waterReduceEachDay:Float = 2;
  static var _waterGainEachDrinking:Float = 2;
  static var _drinkHour:Float = 0.3;
  public static var waterTitleGeneratorSeed:Int = 80;
  public static var drinkingDuration:Float = 2.4;
  public static var waterGainWhenDrinkingInElapsed:Float = _waterGainEachDrinking / drinkingDuration;

  // - toilet
  public static var toiletTitleGeneratorSeed:Int = 120;
  public static var initialToilet:Float = 10;
  public static var toiletReduceEachDay:Float = 2;
  static var _toiletGainEachToilting:Float = 3;
  static var _toiletHour:Float = 0.3;
  public static var toiletingDuration:Float = 1.2;
  public static var toiletGainWhenToiletingInElapsed:Float = _toiletGainEachToilting / toiletingDuration;

  public static var statusValueToDie = -0.1;


  // - reading
//  static var _readingHour:Float = 0.3;
//  public static var readingDuration:Float = elapsedEachDay * _readingHour / 24;
  public static var readingDuration:Float = 5;

  public static var bed:LifeObjectConfig = {
    x: 3,
    y: 4,
    hitboxOffsetX: 0,
    hitboxOffsetY: 2,
    luminosityOffsetX: 8,
    luminosityOffsetY: 4,
    normal: "assets/images/bed_highlight.png",
    hitbox: "assets/images/bed_highlight.png",
    highlight: "assets/images/bed_highlight.png",
    playerFacing: FlxObject.UP
  };

  public static var food:LifeObjectConfig = {
    x: 27,
    y: 73,
    hitboxOffsetX: -2,
    hitboxOffsetY: -2,
	luminosityOffsetX: -1,
    luminosityOffsetY: -5,
    normal: "assets/images/food_highlight.png",
    hitbox: "assets/images/food_highlight.png",
    highlight: "assets/images/food_highlight.png",
    luminosity: "assets/images/food_luminosity.png",
    playerFacing: FlxObject.DOWN
  };

  public static var water:LifeObjectConfig = {
    x: 3,
    y: 41,
    hitboxOffsetX: 2,
	hitboxOffsetY: 1,
    luminosityOffsetY: -2,
    normal: "assets/images/water_highlight.png",
    hitbox: "assets/images/water_highlight.png",
    highlight: "assets/images/water_highlight.png",
    luminosity: "assets/images/water_luminosity.png",
    playerFacing: FlxObject.LEFT
  };

  public static var toilet:LifeObjectConfig = {
    x: 3,
    y: 59,
    hitboxOffsetX: 4,
    normal: "assets/images/toilet_highlight.png",
    hitbox: "assets/images/toilet_highlight.png",
    highlight: "assets/images/toilet_highlight.png",
    playerFacing: FlxObject.LEFT
  };

  public static var newspaper:LifeObjectConfig = {
    x: 73,
    y: 39,
    hitboxOffsetX: -2,
    luminosityOffsetX: -13,
    normal: "assets/images/newspaper_highlight.png",
    hitbox: "assets/images/newspaper_hitbox.png",
    highlight: "assets/images/newspaper_highlight.png",
    luminosity: "assets/images/newspaper_luminosity.png",
    playerFacing: FlxObject.RIGHT
  };
}
