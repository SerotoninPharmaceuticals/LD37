package sprites;

import flixel.util.FlxSpriteUtil;
import flixel.text.FlxText;
import flixel.group.FlxGroup.FlxTypedGroup;

class TitleScreen extends FlxTypedGroup<FlxText> {
  var title:FlxText;
  var subtitle:FlxText;
  var subtitle1:FlxText;
  var titleY = GameConfig.roomImgY + 26;
  var subtitleY = GameConfig.roomImgY + 48;

  public function new() {
    super();
    title = new FlxText(0, 0, GameConfig.roomImgWidth, GameData.getLeftDays() + "");
    title.setFormat("assets/font.ttf", 12, GameConfig.textWhite, FlxTextAlign.CENTER);
    title.screenCenter();
    title.x += 1;
    title.y = titleY;
    add(title);

    subtitle = new FlxText(0, 0, GameConfig.roomImgWidth, "PRESS X TO");
    subtitle.setFormat("assets/font.ttf", 6, GameConfig.textWhite, FlxTextAlign.CENTER);
    subtitle.screenCenter();
    subtitle.x += 1;
    subtitle.y = subtitleY;
    add(subtitle);

    subtitle1 = new FlxText(0, 0, GameConfig.roomImgWidth, "START");
    subtitle1.setFormat("assets/font.ttf", 6, GameConfig.textWhite, FlxTextAlign.CENTER);
    subtitle1.screenCenter();
    subtitle1.x += 1;
    subtitle1.y = subtitleY + 9;
    add(subtitle1);
  }

  var totalElapsed:Float = 0;

  public function updateWhenPause(elapsed:Float) {
    totalElapsed += elapsed;
    var a = totalElapsed % 1.6 > 0.8 ? 0 : 1;
    subtitle.alpha = a;
    subtitle1.alpha = a;
  }

  public function hideInStartScreen() {
    title.alpha = 0;
    subtitle.kill();
    subtitle1.kill();
  }

  public function showDay() {
    subtitle.kill();
    subtitle1.kill();
    title.screenCenter();
    title.x += 1;
    title.text = GameData.getLeftDays() + "";
  }

  public function fadeOut(duration:Float) {
    FlxSpriteUtil.fadeOut(title, duration);
    FlxSpriteUtil.fadeOut(subtitle, duration);
    FlxSpriteUtil.fadeOut(subtitle1, duration);
  }

  public function fadeIn(duration:Float) {
    FlxSpriteUtil.fadeIn(title, duration, true);
  }
}
