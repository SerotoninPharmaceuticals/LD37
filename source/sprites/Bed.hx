package sprites;
import flixel.FlxG;

class Bed extends LifeObject {
  public function new(X:Float, Y:Float) {
    super(X, Y, GameConfig.bed.normal, GameConfig.bed.hitbox, GameConfig.bed.highlight);
  }
  override public function action():Void {
    FlxG.log.add("bed action");
    nearbyPlayer.sleep();
  }
}
