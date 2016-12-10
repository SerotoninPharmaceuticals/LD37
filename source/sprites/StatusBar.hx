package sprites;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxColor;
import flixel.FlxSprite;

class StatusBar extends FlxSprite {
  var statusDotCount:Int = GameConfig.statusDotCount;
  var statusDotWidth = GameConfig.statusDotWidth;
  var statusDotHeight = GameConfig.statusDotHeight;
  var statusDotSpace = GameConfig.statusDotSpace;
  var white = GameConfig.textWhite;
  var gray = GameConfig.textGray;

  var total:Int;

  public function new(X:Float = 0, Y:Float = 0, _total:Int = 100) {
    super(X, Y);
    total = _total;
    makeGraphic(
      statusDotCount * (statusDotWidth + statusDotSpace),
      statusDotHeight,
      FlxColor.TRANSPARENT
    );
    pixelPerfectPosition = true;
    pixelPerfectRender = true;
    updateValue(total);
  }

  public function updateValue(value:Float) {
    var ligthUpCount = Math.floor(statusDotCount * value / total);
    for(i in 0...statusDotCount) {
      if (i < ligthUpCount) {
        FlxSpriteUtil.drawRect(this,
          i * (statusDotWidth + statusDotSpace), 0,
          statusDotWidth, statusDotHeight,
          white
        );

      } else {
        FlxSpriteUtil.drawRect(this,
          i * (statusDotWidth + statusDotSpace), 0,
          statusDotWidth, statusDotHeight,
          gray
        );
      }
    }
  }

}
