package sprites;

class Newspaper extends LifeObject {
  public function new() {
    super(GameConfig.newspaper);
  }

  override public function action():Void {
    nearbyPlayer.read();
  }
}
