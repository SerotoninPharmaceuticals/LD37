package ;

import flixel.FlxG;
import GameConfig;
import flixel.util.FlxSave;

typedef Data = {
  var elapsed:Float;

  var food:Float;
  var water:Float;
  var toilet:Float;
  var tiredness:Float;

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

      food: GameConfig.initialFood,
      water: GameConfig.initialWater,
      toilet: GameConfig.initialToilet,
      tiredness: GameConfig.initialTiredness,

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
      data = getDefaultData();
//      gameSave.data.gameData = getDefaultData();
    } else {
      loadData();
    }
  }

  static public function loadData() {
    data = {
      elapsed: gameSave.data.gameData.elapsed,

      food: gameSave.data.gameData.food,
      water: gameSave.data.gameData.water,
      toilet: gameSave.data.gameData.toilet,
      tiredness: gameSave.data.gameData.tiredness,

      sleptToday: gameSave.data.gameData.sleptToday,
      ateToday: gameSave.data.gameData.ateToday,
      drankToday: gameSave.data.gameData.drankToday,
      toiletedToday: gameSave.data.gameData.toiletedToday
    };
  }
  static function saveData() {
    gameSave.data.gameData.elapsed = data.elapsed;

    gameSave.data.gameData.food = data.food;
    gameSave.data.gameData.water = data.water;
    gameSave.data.gameData.toilet = data.toilet;
    gameSave.data.gameData.tiredness = data.tiredness;

    gameSave.data.gameData.sleptToday = data.sleptToday;
    gameSave.data.gameData.ateToday = data.ateToday;
    gameSave.data.gameData.drankToday = data.drankToday;
    gameSave.data.gameData.toiletedToday = data.toiletedToday;
  }

  static public function save() {
    saveData();
    #if !flash
    gameSave.flush();
    #end
  }

  static public function reset() {
    gameSave.data.gameData = getDefaultData();
    loadData();
  }

  static public function getElapsedToday():Float {
    return data.elapsed % GameConfig.elapsedEachDay;
  }
  static public function getElapsedDays():Int {
    return Math.floor(data.elapsed / GameConfig.elapsedEachDay);
  }

  // Including today.
  static public function getLeftDays():Int {
    return Math.ceil(GameConfig.totalDays - data.elapsed / GameConfig.elapsedEachDay);
  }

}
