package ;
class GameConfig {
  public static var debugMode:Bool = true;
  public static var elapsedEachDay:Float = debugMode ? 5 : 60;
  public static var totalDays:Int = 3000;

  public static var initialStrength:Float = 100;

  public static var strengthReduceEachDay:Float = 1;
}
