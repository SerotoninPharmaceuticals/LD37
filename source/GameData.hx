package ;

import GameConfig;
import flixel.FlxG;
import flixel.util.FlxSave;

typedef Data = {
  var elapsed:Float;
  var playerX:Float;
  var playerY:Float;

  var food:Float;
  var water:Float;
  var toilet:Float;
  var tiredness:Float;

  var isSleeping:Bool;
  var sleepElapsed:Float;
  var sleptToday:Bool;
  var ateToday:Bool;
  var drankToday:Bool;
  var toiletedToday:Bool;

  @:optional var nothing:Bool;
};

class GameData {
  static function getDefaultData():Data {
    var defaultData:Data = {
      elapsed: 0,

      playerX: FlxG.width/2,
      playerY: FlxG.height/2,

      food: GameConfig.initialFood,
      water: GameConfig.initialWater,
      toilet: GameConfig.initialToilet,
      tiredness: GameConfig.initialTiredness,

      isSleeping: false,
      sleepElapsed: 0,
      sleptToday: false,
      ateToday: false,
      drankToday: false,
      toiletedToday: false,

      nothing: false
    };
    return defaultData;
  }

  public static var data:Data;

  static var gameSave:FlxSave;

  static public function load() {
    gameSave = new FlxSave();
    gameSave.bind("Main");

    if (gameSave.data.gameData == null) {
      gameSave.data.gameData = getDefaultData();
    }
    data = gameSave.data.gameData;
  }

  static public function save() {
    #if !flash
    gameSave.flush();
    #end
  }

  static public function reset() {
    gameSave.data.gameData = getDefaultData();
    data = gameSave.data.gameData;
  }

  static public function getElapsedToday():Float {
    return data.elapsed % GameConfig.elapsedEachDay;
  }
  static public function getElapsedDays():Int {
    return Math.floor(data.elapsed / GameConfig.elapsedEachDay);
  }

  // Including today.
  static public function getLeftDays():Int {
    FlxG.log.add(data.elapsed);
    FlxG.log.add( GameConfig.elapsedEachDay);

    FlxG.log.add(data.elapsed / GameConfig.elapsedEachDay);
    return Math.ceil(GameConfig.totalDays - data.elapsed / GameConfig.elapsedEachDay);
  }

}
