package sprites;

import flixel.util.FlxSpriteUtil;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.group.FlxGroup.FlxTypedGroup;

class TitleScreen extends FlxTypedGroup<FlxText> {
  var title:FlxText;
  var subtitle:FlxText;
  var titleY = GameConfig.roomImgY + 28;
  var subtitleY = GameConfig.roomImgY + 44;

  public function new() {
    super();
    FlxG.log.add( GameData.getLeftDays());
    title = new FlxText(0, 0, GameConfig.roomImgWidth, GameData.getLeftDays() + "");
    title.setFormat("assets/font.ttf", 12, GameConfig.textWhite, FlxTextAlign.CENTER);
    title.screenCenter();
    title.y = titleY;
    add(title);

    subtitle = new FlxText(0, 0, GameConfig.roomImgWidth, "press x to start");
    subtitle.setFormat("assets/font.ttf", 6, GameConfig.textWhite, FlxTextAlign.CENTER);
    subtitle.screenCenter();
    subtitle.y = subtitleY;
    add(subtitle);
  }

  public function showDay() {
    subtitle.kill();
    title.screenCenter();
    title.text = GameData.getLeftDays() + "";
  }
  public function fadeOut(duration:Float) {
    FlxSpriteUtil.fadeOut(title, duration);
    FlxSpriteUtil.fadeOut(subtitle, duration);
  }
  public function fadeIn(duration:Float) {
    FlxSpriteUtil.fadeIn(title, duration);
  }
}
