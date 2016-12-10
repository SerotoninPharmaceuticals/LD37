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
  public static var roomWidth = 100;
  public static var roomHeight = 100;
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

  public static var initialTiredness:Float = 10;
  public static var tirednessReduceEachDay:Float = 1;
  public static var tirednessGainWhenSleepInDay:Float = 2;

  public static var bed:LifeObjectConfig = {
    x: 0,
    y: 0,
    normal: "assets/images/bed.png",
    hitbox: "assets/images/bed_hitbox.png",
    highlight: "assets/images/bed_highlight.png"
  };

  public static var food:LifeObjectConfig = {
    x: 70,
    y: 70,
    hitboxOffsetX: -30,
    normal: "assets/images/food.png",
    hitbox: "assets/images/food_hitbox.png",
    highlight: "assets/images/food_highlight.png"
  };

  public static var water:LifeObjectConfig = {
    x: 70,
    y: 38,
    hitboxOffsetX: -30,
    normal: "assets/images/water.png",
    hitbox: "assets/images/water_hitbox.png",
    highlight: "assets/images/water_highlight.png"
  };
}
