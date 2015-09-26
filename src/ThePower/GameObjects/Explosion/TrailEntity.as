package ThePower.GameObjects.Explosion 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import ThePower.LayerConstants;
	/**
	 * ...
	 * @author Amidos
	 */
	public class TrailEntity extends Entity
	{
		private var image:Image;
		private var decrementSpeed:Number;
		
		public function TrailEntity(source:*, xIn:Number, yIn:Number, speed:Number=15)
		{
			x = xIn;
			y = yIn;
			
			decrementSpeed = 1 / speed;
			
			image = new Image(source);
			image.centerOO();
			graphic = image;
			
			layer = LayerConstants.ParticleLayer;
		}

		override public function update():void 
		{
			super.update();
			
			image.scale -= decrementSpeed;
			
			if (image.scale <= 0)
			{
				FP.world.remove(this);
			}
		}
		
	}

}