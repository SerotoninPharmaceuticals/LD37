package sprites;
import flixel.util.FlxSpriteUtil;
import flixel.FlxG;
import flixel.util.FlxColor;
import openfl.display.BlendMode;
import flixel.FlxSprite;

class ShadowOverlay extends FlxSprite {
  var alphaList:Array<Float>;
  var alphaCount = 0;
  var percentToday:Float = 0;
  var bothFade:Bool = false;
  var isOpened = false;

  public function new(_alphaList:Array<Float>, w = 84, h = 84) {
    super();
    makeGraphic(w, h, GameConfig.shadowOverlay);
    screenCenter();
    blend = BlendMode.MULTIPLY;
    alphaList = _alphaList;
    alphaCount = alphaList.length;
    alpha = alphaList[0];
  }

  override public function update(elapsed:Float) {
    if (isOpened) { return; }
    percentToday = GameData.getElapsedToday() / GameConfig.elapsedEachDay;

    var index = getAlphaIndex();
    var prevAlpha = alphaList[index];
    var nextAlpha = alphaList[(index + 1) % alphaCount];

    var nextPercent = percentToday * alphaCount - Math.floor(percentToday * alphaCount);
    alpha = prevAlpha * (1 - nextPercent) + nextAlpha * nextPercent;
  }

  public function open() {
    isOpened = true;
    FlxSpriteUtil.fadeOut(this, 2);
  }

  function getAlphaIndex():Int {
    return Math.floor(percentToday * alphaCount);
  }
}
