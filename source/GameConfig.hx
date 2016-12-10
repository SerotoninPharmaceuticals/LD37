package ;

import flixel.util.FlxColor;
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

  public static var bedX = roomX + 0;
  public static var bedY = roomY + 0;

  // Status
  public static var initialFood:Float = 10;
  public static var foodReduceEachDay:Float = 1;

  public static var initialTiredness:Float = 10;
  public static var tirednessReduceEachDay:Float = 1;
  public static var tirednessGainWhenSleepInDay:Float = 2;
}
