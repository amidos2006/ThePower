package ThePower.GameObjects.Explosion 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Amidos
	 */
	public class AllDirectionExplosion
	{
		public static function GetAllDirectionExplosion(source:*, x:Number, y:Number, movingObjectSpeed:Number, numberOfExplosion:Number, timeOfTrail:Number = -1, timeBetweenTrails:Number = -1, timeOfEnd:Number = -1):void
		{
			var anglePortion:Number = 360 / numberOfExplosion;
			
			for (var i:Number = 0; i < 360; i += anglePortion)
			{
				var movingObject:MovingObjectWithTrailEntity = new MovingObjectWithTrailEntity(source, x, y, i, movingObjectSpeed);
				
				if (timeOfTrail > 0 && timeBetweenTrails > 0)
				{
					movingObject.EnableTrail(timeOfTrail, timeBetweenTrails);
				}
				
				if (timeOfEnd > 0)
				{
					movingObject.EnableDeathTime(timeOfEnd);
				}
				
				FP.world.add(movingObject);
			}
		}
		
	}

}