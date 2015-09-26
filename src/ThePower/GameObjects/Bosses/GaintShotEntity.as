package ThePower.GameObjects.Bosses 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.Blocks.SolidEntity;
	import ThePower.GameObjects.Player.BulletEntity;
	import ThePower.GameObjects.Player.PlayerEntity;
	import ThePower.GlobalGameData;
	/**
	 * ...
	 * @author Amidos
	 */
	public class GaintShotEntity extends Entity
	{
		[Embed(source = '../../../../assets/Graphics/sprites/enemies/forest/giant_seeder_shot.png')]private var shotGraphics:Class;
		[Embed(source = '../../../../assets/Sounds/boss/giant_seeder_shot_destroy.mp3')]private var shotSound:Class;
		
		private var shotSfx:Sfx = new Sfx(shotSound);
		
		private var image:Image = new Image(shotGraphics);
		private var speed:Number = 5;
		private var amountOfDamage:Number = 10;
		
		public function GaintShotEntity(xIn:Number, yIn:Number) 
		{
			image.centerOO();
			graphic = image;
			
			x = xIn;
			y = yIn;
			
			setHitbox(image.width, image.height, image.originX, image.originY);
		}
		
		public function DestroyToChunks():void
		{
			shotSfx.play();
			
			FP.world.add(new GaintChunkEntity(x, y, 7, 92, -10));
			FP.world.add(new GaintChunkEntity(x, y, 7, 102, -10));
			FP.world.add(new GaintChunkEntity(x, y, 7, 112, -10));
			FP.world.add(new GaintChunkEntity(x, y, 7, 122, -10));
			
			FP.world.remove(this);
		}
		
		override public function update():void 
		{
			if (GlobalGameData.pauseGame)
			{
				return;
			}
			
			x += speed;
			
			var player:PlayerEntity = collide(CollisionNames.PlayerCollisionName, x, y) as PlayerEntity;
			if (player)
			{
				player.HitPlayer(amountOfDamage, 6);
			}
			
			var bullet:BulletEntity = collide(CollisionNames.PlayerBulletCollisionName, x, y) as BulletEntity;
			if (bullet)
			{
				bullet.BulletDestroy();
			}
			
			var solidEntity:SolidEntity = collide(CollisionNames.SolidCollisionName, x, y) as SolidEntity;
			
			if (solidEntity)
			{
				DestroyToChunks();
			}
			
			super.update();
		}
	}

}