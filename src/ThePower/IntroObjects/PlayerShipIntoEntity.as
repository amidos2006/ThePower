package ThePower.IntroObjects 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import ThePower.GameObjects.Enemies.AnimatedMovingParticleEntity;
	import ThePower.GameWorlds.IntroScreen1World;
	import ThePower.LayerConstants;
	/**
	 * ...
	 * @author Amidos
	 */
	public class PlayerShipIntoEntity extends Entity
	{
		[Embed(source = '../../../assets/Graphics/Intro/ship.png')]private var playerShip:Class;
		[Embed(source = '../../../assets/Graphics/Intro/ship trail.png')]private var shipTrail:Class;
		
		private var playerShipImage:Image = new Image(playerShip);
		private var trailAlarm:Alarm = new Alarm(8, GenerateTrail, Tween.LOOPING);
		
		public var generateTrail:Boolean = true;
		public var Hspeed:Number = 3;
		public var positionX:Number = FP.width / 2 - 200;
		public var noMovement:Boolean = false;
		public var isShocking:Boolean = false;
		public var directionOfMotion:Number = 1;
		
		public function PlayerShipIntoEntity() 
		{
			graphic = playerShipImage;
			layer = LayerConstants.PlayerLayer;
			
			x = 1000;
			y = FP.height / 2;
			
			addTween(trailAlarm, true);
		}
		
		private function GenerateTrail():void
		{
			if (generateTrail)
			{
				var speed:Number = 0;
				if (Hspeed == 0)
				{
					speed = -(FP.world as IntroScreen1World).starFieldEntity.Hspeed;
				}
				
				FP.world.add(new AnimatedMovingParticleEntity(shipTrail, 11, 11, [0], 180, speed, x - 10, y + playerShipImage.height - 6, 4, layer));
			}
		}
		
		override public function update():void 
		{
			super.update();
			
			x += Hspeed;
			
			if (x - FP.camera.x < positionX)
			{
				noMovement = true;
			}
			
			if (isShocking)
			{
				y += directionOfMotion/5;
				if (y > FP.height/2 + 3)
				{
					directionOfMotion *= -1;
				}
				if (y < FP.height / 2 - 3)
				{
					directionOfMotion *= -1;
				}
			}
		}
		
	}

}