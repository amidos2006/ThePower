package ThePower.IntroObjects 
{
	import flash.display.ColorCorrection;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import ThePower.CollisionNames;
	import ThePower.GameWorlds.IntroScreen1World;
	import ThePower.GameWorlds.IntroScreen3World;
	import ThePower.GameWorlds.RoomWorld;
	import ThePower.LayerConstants;
	/**
	 * ...
	 * @author Amidos
	 */
	public class ThirdScreenTextEntity extends Entity
	{
		[Embed(source = '../../../assets/Graphics/impact.ttf',embedAsCFF="false", fontFamily = 'GameFont')]private var gameFont:Class;
		
		private var overlayerText:Vector.<Text> = new Vector.<Text>();
		private var pressSpaceToContinue:Text;
		
		private var alphaIncrement:Number = 0.04;
		private var alphaDecrement:Number = 0.04;
		
		public var continueToNextScreen:Boolean = false;
		public var textFades:Boolean = false;
		
		public function ThirdScreenTextEntity() 
		{
			layer = LayerConstants.HUDLayer;
			
			Text.size = 16;
			Text.font = "GameFont";
			
			overlayerText.push(new Text("A strange force pulled my ship down to the surface as i got close."));
			overlayerText.push(new Text("I probably should have tried to escape right away, but I just couldn't "));
			overlayerText.push(new Text("resist this new oppertunity to explore, who knows what i might find.."));
			overlayerText.push(new Text(" "));
			overlayerText.push(new Text("So i opened the backdoor of my ship.."));
			
			for (var i:Number = 0; i < overlayerText.length; i += 1)
			{
				overlayerText[i].color = 0xFF80FF;
				overlayerText[i].alpha = 0;
				overlayerText[i].centerOO();
			}
			
			Text.size = 12;
			
			pressSpaceToContinue = new Text("Press Space to continue");
			pressSpaceToContinue.color = 0xFFFFFF;
			pressSpaceToContinue.alpha = 0;
			pressSpaceToContinue.centerOO();
		}
		
		override public function update():void 
		{
			if (continueToNextScreen && Input.pressed(Key.SPACE) && !textFades)
			{
				textFades = true;
			}
			
			if (textFades)
			{
				for (var i:Number = 0; i < overlayerText.length; i += 1)
				{
					overlayerText[i].alpha -= alphaDecrement;
				}
				
				pressSpaceToContinue.alpha -= alphaDecrement;
				
				if (pressSpaceToContinue.alpha <= 0)
				{
					FP.world = new RoomWorld();
				}
			}
			else
			{
				for (var j:Number = 0; j < overlayerText.length; j += 1)
				{
					overlayerText[j].alpha += alphaIncrement;
				}
				
				pressSpaceToContinue.alpha += alphaIncrement;
				
				if (pressSpaceToContinue.alpha >= 1)
				{
					continueToNextScreen = true;
				}
			}
			
		}
		
		override public function render():void 
		{
			super.render();
			
			for (var i:Number = 0; i < overlayerText.length; i += 1)
			{
				overlayerText[i].render(FP.buffer, new Point(FP.width / 2, FP.height/2 + (i - overlayerText.length/2) * 16), new Point());
			}
			
			pressSpaceToContinue.render(FP.buffer, new Point(FP.width / 2, FP.height/2 +  overlayerText.length/2 * 20), new Point());
		}
		
	}

}