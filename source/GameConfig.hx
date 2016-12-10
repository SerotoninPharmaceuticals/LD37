package ;

class GameConfig {
  public static var debugMode:Bool = true;
  public static var elapsedEachDay:Float = debugMode ? 5 : 60;
  public static var totalDays:Int = 3000;

  public static var roomWidth = 100;
  public static var roomHeight = 100;

  public static var roomX = 600 / 2 - roomWidth / 2;
  public static var roomY = 600 / 2 - roomHeight / 2;
  public static var roomRight = 600 / 2 + roomWidth / 2;
  public static var roomBottom = 600 / 2 + roomHeight / 2;

  public static var bedX = roomX + 0;
  public static var bedY = roomY + 0;

  public static var initialStrength:Float = 100;

  public static var strengthReduceEachDay:Float = 1;
}
