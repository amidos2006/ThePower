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
	import ThePower.LayerConstants;
	/**
	 * ...
	 * @author Amidos
	 */
	public class FirstScreenTextEntity extends Entity
	{
		[Embed(source = '../../../assets/Graphics/impact.ttf',embedAsCFF="false", fontFamily = 'GameFont')]private var gameFont:Class;
		
		private var overlayerText:Vector.<Text> = new Vector.<Text>();
		private var pressSpaceToContinue:Text;
		
		private var intialY:Number = FP.height + 60;
		private var maxHeight:Number = 320;
		private var alphaDecrement:Number = 0.05;
		
		public var continueToNextScreen:Boolean = false;
		public var textFades:Boolean = false;
		public var vspeed:Number = 0;
		
		public function FirstScreenTextEntity() 
		{
			layer = LayerConstants.HUDLayer;
			
			Text.size = 16;
			Text.font = "GameFont";
			
			overlayerText.push(new Text(" "));
			overlayerText.push(new Text(" "));
			overlayerText.push(new Text("I am a treasure hunter, traveling the  universe."));
			overlayerText.push(new Text("I've visited many places of incredible beauty."));
			overlayerText.push(new Text("I've seen all kinds of creatures and gathered many treasures."));
			overlayerText.push(new Text("My wealth is beyong messure. Just when I decided to settle down.."));
			overlayerText.push(new Text("It happened.."));
			
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
			
			if (continueToNextScreen && Input.pressed(Key.SPACE))
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
					FP.world.remove(this);
					
					var tempWorld:IntroScreen1World = (FP.world as IntroScreen1World);
					
					tempWorld.starFieldEntity.Hspeed = -6;
					tempWorld.playerShipEntity.Hspeed = 0;
					tempWorld.planetEntity.x = tempWorld.playerShipEntity.x + FP.width - 160;
					tempWorld.planetEntity.y = 50;
					tempWorld.add(tempWorld.planetEntity);
				}
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