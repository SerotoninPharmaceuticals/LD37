package sprites;
import GameConfig.LifeObjectConfig;
import flixel.math.FlxPoint;
import flixel.FlxSprite;

class LifeObject extends FlxSprite {
  public var hitbox:FlxSprite;
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
    if (config.hitboxOffsetY != null) { hitboxY += config.hitboxOffsetY; }
    hitbox = new FlxSprite(hitboxX, hitboxY);

    hitbox.loadGraphic(hitboxImg);
  }
  public function checkHitbox(point:FlxPoint):Bool {
    return hitbox.overlapsPoint(point);
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
