package sprites;
import utils.Glitch;
import openfl.display.BlendMode;
import GameConfig.LifeObjectConfig;
import flixel.FlxSprite;

class LifeObject extends FlxSprite {
  public var hitbox:FlxSprite;
  var readyPlayer:Player;
  public var luminosity:FlxSprite;
  public var config:LifeObjectConfig;
  public var isFresh = true;

  var normalImg:String;
  var hitboxImg:String;
  var highlightImg:String;

  public function new(_config:LifeObjectConfig) {
    config = _config;
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

  override public function update(elapsed:Float) {
    super.update(elapsed);
    if (luminosity != null && luminosity.alive) {
      Glitch.continuousGlitch(luminosity);
    }
  }

  public function checkHitbox(sprite:FlxSprite):Bool {
    return hitbox.overlaps(sprite);
  }

  public function checkFacing(sprite:FlxSprite):Bool {
    return sprite.facing == config.playerFacing;
  }

  public function action():Void {
    isFresh = false;
  }

  dynamic public function canAction():Bool { return true; }

  public function turnOffLuminosity() {
    if (luminosity == null) { return; }
    luminosity.kill();
  }

  public function turnOnLuminosity() {
    if (luminosity == null) { return; }
    luminosity.revive();
  }

  public function readyForAction(player:Player):Void {
    if (readyPlayer != null) { return; }
    alpha = 1;
    readyPlayer = player;
  }

  public function notReadyForAction() {
    if (readyPlayer == null) { return; }
    alpha = 0;
    readyPlayer = null;
  }
}
