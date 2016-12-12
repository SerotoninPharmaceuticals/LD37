package sprites;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

class Wall extends FlxSpriteGroup {
  var bottomWallL:FlxSprite;
  public function new() {
    super();

    var left = GameConfig.roomX - 1;
    var right = GameConfig.roomRight;
    var top = GameConfig.roomY - 1;
    var bottom = GameConfig.roomBottom - 2;

    var topWall = new FlxSprite(left, top);
    topWall.makeGraphic(GameConfig.roomWidth + 2, 1);
    add(topWall);

    var leftWall = new FlxSprite(left, top);
    leftWall.makeGraphic(1, GameConfig.roomHeight + 2);
    add(leftWall);

    var rightWall = new FlxSprite(right, top);
    rightWall.makeGraphic(1, GameConfig.roomHeight + 2);
    add(rightWall);

    bottomWallL = new FlxSprite(left, bottom);
    bottomWallL.makeGraphic(75, 1);
    add(bottomWallL);

    var bottomWallR = new FlxSprite(left + 75, bottom);
    bottomWallR.makeGraphic(GameConfig.roomWidth + 2 - 75, 1, FlxColor.RED);
    add(bottomWallR);


    if (!GameConfig.debugMode) {
      topWall.alpha = bottomWallL.alpha = bottomWallR.alpha = leftWall.alpha = rightWall.alpha = 0;
    }
    topWall.immovable = leftWall.immovable = rightWall.immovable = bottomWallL.immovable = bottomWallR.immovable = true;
  }

  public function open() {
    FlxTween.tween(bottomWallL, {
      x: bottomWallL.x - 24
    }, 3.3);
  }
}
