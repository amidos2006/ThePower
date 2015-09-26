package ThePower.GameObjects.CutScene 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.motion.LinearMotion;
	import ThePower.GameObjects.Enemies.AnimatedMovingParticleEntity;
	/**
	 * ...
	 * @author Amidos
	 */
	public class ThePowerParticleEffectsEntity extends Entity
	{
		[Embed(source = "../../../../assets/Graphics/sprites/pick ups/powerparticle_strip5.png")]private var thePowerParticles:Class;
		
		private var alpha:Number = 0;
		private var speed:Number = 0;
		private var numberOfParticles:int = 1;
		private var range:Point = new Point();
		private var motionTween:LinearMotion;
		private var removeParticles:Boolean = false;
		private var endOfGeneration:Boolean = false;
		
		public function ThePowerParticleEffectsEntity(position:Point, dimension:Point) 
		{
			this.x = position.x + dimension.x / 2;
			this.y = position.y + dimension.y / 2;
			
			this.range.x = dimension.x - 16;
			this.range.y = dimension.y - 16;
		}
		
		public function RemoveParticles():void
		{
			removeParticles = true;
			
			motionTween = new LinearMotion();
			motionTween.setMotionSpeed(x, y, 156, y, 2);
			motionTween.start();
			addTween(motionTween);
		}
		
		public function EndGeneration():void
		{
			endOfGeneration = true;
		}
		
		public function GenerateMovingParticles():void
		{
			speed = 0.5;
		}
		
		public function set Alpha(value:Number):void
		{
			alpha = value;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (removeParticles)
			{
				x = motionTween.x;
				y = motionTween.y;
			}
			
			var direction:Number = FP.rand(360);
			var currentSpeed:Number = speed;
			if (currentSpeed != 0)
			{
				currentSpeed = speed + (FP.random - 0.5) * speed / 2;
			}
			
			if (!endOfGeneration)
			{
				var tempPosition:Point = new Point();
				for (var i:int = 0; i < numberOfParticles; i += 1)
				{
					tempPosition.x = x + (FP.random - 0.5) * range.x;
					tempPosition.y = y + (FP.random - 0.5) * range.y;
					
					var temp:AnimatedMovingParticleEntity = new AnimatedMovingParticleEntity(thePowerParticles, 6, 6, [0], direction, currentSpeed, tempPosition.x, tempPosition.y, 1);
					temp.EditAlpha(alpha);
					FP.world.add(temp);
				}
			}
		}
		
	}

}