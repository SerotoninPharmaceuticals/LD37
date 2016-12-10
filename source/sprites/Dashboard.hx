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
      GameConfig.dashboardX, GameConfig.dashboardY + GameConfig.statusTitleLineHeight, GameConfig.initialFood
    );
    add(foodStatus);

    tirednessTitle = new PaperGenerator(GameConfig.dashboardX, GameConfig.dashboardY + GameConfig.statusLineHeight * 1, 1);
    add(tirednessTitle);
    tirednessStatus = new StatusBar(
      GameConfig.dashboardX, GameConfig.dashboardY + GameConfig.statusLineHeight * 1 + GameConfig.statusTitleLineHeight, GameConfig.initialTiredness
    );
    add(tirednessStatus);
  }

  override public function update(elapsed:Float) {
    foodStatus.updateValue(GameData.data.food);
    tirednessStatus.updateValue(GameData.data.tiredness);
  }
}
