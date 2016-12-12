package sprites;
import flixel.FlxSprite;

class ActionAnimation extends FlxSprite {
  public function new() {
    super(GameConfig.animationX, GameConfig.animationY);
    loadGraphic("assets/images/animations.png", true, 160, 160);
    animation.add("eat", [1, 2, 3, 2, 4, 0], 5, false);
    animation.add("drink", [5, 6, 7, 2, 8, 9, 0], 5, false);
    animation.add("toilet", [5, 6, 7, 8, 2, 9, 0], 5, false);
  }

  public function playEat() {
    animation.play("eat");
  }

  public function playDrink() {
    animation.play("drink");
  }

  public function playToilet() {
    animation.play("toilet");
  }
}
