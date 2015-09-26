package ThePower.GameObjects.CutScene 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import ThePower.GameObjects.Enemies.AnimatedMovingParticleEntity;
	import ThePower.LayerConstants;
	/**
	 * ...
	 * @author Amidos
	 */
	public class ThePowerEntity extends Entity
	{
		[Embed(source = "../../../../assets/Graphics/sprites/pick ups/ThePower.png")]private var thePowerClass:Class;
		
		private var image:Image = new Image(thePowerClass);
		private var thePowerParticles:ThePowerParticleEffectsEntity;
		private var showParticles:Boolean = true;
		private var alphaSpeed:Number = 0.01;
		private var showThePower:Boolean = false;
		
		public function ThePowerEntity(xIn:int, yIn:int) 
		{
			this.x = xIn;
			this.y = yIn;
			
			image.alpha = 0;
			graphic = image;
			
			thePowerParticles = new ThePowerParticleEffectsEntity(new Point(xIn, yIn), new Point(image.width, image.height));
			FP.world.add(thePowerParticles);
			
			layer = LayerConstants.ObjectLayer;
		}
		
		public function Appear():void
		{
			showThePower = true;
		}
		
		public function RemoveParticles():void
		{
			showParticles = false;
			thePowerParticles.RemoveParticles();
		}
		
		public function EndGeneration():void
		{
			thePowerParticles.EndGeneration();
		}
		
		override public function update():void 
		{
			super.update();
			
			if (showThePower)
			{
				image.alpha += alphaSpeed;
				if (image.alpha > 1)
				{
					image.alpha = 1;
				}
				thePowerParticles.Alpha = image.alpha;
				thePowerParticles.GenerateMovingParticles();
			}
			
			thePowerParticles.update();
		}
	}

}