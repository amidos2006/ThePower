package ThePower.GameObjects.Blocks 
{
	import net.flashpunk.Entity;
	import ThePower.CollisionNames;
	/**
	 * ...
	 * @author Amidos
	 */
	public class DirectionalBlockEntity extends Entity
	{
		public var currentDirection:Number;
		
		public function DirectionalBlockEntity(xIn:Number, yIn:Number, direction:Number) 
		{
			x = xIn;
			y = yIn;
			type = CollisionNames.ChangingDirectionCollisionName;
			setHitbox(32, 32);
			
			currentDirection = direction;
		}
		
	}

}