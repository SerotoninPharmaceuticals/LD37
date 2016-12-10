package ;

import flixel.util.FlxSave;

typedef Data = {
  var elapsed:Float;

  @:optional var nothing:Bool;
};

class GameData {
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
    gameSave.flush();
  }

  static function getDefaultData():Data {
    var defaultData:Data = {
      elapsed: 0
    };
    return defaultData;
  }

}
