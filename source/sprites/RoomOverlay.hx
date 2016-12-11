package sprites;
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
  public function new(img:String, blend:BlendMode=null) {
    super();
    currSprite = new FlxSprite();
    currSprite.loadGraphic(img, true, 84, 84);
    currSprite.screenCenter();
    currSprite.blend = blend;

    nextSprite = new FlxSprite();
    nextSprite.loadGraphicFromSprite(currSprite);
    nextSprite.screenCenter();
    nextSprite.blend = blend;

    add(nextSprite);
    add(currSprite);

//    currSprite.x -= 100;
//    nextSprite.y += 100;

    frameCount = currSprite.animation.frames;
    currSprite.animation.frameIndex = getFrameIndex();
  }

  override public function update(elapsed:Float) {
    percentToday = GameData.getElapsedToday() / GameConfig.elapsedEachDay;
    currSprite.animation.frameIndex = getFrameIndex();
    currSprite.alpha = (1 - percentToday) * frameCount - Math.floor((1 - percentToday) * frameCount);
    nextSprite.animation.frameIndex = (currSprite.animation.frameIndex + 1) % frameCount;
  }

  function getFrameIndex():Int {
    return Math.floor(percentToday * frameCount);
  }
}
