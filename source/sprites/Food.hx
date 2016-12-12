package sprites;

class Food extends LifeObject {
  public function new() {
    super(GameConfig.food);
  }

  override public function action():Void {
    super.action();
    readyPlayer.eat();
  }
}
