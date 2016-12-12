package sprites;
import GameConfig;
import flixel.FlxG;

class Bed extends LifeObject {
  public function new() {
    super(GameConfig.bed);
  }

  override public function action():Void {
    FlxG.log.add("bed action");
    nearbyPlayer.sleep();
  }
}
