package sprites;
import flixel.math.FlxPoint;
import flixel.FlxSprite;

class LifeObject extends FlxSprite {
  public var hitBox:FlxSprite;
  var nearbyPlayer:Player;

  var normalImg:String;
  var hitboxImg:String;
  var highlightImg:String;

  public function new(X:Float = 0, Y:Float = 0, _normalImg:String, _hitboxImg:String, _highlightImg:String) {
    super(X, Y);
    normalImg = _normalImg;
    hitboxImg = _hitboxImg;
    highlightImg = _highlightImg;

    loadGraphic(normalImg);
    immovable = true;

    hitBox = new FlxSprite(X, Y);
    hitBox.loadGraphic(hitboxImg);
  }
  public function checkHitbox(point:FlxPoint):Bool {
    return hitBox.overlapsPoint(point);
  }

  public function action():Void {}

  public function nearby(player:Player):Void {
    if (nearbyPlayer != null) { return; }
    loadGraphic(highlightImg);
    nearbyPlayer = player;
  }
  public function alway() {
    if (nearbyPlayer == null) { return; }
    loadGraphic(normalImg);
    nearbyPlayer = null;
  }
}
