package ThePower.OverLayerUI 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import ThePower.GameWorlds.MainMenuWorld;
	import ThePower.GlobalGameData;
	import ThePower.LayerConstants;
	/**
	 * ...
	 * @author Amidos
	 */
	public class PauseMenuEntity extends Entity
	{
		[Embed(source = "../../../assets/Graphics/sprites/inventory/text_box.png")]private var deathBoxClass:Class;
		[Embed(source = "../../../assets/Graphics/sprites/inventory/options_select.png")]private var optionSelect:Class;
		[Embed(source = "../../../assets/Sounds/player/inventory.mp3")]private var selectionClass:Class;
		[Embed(source = "../../../assets/Graphics/impact.ttf",embedAsCFF="false", fontFamily = 'GameFont')]private var fontClass:Class;
		
		private var backgroundImage:Image;
		private var optionSelectLeftImage:Image;
		private var optionSelectRightImage:Image;
		private var title:Text;
		private var text:Vector.<Text> = new Vector.<Text>();
		private var selectionPointer:int = 0;
		private var numberOfOptions:int = 4;
		private var pointsOfOptions:Vector.<Point> = new Vector.<Point>();
		private var selectionSfx:Sfx = new Sfx(selectionClass);
		private var hint1Text:Text;
		private var hint2Text:Text;
		
		public function PauseMenuEntity(xIn:int, yIn:int) 
		{
			backgroundImage = new Image(deathBoxClass);
			optionSelectLeftImage = new Image(optionSelect);
			optionSelectRightImage = new Image(optionSelect);
			optionSelectLeftImage.centerOO();
			optionSelectRightImage.centerOO();
			optionSelectRightImage.flipped = true;
			
			x = xIn - backgroundImage.width / 2;
			y = yIn - backgroundImage.height / 2;
			
			Text.font = "GameFont";
			Text.size = 16;
			
			title = new Text("Game Paused");
			title.color = 0xFFFFFF;
			title.centerOO();
			
			Text.size = 16;
			text.push(new Text("Return to game"));
			text.push(new Text("Mute Music"));
			text.push(new Text("Load last savepoint"));
			text.push(new Text("Return to MainMenu"));
			text[0].color = 0xFFFFFF;
			text[1].color = 0xFFFFFF;
			text[2].color = 0xFFFFFF;
			text[3].color = 0xFFFFFF;
			text[0].centerOO();
			text[1].centerOO();
			text[2].centerOO();
			text[3].centerOO();
			
			Text.size = 12;
			hint1Text = new Text("Up and Down to choose");
			hint2Text = new Text("Space to select");
			hint1Text.color = 0xFFFFFF;
			hint2Text.color = 0xFFFFFF;
			hint2Text.size = 12;
			hint2Text.size = 12;
			hint1Text.centerOO();
			hint2Text.centerOO();
			
			pointsOfOptions.push(new Point(backgroundImage.width / 2, backgroundImage.height / 2 - 35));
			pointsOfOptions.push(new Point(backgroundImage.width / 2, backgroundImage.height / 2 - 15));
			pointsOfOptions.push(new Point(backgroundImage.width / 2, backgroundImage.height / 2 + 5));
			pointsOfOptions.push(new Point(backgroundImage.width / 2, backgroundImage.height / 2 + 25));
			
			layer = LayerConstants.HUDLayer;
			
			GlobalGameData.pauseGame = true;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.pressed(Key.DOWN))
			{
				selectionSfx.play();
				selectionPointer = (selectionPointer + 1) % numberOfOptions;
			}
			
			if (Input.pressed(Key.UP))
			{
				selectionSfx.play();
				selectionPointer -= 1;
				if (selectionPointer < 0)
				{
					selectionPointer = numberOfOptions - 1;
				}
			}
			
			if (Input.pressed(Key.SPACE))
			{
				switch(selectionPointer)
				{
					case 0:
						FP.world.remove(this);
						GlobalGameData.pauseGame = false;
						GlobalGameData.PauseGameWorld();
					break;
					case 1:
						FP.volume = 1 - FP.volume;
						Text.size = 16;
						if (FP.volume == 1)
						{
							text[1] = new Text("Mute Music");
						}
						else
						{
							text[1] = new Text("UnMute Music");
						}
						text[1].centerOO();
					break;
					case 2:
						GlobalGameData.pauseGame = false;
						GlobalGameData.PauseGameWorld();
						GlobalGameData.LoadData();
					break;
					case 3:
						FP.world = new MainMenuWorld();
					break;
				}
			}
		}
		
		override public function render():void 
		{
			super.render();
			
			backgroundImage.render(FP.buffer, new Point(x, y), FP.camera);
			title.render(FP.buffer, new Point(x + backgroundImage.width / 2, y + 20), FP.camera);
			
			text[0].render(FP.buffer, new Point(x + pointsOfOptions[0].x, y + pointsOfOptions[0].y), FP.camera);
			text[1].render(FP.buffer, new Point(x + pointsOfOptions[1].x, y + pointsOfOptions[1].y), FP.camera);
			text[2].render(FP.buffer, new Point(x + pointsOfOptions[2].x, y + pointsOfOptions[2].y), FP.camera);
			text[3].render(FP.buffer, new Point(x + pointsOfOptions[3].x, y + pointsOfOptions[3].y), FP.camera);
			
			optionSelectLeftImage.render(FP.buffer, new Point(x + pointsOfOptions[selectionPointer].x - 80, y + pointsOfOptions[selectionPointer].y), FP.camera);
			optionSelectRightImage.render(FP.buffer, new Point(x + pointsOfOptions[selectionPointer].x + 80, y + pointsOfOptions[selectionPointer].y), FP.camera);
			
			hint1Text.render(FP.buffer, new Point(x + backgroundImage.width / 2, y + backgroundImage.height - 30), FP.camera);
			hint2Text.render(FP.buffer, new Point(x + backgroundImage.width / 2, y + backgroundImage.height - 15), FP.camera);
		}
	}

}