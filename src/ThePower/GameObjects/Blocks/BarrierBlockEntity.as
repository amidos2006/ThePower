package ThePower.GameObjects.Blocks 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.Explosion.ExplosionEmitterEntity;
	import ThePower.GlobalGameData;
	/**
	 * ...
	 * @author Amidos
	 */
	public class BarrierBlockEntity extends Entity
	{
		[Embed(source = '../../../../assets/Graphics/sprites/blocks/barrier.png')]private var barrierBlock:Class;
		
		private var image:Image = new Image(barrierBlock);
		
		public function BarrierBlockEntity(xIn:Number, yIn:Number, layerConstant:Number) 
		{
			x = xIn;
			y = yIn;
			layer = layerConstant;
			
			graphic = image;
			
			type = CollisionNames.SolidCollisionName;
			setHitbox(image.width, image.height, image.originX, image.originY);
		}
		
		public function RemoveBarrierBlock():void
		{
			FP.world.remove(this);
		}
		
	}

}