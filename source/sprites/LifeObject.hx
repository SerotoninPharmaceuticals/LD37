package sprites;
import openfl.Assets;
import openfl.display.BlendMode;
import GameConfig.LifeObjectConfig;
import flixel.FlxSprite;

class LifeObject extends FlxSprite {
  public var hitbox:FlxSprite;
  var nearbyPlayer:Player;
  public var luminosity:FlxSprite;

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

    if (config.luminosity != null) {
      var luminosityX = x;
      var luminosityY = y;
      if (config.luminosityOffsetX != null) { luminosityX += config.luminosityOffsetX; }
      if (config.luminosityOffsetY != null) { luminosityY += config.luminosityOffsetY; }
      luminosity = new FlxSprite(luminosityX, luminosityY);
      luminosity.loadGraphic(config.luminosity);
      luminosity.blend = BlendMode.HARDLIGHT;
    }
  }
  public function checkHitbox(sprite:FlxSprite):Bool {
    return hitbox.overlaps(sprite);
  }

  dynamic public function action():Void {}
  dynamic public function canAction():Bool { return true; }

  public function turnOffLuminosity() {
    if (luminosity == null)  { return; }
    luminosity.kill();
  }
  public function turnOnLuminosity() {
    if (luminosity == null)  { return; }
    luminosity.revive();
  }

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
