package sprites;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.FlxSprite;

class Bed extends FlxSprite {
  public var hitBox:FlxSprite;
  var nearbyPlayer:Player;

  public function new(X:Float = 0, Y:Float = 0) {
    super(X, Y);

    loadGraphic("assets/images/bed.png");
    immovable = true;

    hitBox = new FlxSprite(X, Y);
    hitBox.loadGraphic("assets/images/bed_hitbox.png");
  }
  public function checkHitbox(point:FlxPoint):Bool {
    return hitBox.overlapsPoint(point);
  }

  public function action():Void {
    FlxG.log.add("bed action");
    nearbyPlayer.sleep();
  }
  public function nearby(player:Player):Void {
    if (nearbyPlayer != null) { return; }
    FlxG.log.add("nearby bed");
    loadGraphic("assets/images/bed_highlight.png");
    nearbyPlayer = player;
  }
  public function alway() {
    if (nearbyPlayer == null) { return; }
    FlxG.log.add("bed alway");
    loadGraphic("assets/images/bed.png");
    nearbyPlayer = null;
  }
}
