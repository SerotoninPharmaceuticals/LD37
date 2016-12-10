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

  public function new(lines=10, width=30, color=0xFFFFFFFF, fontSize=3, lineHeight=5, spacing=1, bg=0xFF000000) {
    super();
    _lines = lines;
    _width = width;
    _fontSize = fontSize;
    _lineHeight = lineHeight;
    _spacing = spacing;
    _color = color;
    makeGraphic(width, lines * lineHeight, bg);
    drawLines();
  }

  private function drawChar(offsetX:Int, offsetY:Int) {
    var rand = new FlxRandom();
    var dots = rand.shuffleArray([0, 1, 2, 3, 4, 5, 6, 7, 8], 5).slice(0, rand.int(1, 7));
    var dotX:Int;
    var dotY:Int;
    for (dot in dots) {
      dotX = dot % _fontSize;
      dotY = Std.int(dot / _fontSize);
      FlxSpriteUtil.drawRect(this, x + offsetX + dotX, y + offsetY + dotY + _lineHeight, 1, 1, _color);
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
