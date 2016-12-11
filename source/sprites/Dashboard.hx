package sprites;
import flixel.group.FlxSpriteGroup;

class Dashboard extends FlxSpriteGroup {
  var foodTitle:LanguageGenerator;
  var foodStatus:StatusBar;

  var tirednessTitle:LanguageGenerator;
  var tirednessStatus:StatusBar;

  var waterTitle:LanguageGenerator;
  var waterStatus:StatusBar;

  var toiletTitle:LanguageGenerator;
  var toiletStatus:StatusBar;

  public function new() {
    super();

    // food
    foodTitle = new LanguageGenerator(GameConfig.dashboardX, GameConfig.dashboardY, 1, GameConfig.foodTitleGeneratorSeed);
    add(foodTitle);
    foodStatus = new StatusBar(
      GameConfig.dashboardX, GameConfig.dashboardY + GameConfig.statusTitleLineHeight, GameConfig.initialFood
    );
    add(foodStatus);

    // bed
    tirednessTitle = new LanguageGenerator(
      GameConfig.dashboardX,
      GameConfig.dashboardY + GameConfig.statusLineHeight * 1,
      1,
      GameConfig.tirednessTitleGeneratorSeed
    );
    add(tirednessTitle);
    tirednessStatus = new StatusBar(
      GameConfig.dashboardX, GameConfig.dashboardY + GameConfig.statusLineHeight * 1 + GameConfig.statusTitleLineHeight, GameConfig.initialTiredness
    );
    add(tirednessStatus);

    // Toilet
    toiletTitle = new LanguageGenerator(
      GameConfig.dashboardX,
      GameConfig.dashboardY + GameConfig.statusLineHeight * 2,
      1,
      GameConfig.toiletTitleGeneratorSeed
    );
    add(toiletTitle);

    toiletStatus = new StatusBar(
      GameConfig.dashboardX, GameConfig.dashboardY + GameConfig.statusLineHeight * 2 + GameConfig.statusTitleLineHeight, GameConfig.initialToilet
    );
    add(toiletStatus);

    // water
    waterTitle = new LanguageGenerator(
      GameConfig.dashboardX,
      GameConfig.dashboardY + GameConfig.statusLineHeight * 3,
      1,
      GameConfig.waterTitleGeneratorSeed
    );
    add(waterTitle);

    waterStatus = new StatusBar(
      GameConfig.dashboardX, GameConfig.dashboardY + GameConfig.statusLineHeight * 3 + GameConfig.statusTitleLineHeight, GameConfig.initialWater
    );
    add(waterStatus);
  }

  override public function update(elapsed:Float) {
    foodStatus.updateValue(GameData.data.food);
    tirednessStatus.updateValue(GameData.data.tiredness);
    waterStatus.updateValue(GameData.data.water);
    toiletStatus.updateValue(GameData.data.toilet);
  }
}
