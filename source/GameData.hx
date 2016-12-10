package ;

import flixel.util.FlxSave;

typedef Data = {
  var elapsed:Float;
  var strength:Float;

  @:optional var nothing:Bool;
};

class GameData {
  public static var data:Data;

  static var gameSave:FlxSave;

  static public function load() {
    gameSave = new FlxSave();
    gameSave.bind("Main");

    if (gameSave.data.gameData == null) {
      reset();
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
  }

  static function getDefaultData():Data {
    var defaultData:Data = {
      elapsed: 0,
      strength: GameConfig.initialStrength
    };
    return defaultData;
  }

}
