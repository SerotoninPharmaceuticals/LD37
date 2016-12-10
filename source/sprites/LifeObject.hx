package sprites;
import GameConfig.LifeObjectConfig;
import flixel.math.FlxPoint;
import flixel.FlxSprite;

class LifeObject extends FlxSprite {
  public var hitBox:FlxSprite;
  var nearbyPlayer:Player;

  var normalImg:String;
  var hitboxImg:String;
  var highlightImg:String;

  public function new(config:LifeObjectConfig) {
    super(GameConfig.roomX + config.x, GameConfig.roomY + config.y);
    normalImg = config.normal;
    hitboxImg = config.hitbox;
    highlightImg = config.highlight;

    loadGraphic(normalImg);
    immovable = true;

    var hitboxX = x;
    var hitboxY = y;
    if (config.hitboxOffsetX != null) { hitboxX += config.hitboxOffsetX; }
    if (config.hitboxOffsetY != null) { hitboxX += config.hitboxOffsetY; }
    hitBox = new FlxSprite(hitboxX, hitboxY);

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
