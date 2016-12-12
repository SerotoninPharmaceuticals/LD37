package sprites;
import flixel.util.FlxSpriteUtil;
import flixel.FlxG;
import openfl.display.BlendMode;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

class RoomOverlay extends FlxSpriteGroup {
  var currSprite:FlxSprite;
  var nextSprite:FlxSprite;
  var currFrame:Int = 0;
  var frameCount:Int = 0;
  var percentToday:Float = 0;
  var bothFade:Bool = false;
  var isOpened = false;

  public function new(img:String, w = 84, h = 84, _bothFade:Bool = false, blend:BlendMode = null) {
    super();
    currSprite = new FlxSprite();
    currSprite.loadGraphic(img, true, w, h);
    currSprite.screenCenter();
    currSprite.blend = blend;

    nextSprite = new FlxSprite();
    nextSprite.loadGraphicFromSprite(currSprite);
    nextSprite.screenCenter();
    nextSprite.blend = blend;

    add(nextSprite);
    add(currSprite);

    bothFade = _bothFade;

    frameCount = currSprite.animation.frames;
    currSprite.animation.frameIndex = getFrameIndex();
  }

  override public function update(elapsed:Float) {
    if (isOpened) { return; }

    percentToday = GameData.getElapsedToday() / GameConfig.elapsedEachDay;
    currSprite.animation.frameIndex = getFrameIndex();
    currSprite.alpha = (1 - percentToday) * frameCount - Math.floor((1 - percentToday) * frameCount);
    nextSprite.animation.frameIndex = (currSprite.animation.frameIndex + 1) % frameCount;

    if (bothFade) {
      nextSprite.alpha = 1 - currSprite.alpha;
    }
  }

  public function open() {
    isOpened = true;
    FlxSpriteUtil.fadeOut(currSprite, 2);
    FlxSpriteUtil.fadeOut(nextSprite, 2);
  }

  function getFrameIndex():Int {
    return Math.floor(percentToday * frameCount);
  }
}
