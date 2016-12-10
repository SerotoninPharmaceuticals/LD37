package sprites;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

class Wall extends FlxSpriteGroup {
  public function new() {
    super();

    var centerX = FlxG.width / 2;
    var centerY = FlxG.height / 2;
    var left = centerX - GameConfig.roomWidth / 2 - 1;
    var right = centerX + GameConfig.roomWidth / 2;
    var top = centerY - GameConfig.roomWidth / 2 - 1;
    var bottom = centerY + GameConfig.roomWidth / 2;

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

    topWall.immovable = leftWall.immovable = rightWall.immovable = bottomWall.immovable = true;
  }
}
