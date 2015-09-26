package ThePower.GameObjects.Blocks 
{
	import net.flashpunk.Entity;
	import ThePower.CollisionNames;
	/**
	 * ...
	 * @author Amidos
	 */
	public class SolidEntity extends Entity
	{
		public function SolidEntity(xIn:Number,yIn:Number,widthIn:Number,heightIn:Number) 
		{
			type = CollisionNames.SolidCollisionName;
			
			x = xIn;
			y = yIn;
			
			setHitbox(widthIn, heightIn);
		}
		
	}

}