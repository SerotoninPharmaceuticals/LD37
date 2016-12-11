package sprites;
import openfl.display.BlendMode;
import GameConfig.LifeObjectConfig;
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
    alpha = 0;

    blend = BlendMode.HARDLIGHT;

    var hitboxX = x;
    var hitboxY = y;
    if (config.hitboxOffsetX != null) { hitboxX += config.hitboxOffsetX; }
    if (config.hitboxOffsetY != null) { hitboxY += config.hitboxOffsetY; }
    hitbox = new FlxSprite(hitboxX, hitboxY);

    hitbox.loadGraphic(hitboxImg);
  }
  public function checkHitbox(sprite:FlxSprite):Bool {
    return hitbox.overlaps(sprite);
  }

  dynamic public function action():Void {}
  dynamic public function canAction():Bool { return true; }

  public function nearby(player:Player):Void {
    if (nearbyPlayer != null) { return; }
    alpha = 1;
    nearbyPlayer = player;
  }
  public function alway() {
    if (nearbyPlayer == null) { return; }
    alpha = 0;
    nearbyPlayer = null;
  }
}
