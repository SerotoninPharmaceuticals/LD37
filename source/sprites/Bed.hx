package sprites;
import flixel.FlxSprite;
import GameConfig;
import flixel.FlxG;

class Bed extends LifeObject {
  public var bedHead:FlxSprite;
  public function new() {
    super(GameConfig.bed);
    bedHead = new FlxSprite(x + 1, y + 6);
    bedHead.loadGraphic("assets/images/player_sleeping.png");
    bedHead.kill();
  }

  override public function action():Void {
    super.action();
    readyPlayer.sleep();
  }

  public function goBed(player:FlxSprite) {
    bedHead.revive();
    player.kill();
  }

  public function leaveBed(player:FlxSprite) {
    bedHead.kill();
    player.revive();
  }

}
