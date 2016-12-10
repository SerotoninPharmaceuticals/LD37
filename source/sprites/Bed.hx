package sprites;
import flixel.FlxSprite;

class Bed extends FlxSprite {
  public function new(X:Float = 0, Y:Float = 0) {
    super(X, Y);
    loadGraphic("assets/images/bed.png");
    immovable = true;
  }
}
