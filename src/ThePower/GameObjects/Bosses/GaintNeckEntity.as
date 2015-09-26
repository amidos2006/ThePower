package ThePower.GameObjects.Bosses 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import ThePower.CollisionNames;
	import ThePower.LayerConstants;
	/**
	 * ...
	 * @author Amidos
	 */
	public class GaintNeckEntity extends Entity
	{
		[Embed(source = '../../../../assets/Graphics/sprites/enemies/forest/giant_seeder_neck.png')]private var neckGraphics:Class;
		
		private var image:Image = new Image(neckGraphics);
		
		public function GaintNeckEntity() 
		{
			image.centerOO();
			graphic = image;
			
			x = 80;
			y = 400;
			
			layer = LayerConstants.ObjectLayer;
			
			type = CollisionNames.SolidCollisionName;
			setHitbox(image.width, image.height, image.originX, image.originY);
		}
		
	}

}