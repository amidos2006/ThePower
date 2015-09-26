package ThePower.GameObjects
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import ThePower.LayerConstants;
	/**
	 * ...
	 * @author Amidos
	 */
	public class BulletDestroyAnimationEntity extends Entity
	{
		private const image:String = "Image";
		
		private var spriteMap:Spritemap;
		
		public function BulletDestroyAnimationEntity(source:*, frameWidth:uint, frameHeight:uint, frames:Array,speed:Number = 0.5) 
		{
			spriteMap = new Spritemap(source, frameWidth, frameHeight, AnimationEnded);
			spriteMap.centerOO();
			spriteMap.add(image, frames, speed, false);
			spriteMap.play(image);
			graphic = spriteMap;
			layer = LayerConstants.BulletLowLayer;
		}
		
		private function AnimationEnded():void
		{
			FP.world.remove(this);
		}
	}

}