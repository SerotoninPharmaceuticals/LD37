package utils;
import flixel.util.FlxTimer;
import flixel.FlxSprite;

class Glitch {
  // Used in update.
  static public function continuousGlitch(sprite:FlxSprite) {
    var maskDice = Math.random();
    sprite.alpha = (maskDice > 0.99) ? 1 : (Math.random() + 0.4);
  }

  static public function showUpGlitch(sprite:FlxSprite, times:Int=3, onFinished:Void->Void=null) {
    var timer = new FlxTimer();
    var showHide:Void->Void = null;
    sprite.alpha = 1;
    showHide = function() {
      timer.start(Math.random() * 0.03, function(t) {
        sprite.alpha = 0;
        timer.start(Math.random() * 0.03, function(t) {
          sprite.alpha = 1;
          times --;
          if (times > 0) {
            showHide();
          } else {
            if (onFinished != null) {
              onFinished();
            }
          }
        });
      });
    }
    showHide();
  }
  static public function leaveGlitch(sprite:FlxSprite, times:Int=3, onFinished:Void->Void=null) {
    var timer = new FlxTimer();
    var showHide:Void->Void = null;

    sprite.alpha = 0;
    showHide = function() {
      timer.start(Math.random() * 0.03, function(t) {
        sprite.alpha = 1;
        timer.start(Math.random() * 0.03, function(t) {
          sprite.alpha = 0;
          times --;
          if (times > 0) {
            showHide();
          } else {
            if (onFinished != null) {
              onFinished();
            }
          }
        });
      });
    }
    showHide();
  }
}
