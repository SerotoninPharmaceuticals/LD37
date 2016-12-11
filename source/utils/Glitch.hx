package utils;
import flixel.util.FlxTimer;
import flixel.FlxSprite;

class Glitch {
  static public function showUpGitch(sprite:FlxSprite, times:Int=3) {
    var timer = new FlxTimer();
    var showHide:Void->Void = null;
    showHide = function() {
      timer.start(Math.random() * 0.03, function(t) {
        sprite.alpha = 0;
        timer.start(Math.random() * 0.03, function(t) {
          sprite.alpha = 1;
          times --;
          if (times > 0) {
            showHide();
          }
        });
      });
    }
    showHide();
  }
}
