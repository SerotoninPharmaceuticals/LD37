package sprites;
import flash.display.BlendMode;
import flixel.FlxSprite;
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

    var lines = 0;

    // bed
    tirednessTitle = new LanguageGenerator(
    GameConfig.dashboardX,
    GameConfig.dashboardY + GameConfig.statusLineHeight * lines,
    1,
    GameConfig.tirednessTitleGeneratorSeed
    );
    add(tirednessTitle);
    tirednessStatus = new StatusBar(
    GameConfig.dashboardX, GameConfig.dashboardY + GameConfig.statusLineHeight * lines + GameConfig.statusTitleLineHeight, GameConfig.initialTiredness
    );
    add(tirednessStatus);
    lines ++;

    // water
    waterTitle = new LanguageGenerator(
    GameConfig.dashboardX,
    GameConfig.dashboardY + GameConfig.statusLineHeight * lines,
    1,
    GameConfig.waterTitleGeneratorSeed
    );
    add(waterTitle);

    waterStatus = new StatusBar(
    GameConfig.dashboardX, GameConfig.dashboardY + GameConfig.statusLineHeight * lines + GameConfig.statusTitleLineHeight, GameConfig.initialWater
    );
    add(waterStatus);
    lines ++;

    // Toilet
    toiletTitle = new LanguageGenerator(
    GameConfig.dashboardX,
    GameConfig.dashboardY + GameConfig.statusLineHeight * lines,
    1,
    GameConfig.toiletTitleGeneratorSeed
    );
    add(toiletTitle);

    toiletStatus = new StatusBar(
    GameConfig.dashboardX, GameConfig.dashboardY + GameConfig.statusLineHeight * lines + GameConfig.statusTitleLineHeight, GameConfig.initialToilet
    );
    add(toiletStatus);
    lines ++;

    // food
    foodTitle = new LanguageGenerator(
    GameConfig.dashboardX,
    GameConfig.dashboardY + GameConfig.statusLineHeight * lines,
    1,
    GameConfig.foodTitleGeneratorSeed
    );
    add(foodTitle);
    foodStatus = new StatusBar(
    GameConfig.dashboardX, GameConfig.dashboardY + GameConfig.statusLineHeight * lines + GameConfig.statusTitleLineHeight, GameConfig.initialFood
    );
    add(foodStatus);
    lines ++;

    update(0);
  }

  override public function update(elapsed:Float) {
    foodStatus.updateValue(GameData.data.food);
    tirednessStatus.updateValue(GameData.data.tiredness);
    waterStatus.updateValue(GameData.data.water);
    toiletStatus.updateValue(GameData.data.toilet);
  }

  public function gameover() {
    if (GameData.data.food <= 0) {
      turnRed(foodTitle);
    }
    if (GameData.data.water <= 0) {
      turnRed(waterTitle);
    }
    if (GameData.data.toilet <= 0) {
      turnRed(toiletTitle);
    }
    if (GameData.data.tiredness <= 0) {
      turnRed(tirednessTitle);
    }
  }
  function turnRed(sprite:FlxSprite) {
    var redOverlay = new FlxSprite(sprite.x, sprite.y);
    redOverlay.makeGraphic(
      (GameConfig.statusDotWidth + GameConfig.statusDotWidth) * GameConfig.statusDotCount,
      GameConfig.statusLineHeight,
      GameConfig.statusRed);
    redOverlay.alpha = 0.5;
    redOverlay.blend = BlendMode.DARKEN;
    add(redOverlay);
  }
}
