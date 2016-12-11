package sprites;

import flixel.FlxG;
import utils.Glitch;
import flixel.util.FlxSpriteUtil;
import flixel.math.FlxRandom;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxTimer;
import flixel.system.FlxSound;

class NewsReader extends FlxTypedGroup<LanguageGenerator> {
  var title:LanguageGenerator;
  var body:LanguageGenerator;
  var rand = new FlxRandom();
  var paperSound:FlxSound;

  public function new() {
    super();
    paperSound = FlxG.sound.load("assets/sounds/paper.wav");
  }

  public function showNews() {
    if (body != null) { return; }

    var day = Std.int(GameData.getElapsedDays());
    title = new LanguageGenerator(GameConfig.newsReaderX, GameConfig.newsReaderY, 1, day, rand.int(10, 50));
    var lines = rand.int(3, 8);
    body = new LanguageGenerator(GameConfig.newsReaderX, GameConfig.newsReaderY + 10, lines, day, GameConfig.newsReaderWidth);

    add(title);
    add(body);

    paperSound.play();
    Glitch.showUpGitch(title);
    Glitch.showUpGitch(body);

    var timer = new FlxTimer();
    var fadeOutDuration = 0.5;
    timer.start(GameConfig.readingDuration - fadeOutDuration, function(t) {
      FlxSpriteUtil.fadeOut(body, fadeOutDuration, function(_) {
        remove(body);
        body.destroy();
        body = null;
      });
      FlxSpriteUtil.fadeOut(title, fadeOutDuration, function(_) {
        remove(title);
        title.destroy();
        title = null;
      });
    });

  }

}