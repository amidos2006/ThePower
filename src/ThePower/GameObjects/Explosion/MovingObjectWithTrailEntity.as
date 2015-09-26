package ThePower.GameObjects.Explosion 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.motion.LinearMotion;
	import ThePower.LayerConstants;
	/**
	 * ...
	 * @author Amidos
	 */
	public class MovingObjectWithTrailEntity extends Entity
	{
		private var image:Image;
		private var speed:Number;
		private var direction:Number;
		
		private var trailSource:*;
		private var trailSpeed:Number;
		private var timeBetweenTrailsAlarm:Alarm;
		
		private var deathAlarm:Alarm = new Alarm(20, DeathAlarmEnd, Tween.ONESHOT);
		
		public function MovingObjectWithTrailEntity(source:*, xIn:Number, yIn:Number, directionIn:Number, speedIn:Number) 
		{
			x = xIn;
			y = yIn;
			
			trailSource = source;
			
			image = new Image(source);
			image.centerOO();
			graphic = image;
			
			speed = speedIn;
			direction = directionIn;
			
			layer = LayerConstants.ParticleLayer;
			
			addTween(deathAlarm);
		}
		
		public function EnableDeathTime(time:Number = 20):void
		{
			deathAlarm.reset(time);
			deathAlarm.start();
		}
		
		public function DeathAlarmEnd():void
		{
			FP.world.remove(this);
		}
		
		public function EnableTrail(speed:Number=15, timeBetweenTrails:Number = 1):void
		{
			trailSpeed = speed;
			
			timeBetweenTrailsAlarm = new Alarm(timeBetweenTrails, GenerateTrail, Tween.LOOPING);
			addTween(timeBetweenTrailsAlarm, true);
		}
		
		private function GenerateTrail():void
		{
			FP.world.add(new TrailEntity(trailSource, x, y, trailSpeed));
		}
		
		override public function update():void 
		{
			super.update();
			
			var movementVector:Point = new Point();
			FP.angleXY(movementVector, direction, speed);
			
			x += movementVector.x;
			y += movementVector.y;
			
			if (x < -image.width || x > FP.width + image.width || y < -image.height || y > FP.height + image.height)
			{
				FP.world.remove(this);
			}
		}
		
	}

}