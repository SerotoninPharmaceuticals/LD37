package sprites;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

class Wall extends FlxSpriteGroup {
  public function new() {
    super();

    var left = GameConfig.roomX - 1;
    var right = GameConfig.roomRight;
    var top = GameConfig.roomY - 1;
    var bottom = GameConfig.roomBottom - 2;

    var topWall = new FlxSprite(left, top);
    topWall.makeGraphic(GameConfig.roomWidth + 2, 1);
    add(topWall);

    var bottomWall = new FlxSprite(left, bottom);
    bottomWall.makeGraphic(GameConfig.roomWidth + 2, 1);
    add(bottomWall);

    var leftWall = new FlxSprite(left, top);
    leftWall.makeGraphic(1, GameConfig.roomHeight + 2);
    add(leftWall);

    var rightWall = new FlxSprite(right, top);
    rightWall.makeGraphic(1, GameConfig.roomHeight + 2);
    add(rightWall);

    if (!GameConfig.debugMode) {
      topWall.alpha = bottomWall.alpha = leftWall.alpha = rightWall.alpha = 0;
    }
    topWall.immovable = leftWall.immovable = rightWall.immovable = bottomWall.immovable = true;
  }
}
