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
	import ThePower.LayerConstants;
	/**
	 * ...
	 * @author Amidos
	 */
	public class SecondScreenTextEntity extends Entity
	{
		[Embed(source = '../../../assets/Graphics/impact.ttf',embedAsCFF="false", fontFamily = 'GameFont')]private var gameFont:Class;
		
		private var overlayerText:Vector.<Text> = new Vector.<Text>();
		private var pressSpaceToContinue:Text;
		
		private var intialY:Number = FP.height + 60;
		private var maxHeight:Number = 340;
		private var alphaDecrement:Number = 0.01;
		private var blackBackGround:BlackOverLayerEntity = new BlackOverLayerEntity();
		
		public var continueToNextScreen:Boolean = false;
		public var textFades:Boolean = false;
		public var vspeed:Number = 0;
		
		public function SecondScreenTextEntity() 
		{
			layer = LayerConstants.HUDLayer;
			
			Text.size = 16;
			Text.font = "GameFont";
			
			overlayerText.push(new Text(" "));
			overlayerText.push(new Text(" "));
			overlayerText.push(new Text("I saw an unidentified planet, one that I'd never seen before."));
			overlayerText.push(new Text("Where did this planet came from and what treasures does it hold?"));
			overlayerText.push(new Text("I decided that I could settle down later, ater this one final expedition."));
			
			for (var i:Number = 0; i < overlayerText.length; i += 1)
			{
				overlayerText[i].color = 0xFF80FF;
				overlayerText[i].centerOO();
			}
			
			Text.size = 12;
			
			pressSpaceToContinue = new Text("Press Space to continue")
			pressSpaceToContinue.color = 0xFFFFFF;
			pressSpaceToContinue.centerOO();
		}
		
		public function start():void
		{
			vspeed = -2;
		}
		
		override public function update():void 
		{
			intialY += vspeed;
			
			if (intialY < maxHeight)
			{
				intialY = maxHeight;
				vspeed = 0;
				continueToNextScreen = true;
			}
			
			if (continueToNextScreen && Input.pressed(Key.SPACE) && !textFades)
			{
				textFades = true;
				FP.world.add(blackBackGround);
			}
			
			if (blackBackGround.alphaImage >= 1)
			{
				FP.world = new IntroScreen3World();
			}
			
		}
		
		override public function render():void 
		{
			super.render();
			
			for (var i:Number = 0; i < overlayerText.length; i += 1)
			{
				overlayerText[i].render(FP.buffer, new Point(FP.width / 2, intialY + i * 16), new Point());
			}
			
			pressSpaceToContinue.render(FP.buffer, new Point(FP.width / 2, intialY + overlayerText.length * 18), new Point());
		}
		
	}

}