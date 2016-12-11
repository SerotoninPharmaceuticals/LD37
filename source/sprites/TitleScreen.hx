package sprites;

import flixel.FlxG;
import flixel.text.FlxText;
import flixel.group.FlxGroup.FlxTypedGroup;

class TitleScreen extends FlxTypedGroup<FlxText> {
  var title:FlxText;
  var subtitle:FlxText;

  public function new() {
    super();
    FlxG.log.add( GameData.getLeftDays());
    title = new FlxText(0, 0, GameConfig.roomImgWidth, GameData.getLeftDays() + "");
    title.setFormat("assets/font.ttf", 12, GameConfig.textWhite, FlxTextAlign.CENTER);
    title.screenCenter();
    title.y = GameConfig.roomImgY + 28;
    add(title);

    subtitle = new FlxText(0, 0, GameConfig.roomImgWidth, "press x to start");
    subtitle.setFormat("assets/font.ttf", 6, GameConfig.textWhite, FlxTextAlign.CENTER);
    subtitle.screenCenter();
    subtitle.y = GameConfig.roomImgY + 44;
    add(subtitle);
  }
}
