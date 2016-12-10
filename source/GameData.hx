package ;

import flixel.FlxG;
import flixel.util.FlxSave;

typedef Data = {
  var elapsed:Float;
  var playerX:Float;
  var playerY:Float;

  var strength:Float;

  var isSleeping:Bool;
  var sleepElapsed:Float;
  var sleptToday:Bool;

  @:optional var nothing:Bool;
};

class GameData {
  static function getDefaultData():Data {
    var defaultData:Data = {
      elapsed: 0,

      playerX: FlxG.width/2,
      playerY: FlxG.height/2,

      strength: GameConfig.initialStrength,

      isSleeping: false,
      sleepElapsed: 0,
      sleptToday: false,

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

}
