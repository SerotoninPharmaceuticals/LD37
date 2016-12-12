package sprites;

import utils.Glitch;
import flixel.util.FlxSpriteUtil;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.group.FlxGroup.FlxTypedGroup;

class TitleScreen extends FlxTypedGroup<FlxText> {
  var title:FlxText;
  var subtitle:FlxText;
  var subtitle1:FlxText;
  var titleY = GameConfig.roomImgY + 26;
  var subtitleY = GameConfig.roomImgY + 44;

  public function new() {
    super();
    FlxG.log.add( GameData.getLeftDays());
    title = new FlxText(0, 0, GameConfig.roomImgWidth, GameData.getLeftDays() + "");
    title.setFormat("assets/font.ttf", 12, GameConfig.textWhite, FlxTextAlign.CENTER);
    title.screenCenter();
    title.y = titleY;
    add(title);

    subtitle = new FlxText(0, 0, GameConfig.roomImgWidth, "PRESS X TO");
    subtitle.setFormat("assets/font.ttf", 6, GameConfig.textWhite, FlxTextAlign.CENTER);
    subtitle.screenCenter();
    subtitle.y = subtitleY;
    add(subtitle);

    subtitle1 = new FlxText(0, 0, GameConfig.roomImgWidth, "START");
    subtitle1.setFormat("assets/font.ttf", 6, GameConfig.textWhite, FlxTextAlign.CENTER);
    subtitle1.screenCenter();
    subtitle1.y = subtitleY + 9;
    add(subtitle1);
  }

  override public function update(elspsed) {
    var a = title.alpha;
    a = Glitch.continuousGlitchAlpha(a, 0);
    title.alpha = a;
    subtitle.alpha = a;
    subtitle1.alpha = a;
  }

  public function updateWhenPause(elspsed) {
    var a = title.alpha;
    a = Glitch.continuousGlitchAlpha(a);
    title.alpha = a;
    subtitle.alpha = a;
    subtitle1.alpha = a;
  }

  public function showDay() {
    subtitle.kill();
    subtitle1.kill();
    title.screenCenter();
    title.text = GameData.getLeftDays() + "";
  }
  public function fadeOut(duration:Float) {
    FlxSpriteUtil.fadeOut(title, duration);
    FlxSpriteUtil.fadeOut(subtitle, duration);
    FlxSpriteUtil.fadeOut(subtitle1, duration);
  }
  public function fadeIn(duration:Float) {
    FlxSpriteUtil.fadeIn(title, duration);
  }
}
