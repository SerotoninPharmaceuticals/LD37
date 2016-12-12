package sprites;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

class Wall extends FlxSpriteGroup {
  public function new() {
    super();

    var left = GameConfig.roomX - 1;
    var right = GameConfig.roomRight;
    var top = GameConfig.roomY - 1;
    var bottom = GameConfig.roomBottom;

    var topWall = new FlxSprite(left, top);
    topWall.makeGraphic(GameConfig.roomWidth + 2, 1);
    topWall.alpha = 0;
    add(topWall);

    var bottomWall = new FlxSprite(left, bottom);
    bottomWall.makeGraphic(GameConfig.roomWidth + 2, 1);
    bottomWall.alpha = 0;
    add(bottomWall);

    var leftWall = new FlxSprite(left, top);
    leftWall.makeGraphic(1, GameConfig.roomHeight + 2);
    leftWall.alpha = 0;
    add(leftWall);

    var rightWall = new FlxSprite(right, top);
    rightWall.makeGraphic(1, GameConfig.roomHeight + 2);
    rightWall.alpha = 0;
    add(rightWall);

    topWall.immovable = leftWall.immovable = rightWall.immovable = bottomWall.immovable = true;
  }
}
