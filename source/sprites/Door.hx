package sprites;
import flixel.FlxSprite;

class Door extends FlxSprite {
  public function new() {
    super(GameConfig.roomImgX + 14, GameConfig.roomImgY + 78);
    loadGraphic("assets/images/animation_door.png", true, 72, 16);
    animation.add("open", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19], 6, false);
    animation.frameIndex = 0;
  }
  public function open() {
    animation.play("open");
  }
}

