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
  static var _sleepHour:Float = 8;
  public static var sleepDuration:Float = elapsedEachDay * _sleepHour / 24;

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

  // Status
  public static var initialFood:Float = 10;
  public static var foodReduceEachDay:Float = 1;
  public static var foodTitleGeneratorSeed:Int = 105;

  public static var initialTiredness:Float = 10;
  public static var tirednessReduceEachDay:Float = 1;
  public static var tirednessGainWhenSleepInDay:Float = 2;
  public static var tirednessTitleGeneratorSeed:Int = 99;

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
    x: 74,
    y: 38,
    hitboxOffsetX: -3,
    normal: "assets/images/newspaper_highlight.png",
    hitbox: "assets/images/newspaper_highlight.png",
    highlight: "assets/images/newspaper_highlight.png"
  };
}
