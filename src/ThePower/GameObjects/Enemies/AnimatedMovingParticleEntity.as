package ThePower.GameObjects.Enemies 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import ThePower.LayerConstants;
	/**
	 * ...
	 * @author Amidos
	 */
	public class AnimatedMovingParticleEntity extends Entity
	{
		private const image:String = "Image";
		
		public var spriteMap:Spritemap;
		public var particleSpeed:Number;
		public var particleDirection:Number;
		public var scaleDecrement:Number;
		
		public function AnimatedMovingParticleEntity(source:*, frameWidth:uint, frameHeight:uint, frames:Array, direction:Number, speed:Number, xIn:Number, yIn:Number, frameRate:uint = 1, objectLayer:Number = LayerConstants.ParticleLayer) 
		{
			spriteMap = new Spritemap(source, frameWidth, frameHeight);
			
			spriteMap.add(image, frames, frameRate, true);
			spriteMap.centerOO();
			graphic = spriteMap;
			
			particleSpeed = speed;
			particleDirection = direction;
			scaleDecrement = frameRate / 60;
			
			x = xIn;
			y = yIn;
			
			layer = objectLayer;
		}
		
		public function EditAlpha(alpha:Number):void
		{
			spriteMap.alpha = alpha;
		}
		
		override public function update():void 
		{
			super.update();
			
			spriteMap.scale -= scaleDecrement;
			var currentSpeed:Number = spriteMap.scale * particleSpeed;
			
			if (spriteMap.scale <= 0)
			{
				FP.world.remove(this);
			}
			
			var point:Point = new Point();
			FP.angleXY(point, particleDirection, currentSpeed);
			
			x += point.x;
			y += point.y;
			
			spriteMap.play(image);
		}
	}

}