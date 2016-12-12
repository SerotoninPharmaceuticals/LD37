// From flixel demo.

package sprites;

import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;

class Player extends FlxSprite {
  public var speed:Float = 65;
  private var _sndStep:FlxSound;

  public var isSleeping = false;
  public var sleepElapsed:Float = 0;
  public var isEating = false;
  public var isDrinking = false;
  public var isToileting = false;
  public var isReading = false;
  public var isRequesting = false;

  public var requestSleep:(Void->Void)->Void;
  public var requestWakeup:(Void->Void)->Void;
  public var requestToEat:(Void->Void)->Void;
  public var requestToDrink:(Void->Void)->Void;
  public var requestToRead:(Void->Void)->Void;
  public var requestToToilet:(Void->Void)->Void;

  public function new(X:Float = 0, Y:Float = 0, _isSleeping = false, _sleepElapsed = 0) {
    super(X, Y);

    loadGraphic("assets/images/animation_player.png", true, 22, 22);
    animation.add("walk", [0, 1, 2, 3, 4, 5], 5, true);
    animation.add("eat_and_drink", [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17], 5, false);
    animation.add("read_and_toilet", [6, 7, 8, 15, 16, 17], 5, false);
    drag.x = drag.y = 1600;
    setSize(15, 15);
    offset.set(5, 5);
    _sndStep = FlxG.sound.load("assets/sounds/step.wav");

    if (_isSleeping) {
      sleep(_sleepElapsed);
    }

  }

  private function movement():Void {
    var _up:Bool = false;
    var _down:Bool = false;
    var _left:Bool = false;
    var _right:Bool = false;

    _up = FlxG.keys.anyPressed([UP, W]);
    _down = FlxG.keys.anyPressed([DOWN, S]);
    _left = FlxG.keys.anyPressed([LEFT, A]);
    _right = FlxG.keys.anyPressed([RIGHT, D]);

    if (_up && _down)
      _up = _down = false;
    if (_left && _right)
      _left = _right = false;

    if (_up || _down || _left || _right) {
      var mA:Float = 0;
      if (_up) {
        mA = -90;
        if (_left)
          mA -= 45;
        else if (_right)
          mA += 45;

        facing = FlxObject.UP;
      }
      else if (_down) {
        mA = 90;
        if (_left)
          mA += 45;
        else if (_right)
          mA -= 45;

        facing = FlxObject.DOWN;
      }
      else if (_left) {
        mA = 180;
        facing = FlxObject.LEFT;
      }
      else if (_right) {
        mA = 0;
        facing = FlxObject.RIGHT;
      }

      velocity.set(speed, 0);
      velocity.rotate(FlxPoint.weak(0, 0), mA);
      angle = mA + 90;

      if ((velocity.x != 0 || velocity.y != 0) && touching == FlxObject.NONE) {
        //_sndStep.play();
        animation.play("walk");
      }
    }
    else if (animation.curAnim != null) {
      animation.curAnim.curFrame = 0;
      animation.curAnim.pause();
    }
  }

  override public function update(elapsed:Float):Void {
    if (isSleeping) {
      sleepElapsed += elapsed;
      if (needWakeup()) {
        wakeup();
      }
    } else if (isEating) {
      animation.play("eat_and_drink");
    } else if (isDrinking) {
      animation.play("eat_and_drink");
    } else if (isToileting) {
      animation.play("read_and_toilet");
    } else if (isReading) {
      animation.play("read_and_toilet");
    } else {
      movement();
    }
    super.update(elapsed);
  }

  public function getIsBusy() {
    return isSleeping || isEating || isDrinking || isToileting || isReading || isRequesting;
  }

  public function sleep(_sleepElapsed:Float = 0) {
    isSleeping = true;
    requestSleep(function() {
      sleepElapsed = _sleepElapsed;
    });
  }

  public function wakeup() {
    requestWakeup(function() {
      isSleeping = false;
      sleepElapsed = 0;
    });
  }
  function needWakeup():Bool {
    return sleepElapsed > GameConfig.sleepingDuration;
  }

  public function eat() {
    isRequesting = true;
    requestToEat(function() {
      isEating = true;
      var timer = new FlxTimer();
      FlxG.log.add(GameConfig.eatingDuration);
      timer.start(GameConfig.eatingDuration, function(t) {
        isRequesting = isEating = false;
      });
    });
  }
  public function drink() {
    isRequesting = true;
    requestToDrink(function() {
      isDrinking = true;
      var timer = new FlxTimer();
      timer.start(GameConfig.drinkingDuration, function(t) {
        isRequesting = isDrinking = false;
      });
    });
  }
  public function toilet() {
    isRequesting = true;
    requestToToilet(function() {
      isToileting = true;
      var timer = new FlxTimer();
      timer.start(GameConfig.toiletingDuration, function(t) {
        isRequesting = isToileting = false;
      });
    });
  }
  public function read() {
    isRequesting = true;
    requestToRead(function() {
      isReading = true;
      var timer = new FlxTimer();
      timer.start(GameConfig.readingDuration, function(t) {
        isRequesting = isReading = false;
      });
    });
  }
}
