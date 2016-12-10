package sprites;
import flixel.group.FlxSpriteGroup;

class Dashboard extends FlxSpriteGroup {
  var foodTitle:PaperGenerator;
  var foodStatus:StatusBar;

  var tirednessTitle:PaperGenerator;
  var tirednessStatus:StatusBar;

  public function new() {
    super();

    foodTitle = new PaperGenerator(GameConfig.dashboardX, GameConfig.dashboardY, 1);
    add(foodTitle);
    foodStatus = new StatusBar(
      GameConfig.dashboardX, GameConfig.dashboardY + GameConfig.statusTitleLineHeight, 100
    );
    add(foodStatus);

    tirednessTitle = new PaperGenerator(GameConfig.dashboardX, GameConfig.dashboardY + GameConfig.statusLineHeight * 1, 1);
    add(tirednessTitle);
    tirednessStatus = new StatusBar(
      GameConfig.dashboardX, GameConfig.dashboardY + GameConfig.statusLineHeight * 1 + GameConfig.statusTitleLineHeight, 100
    );
    add(tirednessStatus);
  }
}
