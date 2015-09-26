package ThePower.OverLayerUI 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import ThePower.GlobalGameData;
	import ThePower.LayerConstants;
	/**
	 * ...
	 * @author Amidos
	 */
	public class HowToPlayEntity extends Entity
	{
		[Embed(source = '../../../assets/Graphics/impact.ttf',embedAsCFF="false", fontFamily = 'GameFont')]private var font:Class;
		[Embed(source = '../../../assets/Graphics/sprites/blocks/save_strip10.png')]private var saveBlock:Class;
		[Embed(source = '../../../assets/Graphics/sprites/inventory/howtoplay_window.png')]private var howToPlay:Class;
		
		private var howToPlayText:Vector.<Text> = new Vector.<Text>();
		private var pressSpaceToContinue:Text = new Text("Press Space to Continue");
		private var saveBlockImage:Image = new Image(saveBlock, new Rectangle(0, 0, 32, 32));
		private var howToPlayImage:Image = new Image(howToPlay);
		
		public function HowToPlayEntity() 
		{
			Text.size = 16;
			Text.font = "GameFont";
			
			layer = LayerConstants.HUDLayer;
			
			howToPlayImage.centerOO();
			saveBlockImage.centerOO();
			
			howToPlayText.push(new Text("How to play"));
			howToPlayText.push(new Text("Move: Left and Right"));
			howToPlayText.push(new Text("Jump: Up"));
			howToPlayText.push(new Text("Shoot: X"));
			howToPlayText.push(new Text("Inventory: Space"));
			howToPlayText.push(new Text("Options: ESC"));
			howToPlayText.push(new Text("How to save"));
			howToPlayText.push(new Text("Stand on one of these blocks (              ) and press down"));
			
			for (var i:Number = 0; i < howToPlayText.length; i += 1)
			{
				if (i == 0 || i == 6)
				{
					howToPlayText[i].color = 0xFF80FF;
				}
				else
				{
					howToPlayText[i].color = 0xFFFFFF;
				}
				howToPlayText[i].centerOO();
			}
			
			Text.size = 12;
			
			pressSpaceToContinue.color = 0xFF80FF;
			pressSpaceToContinue.centerOO();
			
			GlobalGameData.pauseGame = true;
		}
		
		public static function Show():void
		{
			FP.world.add(new HowToPlayEntity());
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.pressed(Key.SPACE))
			{
				FP.world.remove(this);
				GlobalGameData.pauseGame = false;
				Input.clear();
			}
		}
		
		override public function render():void 
		{
			super.render();
			
			var windowPosition:Point = new Point(FP.width / 2, FP.height / 2);
			
			howToPlayImage.render(FP.buffer, windowPosition, FP.camera);
			
			var i:Number = 0;
			for (i = 0; i < howToPlayText.length - 2; i += 1)
			{
				howToPlayText[i].render(FP.buffer, new Point(windowPosition.x, windowPosition.y - howToPlayImage.height/2 + 20 + i * 35), FP.camera);
			}
			
			for (i = howToPlayText.length - 2; i < howToPlayText.length; i += 1)
			{
				howToPlayText[i].render(FP.buffer, new Point(windowPosition.x, windowPosition.y - howToPlayImage.height/2 + 60 + i * 35), FP.camera);
			}
			
			pressSpaceToContinue.render(FP.buffer, new Point(windowPosition.x, windowPosition.y - howToPlayImage.height/2 + howToPlayImage.height - 20), FP.camera);
			
			saveBlockImage.render(FP.buffer, new Point(windowPosition.x + 42, windowPosition.y - howToPlayImage.height/2 + 60 + 7 * 35), FP.camera);
		}
	}

}