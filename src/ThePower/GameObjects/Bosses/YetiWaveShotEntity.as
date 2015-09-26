package ThePower.GameObjects.Bosses 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.utils.Draw;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.Player.BulletEntity;
	import ThePower.GameObjects.Player.PlayerEntity;
	import ThePower.GlobalGameData;
	/**
	 * ...
	 * @author Amidos
	 */
	public class YetiWaveShotEntity extends Entity
	{
		[Embed(source = "../../../../assets/Graphics/sprites/enemies/snow/yeti_wave_shot_strip20.png")]private var waveShotClass:Class;
		
		private var hspeed:Number = 0;
		private var amountOfDamage:Number = 10;
		private var playerName:String = "image";
		private var spriteMap:Spritemap = new Spritemap(waveShotClass, 32, 64);
		
		public function YetiWaveShotEntity(xIn:Number, yIn:Number, hspeedIn:Number, damageIn:int = 10) 
		{
			spriteMap.add(playerName, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19], 0.8);
			spriteMap.play(playerName);
			spriteMap.centerOO();
			
			graphic = spriteMap;
			
			x = xIn;
			y = yIn;
			hspeed = hspeedIn;
			amountOfDamage = damageIn;
			
			setHitbox(spriteMap.width - 8, spriteMap.height - 8, spriteMap.originX - 4, spriteMap.originY - 4);
		}
		
		override public function update():void 
		{
			if (GlobalGameData.pauseGame)
			{
				return;
			}
			
			x += hspeed;
			
			var playerBulletEntity:BulletEntity = collide(CollisionNames.PlayerBulletCollisionName, x, y) as BulletEntity;
			if (playerBulletEntity)
			{
				playerBulletEntity.BulletDestroy();
			}
			
			var playerEntity:PlayerEntity = collide(CollisionNames.PlayerCollisionName, x, y) as PlayerEntity;
			if (playerEntity)
			{
				playerEntity.HitPlayer(amountOfDamage, FP.sign(hspeed) * 4);
			}
			
			if (x > FP.width + spriteMap.width || x < -spriteMap.width)
			{
				FP.world.remove(this);
			}
			
			super.update();
		}
	}

}