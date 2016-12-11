package ;

import flixel.util.FlxColor;

typedef LifeObjectConfig = {
  @:optional var x:Float;
  @:optional var y:Float;
  @:optional var hitboxOffsetX:Float;
  @:optional var hitboxOffsetY:Float;
  @:optional var normal:String;
  @:optional var hitbox:String;
  @:optional var highlight:String;
};


class GameConfig {
  public static var debugMode:Bool = true;

  // Color
  public static var textWhite = FlxColor.WHITE;
  public static var textGray = FlxColor.GRAY;

  // Time
  public static var elapsedEachDay:Float = debugMode ? 5 : 60;
  public static var totalDays:Int = 3000;

  // Size
  public static var roomWidth = 80;
  public static var roomHeight = 79;
  public static var statusDotHeight = 4;
  public static var statusDotWidth = 2;
  public static var statusDotSpace = 2;
  public static var statusDotCount = 10;

  // Position
  public static var roomX = 600 / 2 - roomWidth / 2;
  public static var roomY = 600 / 2 - roomHeight / 2;
  public static var roomRight = 600 / 2 + roomWidth / 2;
  public static var roomBottom = 600 / 2 + roomHeight / 2;

  public static var dashboardX = roomRight + 6;
  public static var dashboardY = roomX;
  public static var statusLineHeight = 16;
  public static var statusTitleLineHeight = 5;

  public static var animationX = dashboardX;
  public static var animationY = dashboardY + statusLineHeight * 3 + 5;

  // Status
  // - food
  public static var foodTitleGeneratorSeed:Int = 105;
  public static var initialFood:Float = 10;
  public static var foodReduceEachDay:Float = 1;
  static var _foodGainEachEating:Float = 2;
  static var _eatingHour:Float = 0.3;
  public static var eatingDuration:Float = elapsedEachDay * _eatingHour / 24;
  public static var foodGainWhenEatingInDay:Float = _foodGainEachEating / eatingDuration * elapsedEachDay;

  // - bed
  public static var tirednessTitleGeneratorSeed:Int = 99;
  public static var initialTiredness:Float = 10;
  public static var tirednessReduceEachDay:Float = 1;
  static var _tirednessGainEachSleep:Float = 2;
  static var _sleepHour:Float = 3;
  public static var sleepingDuration:Float = elapsedEachDay * _sleepHour / 24;
  public static var tirednessGainWhenSleepInDay:Float = _tirednessGainEachSleep / sleepingDuration * elapsedEachDay;

  // - water
  public static var initialWater:Float = 10;
  public static var waterReduceEachDay:Float = 1;
  static var _waterGainEachDrinking:Float = 2;
  static var _drinkHour:Float = 0.3;
  public static var waterTitleGeneratorSeed:Int = 80;
  public static var drinkingDuration:Float = elapsedEachDay * _sleepHour / 24;
  public static var waterGainWhenDrinkingInDay:Float = _waterGainEachDrinking / drinkingDuration * elapsedEachDay;

  // - toilet
  public static var toiletTitleGeneratorSeed:Int = 120;
  public static var initialToilet:Float = 10;
  public static var toiletReduceEachDay:Float = 1;
  static var _toiletGainEachDrinking:Float = 2;
  static var _toiletHour:Float = 0.3;
  public static var toiletingDuration:Float = elapsedEachDay * _sleepHour / 24;
  public static var toiletGainWhenToiletingInDay:Float = _toiletGainEachDrinking / toiletingDuration * elapsedEachDay;


  // - reading
  static var _readingHour:Float = 0.3;
  public static var readingDuration:Float = elapsedEachDay * _readingHour / 24;

  public static var bed:LifeObjectConfig = {
    x: 3,
    y: 3,
    hitboxOffsetX: 8,
    hitboxOffsetY: 4,
    normal: "assets/images/bed_highlight.png",
    hitbox: "assets/images/bed_highlight.png",
    highlight: "assets/images/bed_highlight.png"
  };

  public static var food:LifeObjectConfig = {
    x: 28,
    y: 73,
    hitboxOffsetY: -4,
    normal: "assets/images/food_highlight.png",
    hitbox: "assets/images/food_highlight.png",
    highlight: "assets/images/food_highlight.png"
  };

  public static var water:LifeObjectConfig = {
    x: 3,
    y: 40,
    hitboxOffsetX: 4,
    normal: "assets/images/water_highlight.png",
    hitbox: "assets/images/water_highlight.png",
    highlight: "assets/images/water_highlight.png"
  };

  public static var toilet:LifeObjectConfig = {
    x: 3,
    y: 58,
    hitboxOffsetX: 4,
    normal: "assets/images/toilet_highlight.png",
    hitbox: "assets/images/toilet_highlight.png",
    highlight: "assets/images/toilet_highlight.png"
  };

  public static var newspaper:LifeObjectConfig = {
    x: 73,
    y: 38,
    hitboxOffsetX: -4,
    normal: "assets/images/newspaper_highlight.png",
    hitbox: "assets/images/newspaper_hitbox.png",
    highlight: "assets/images/newspaper_highlight.png"
  };
}
