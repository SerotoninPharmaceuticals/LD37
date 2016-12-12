package sprites;

import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxSpriteUtil;
import flixel.text.FlxText;

class FinishedScreen extends FlxSpriteGroup {
  var blackBg:FlxSprite;
  var title:FlxText;
  var subtitle:FlxText;
  var subtitle1:FlxText;
  var subtitle2:FlxText;
  var subtitle3:FlxText;
  var texts:Array<FlxSprite>;
  public var colliders:Array<FlxSprite> = [];

  public function new() {
    super();
    blackBg = new FlxSprite();
    blackBg.makeGraphic(600, 600, FlxColor.BLACK);

    title = new FlxText(0, 0, 512, "Have you found what you are looking for ?");
    title.setFormat("assets/font.ttf", 12, GameConfig.textWhite, FlxTextAlign.CENTER);
    title.screenCenter();
    title.x += 1;
    title.y = 192;

    subtitle = new FlxText(0, 0, 150, "A game For Ludum Dare 37");
    subtitle.setFormat("assets/font.ttf", 6, GameConfig.textWhite, FlxTextAlign.CENTER);
    subtitle.screenCenter();
    subtitle.x += 1;
    subtitle.y = 300;

    subtitle1 = new FlxText(0, 0, 50, "Made by:");
    subtitle1.setFormat("assets/font.ttf", 6, GameConfig.textWhite, FlxTextAlign.CENTER);
    subtitle1.screenCenter();
    subtitle1.x += 1;
    subtitle1.y = 310;

    subtitle2 = new FlxText(0, 0, 124, "Houkanshan, abing and");
    subtitle2.setFormat("assets/font.ttf", 6, GameConfig.textWhite, FlxTextAlign.CENTER);
    subtitle2.screenCenter();
    subtitle2.x += 1;
    subtitle2.y = 333;

    subtitle3 = new FlxText(0, 0, 254, "\"the remnant of Serotonin Pharmaceuticals.\"");
    subtitle3.setFormat("assets/font.ttf", 6, GameConfig.textWhite, FlxTextAlign.CENTER);
    subtitle3.screenCenter();
    subtitle3.x += 1;
    subtitle3.y = 343;

    add(blackBg);
    add(title);
    add(subtitle);
    add(subtitle1);
    add(subtitle2);
    add(subtitle3);


    for(sprite in this) {
      sprite.alpha = 0;
    }


    FlxSpriteUtil.fadeIn(blackBg, 1.2);
    var timer = new FlxTimer();
    timer.start(5, function(t){
      FlxSpriteUtil.fadeIn(title, 4);
    });
    var timer2 = new FlxTimer();
    timer2.start(10, function(t) {
      FlxSpriteUtil.fadeIn(subtitle, 3);
      FlxSpriteUtil.fadeIn(subtitle1, 3);
      FlxSpriteUtil.fadeIn(subtitle2, 3);
      FlxSpriteUtil.fadeIn(subtitle3, 3);
    });

    texts = [title, subtitle, subtitle1, subtitle2, subtitle3];
    for(obj in texts) {
      var c = new FlxSprite(obj.x, obj.y);
      c.makeGraphic(Std.int(obj.width), Std.int(obj.height), FlxColor.WHITE);
      c.immovable = true;
      colliders.push(c);
    }
  }
}
