package sprites;

class Water extends LifeObject {
  public function new() {
    super(GameConfig.water);
  }

  override public function action():Void {
    super.action();
    readyPlayer.drink(); // TODO
  }
}
