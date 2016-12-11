package sprites;

class Toilet extends LifeObject {
  public function new() {
    super(GameConfig.toilet);
  }
  override public function action():Void {
    nearbyPlayer.toilet();
  }
}
