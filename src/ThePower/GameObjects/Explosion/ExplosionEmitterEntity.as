package ThePower.GameObjects.Explosion 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Particle;
	import ThePower.LayerConstants;
	/**
	 * ...
	 * @author Amidos
	 */
	public class ExplosionEmitterEntity extends Entity
	{
		
		
		private const explosionAnimation:String = "Explosion";
		private const numberOfParticles:Number = 12;
		private const numberOfEqualDistribution:Number = 4;
		
		private var emitter:Emitter;
		
		public function ExplosionEmitterEntity(source:*, frameWidth:uint, frameHeight:uint, color:uint = 0xFFFFFF, frames:Array = null, isRandom:Boolean = true, numberOfDirections:Number = 4, isBoss:Boolean = false) 
		{
			emitter = new Emitter(source, frameWidth, frameHeight);
			
			layer = LayerConstants.ParticleLayer;
			
			emitter.newType(explosionAnimation, frames);
			emitter.setColor(explosionAnimation, color, color);
			
			var i:Number = 0;

			if (isRandom)
			{
				for (var j:Number = 0; j < numberOfEqualDistribution; j += 1)
				{
					emitter.setMotion(explosionAnimation, j*360/numberOfEqualDistribution, 80, 13, 360/numberOfEqualDistribution);
					for (i = 0; i < numberOfParticles/numberOfEqualDistribution; i += 1)
					{
						emitter.emit(explosionAnimation, x, y);
					}
				}
			}
			else
			{
				if (isBoss)
				{
					angleAmount = 360 / numberOfDirections;
					for (i = 0; i < 360; i += angleAmount)
					{
						emitter.setMotion(explosionAnimation, i + angleAmount/2, 800, 60);
						emitter.emit(explosionAnimation, x, y);
					}
				}
				else
				{
					var angleAmount:Number = 360 / numberOfDirections;
					for (i = 0; i < 360; i += angleAmount)
					{
						emitter.setMotion(explosionAnimation, i + angleAmount/2, 120, 18);
						emitter.emit(explosionAnimation, x, y);
					}
				}
			}
			
			graphic = emitter;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (emitter.particleCount <= 0)
			{
				FP.world.remove(this);
			}
		}
		
	}

}