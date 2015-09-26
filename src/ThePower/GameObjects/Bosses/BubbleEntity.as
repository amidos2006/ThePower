package ThePower.GameObjects.Bosses 
{
	import flash.accessibility.AccessibilityImplementation;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import ThePower.CollisionNames;
	import ThePower.LayerConstants;
	/**
	 * ...
	 * @author Amidos
	 */
	public class BubbleEntity extends Entity
	{
		[Embed(source="../../../../assets/Graphics/sprites/enemies/castle/bubbles.png")]private var bubbleClass:Class;
		
		private var vspeed:Number = -0.5;
		private var hspeed:Number = 0.5;
		private var direction:Number;
		private var image:Image = new Image(bubbleClass);
		
		public function BubbleEntity(xIn:Number, yIn:Number) 
		{
			graphic = image;
			layer = LayerConstants.HighObjectLayer;
			
			direction = 2 * FP.rand(2) - 1;
			x = xIn;
			y = yIn;
			
			setHitbox(image.width, image.height);
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
			
			if (collide(CollisionNames.SolidCollisionName, x, y))
			{
				FP.world.remove(this);
			}
		}
	}

}