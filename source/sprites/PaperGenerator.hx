package sprites;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxRandom;
import flixel.util.FlxSpriteUtil;

class PaperGenerator extends FlxSprite {

  static var MAX_DOTS = 6;
  private var _color:Int;
  private var _fontSize:Int;
  private var _lines:Int;
  private var _lineHeight:Int;
  private var _spacing:Int;
  private var _width:Int;
  private var _seed:Int;
  private var rand:FlxRandom;

  public function new(X:Float=0, Y:Float=0, lines=1, seed=null, width=30, color=0xFFFFFFFF, fontSize=3, lineHeight=5, spacing=1, bg=0xFF000000) {
    super(X, Y);
    _lines = lines;
    _width = width;
    _fontSize = fontSize;
    _lineHeight = lineHeight;
    _spacing = spacing;
    _color = color;
    makeGraphic(width, lines * lineHeight, bg, true); // Pass true to Unique to prevent bitmap resuse.
    initRandom(seed);
    drawLines();
  }

  private function initRandom(seed) {
    if (seed != null) {
      rand = new FlxRandom(seed);
    } else {
      rand = new FlxRandom();
    }
  }

  private function drawChar(offsetX:Int, offsetY:Int) {
    var dots = rand.shuffleArray([for (i in 0..._fontSize * _fontSize) i], 5).slice(0, rand.int(1, Std.int(_fontSize / 3 * 2 + 1)));
    var dotX:Int;
    var dotY:Int;
    for (dot in dots) {
      dotX = dot % _fontSize;
      dotY = Std.int(dot / _fontSize);
      FlxSpriteUtil.drawRect(this, offsetX + dotX, offsetY + dotY, 1, 1, _color);
    }
  }

  private function drawLines() {
    for (xx in 0...Std.int(_width / (_spacing + _fontSize))) {
      for (yy in 0..._lines) {
        drawChar(xx * (_spacing + _fontSize), yy * _lineHeight);
      }
    }
  }
}
