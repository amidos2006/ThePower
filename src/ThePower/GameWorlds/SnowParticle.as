package ThePower.GameWorlds 
{
	import flash.accessibility.AccessibilityImplementation;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import ThePower.LayerConstants;
	/**
	 * ...
	 * @author Amidos
	 */
	public class SnowParticle extends Entity
	{
		[Embed(source = '../../../assets/Graphics/sprites/enemies/snow/snow_flake.png')]private var snowFlake:Class;
		
		private var vspeed:Number = 0.5;
		private var hspeed:Number = 0.5;
		private var direction:Number;
		private var image:Image = new Image(snowFlake);
		
		public function SnowParticle(xIn:Number, yIn:Number) 
		{
			graphic = image;
			layer = LayerConstants.ParticleLayer;
			
			direction = 2 * FP.rand(2) - 1;
			x = xIn;
			y = yIn;
		}
		
		override public function update():void 
		{
			super.update();
			
			y += vspeed;
			x += direction * hspeed;
			
			if (FP.random < 0.1)
			{
				direction = 2 * FP.rand(2) - 1;
			}
			
			if (y > FP.height + image.height)
			{
				FP.world.remove(this);
			}
		}
	}

}