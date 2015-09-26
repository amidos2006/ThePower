package ThePower.GameObjects.Bosses 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.Player.BulletEntity;
	import ThePower.GameObjects.Player.PlayerEntity;
	import ThePower.GlobalGameData;
	/**
	 * ...
	 * @author Amidos
	 */
	public class YetiSeekerShotEntity extends Entity
	{
		[Embed(source = "../../../../assets/Graphics/sprites/enemies/snow/yeti_bounce-seek_shot.png")]private var seekerShotClass:Class;
		
		private var speed:Number = 0;
		private var direction:Number = 0;
		private var amountOfDamage:Number = 10;
		private var timer:Alarm = new Alarm(30, ChangeToSeek, Tween.ONESHOT);
		private var image:Image = new Image(seekerShotClass);
		
		public function YetiSeekerShotEntity(xIn:Number, yIn:Number, speedIn:Number, directionIn:Number, damageIn:int = 10) 
		{
			image.centerOO();
			graphic = image;
			
			x = xIn;
			y = yIn;
			speed = speedIn;
			direction = directionIn;
			amountOfDamage = damageIn;
			
			addTween(timer, true);
			
			setHitbox(image.width - 4, image.height - 4, image.originX - 2, image.originY - 2);
		}
		
		private function ChangeToSeek():void
		{
			if (GlobalGameData.playerEntity)
			{
				speed = 2 * speed;
				direction = FP.angle(x, y, GlobalGameData.playerEntity.x, GlobalGameData.playerEntity.y);
			}
		}
		
		override public function update():void 
		{
			if (GlobalGameData.pauseGame)
			{
				return;
			}
			
			super.update();
			
			var updatedPosition:Point = new Point();
			FP.angleXY(updatedPosition, direction, speed);
			
			x += updatedPosition.x;
			y += updatedPosition.y;
			
			var playerBulletEntity:BulletEntity = collide(CollisionNames.PlayerBulletCollisionName, x, y) as BulletEntity;
			if (playerBulletEntity)
			{
				playerBulletEntity.BulletDestroy();
			}
			
			var playerEntity:PlayerEntity = collide(CollisionNames.PlayerCollisionName, x, y) as PlayerEntity;
			if (playerEntity)
			{
				playerEntity.HitPlayer(amountOfDamage, FP.sign(updatedPosition.x) * 4);
			}
			
			if (x > FP.width + image.width || x < -image.width || y > FP.height + image.height || y < -image.height)
			{
				FP.world.remove(this);
			}
		}
		
	}

}