package ThePower.GameObjects.Player 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.Blocks.MineBlockEntity;
	import ThePower.GameObjects.Bosses.FrogWormEntity;
	import ThePower.GameObjects.Bosses.JrFrogEntity;
	import ThePower.GameObjects.Bosses.YetiEntity;
	import ThePower.GameObjects.Enemies.BaseEnemyEntity;
	import ThePower.GameObjects.Enemies.SeederEntity;
	import ThePower.GameObjects.Explosion.ExplosionEmitterEntity;
	import ThePower.LayerConstants;
	/**
	 * ...
	 * @author Amidos
	 */
	public class MineEntity extends Entity
	{
		[Embed(source = '../../../../assets/Graphics/sprites/weapons/mine_strip2.png')]private var mineStrip:Class;
		[Embed(source = '../../../../assets/Sounds/weapons/mine_destroy.mp3')]private var mineDestroy:Class;
		[Embed(source = '../../../../assets/Sounds/weapons/mine_collide.mp3')]private var mineCollide:Class;
		[Embed(source = '../../../../assets/Graphics/sprites/weapons/mine-missile_explosion_strip5.png')]private var explosion:Class;
		
		private var mineDestroySfx:Sfx = new Sfx(mineDestroy);
		private var mineCollideSfx:Sfx = new Sfx(mineCollide);
		
		private var firstCollide:Boolean = true;
		
		private var areaOfEffect:Number = 10;
		
		private var gravity:Number = 0.25;
		private var vspeed:Number = 0;
		
		private const image:String = "Image";
		private const amountOfDamage:Number = 2;
		
		private var spriteMap:Spritemap = new Spritemap(mineStrip, 12, 12);
		private var alarmEnds:Alarm = new Alarm(80, ExplodeMine, Tween.ONESHOT);
		
		private var explosionEmitter:ExplosionEmitterEntity = new ExplosionEmitterEntity(explosion, 16, 16, 0x00FF00, [0, 1, 2, 3, 4], false, 10);
		
		public function MineEntity(xIn:Number, yIn:Number) 
		{
			x = xIn;
			y = yIn;
			
			spriteMap.add(image, [0, 1], 0.25, true);
			spriteMap.play(image);
			spriteMap.centerOO();
			
			graphic = spriteMap;
			
			layer = LayerConstants.HighObjectLayer;
			
			addTween(alarmEnds, true);
			
			setHitbox(spriteMap.width, spriteMap.height, spriteMap.originX, spriteMap.originY);
		}
		
		public function ExplodeMine():void
		{
			var playerEntity:PlayerEntity = collide(CollisionNames.PlayerCollisionName, x, y) as PlayerEntity;
			if (playerEntity)
			{
				playerEntity.HitPlayer(amountOfDamage);
			}
			
			var mineBlock:MineBlockEntity = collide(CollisionNames.SolidCollisionName, x + areaOfEffect, y + 1) as MineBlockEntity;
			if (mineBlock)
			{
				mineBlock.DestroyMine();
			}
			
			mineBlock = collide(CollisionNames.SolidCollisionName, x - areaOfEffect, y + 1) as MineBlockEntity;
			if (mineBlock)
			{
				mineBlock.DestroyMine();
			}
			
			mineBlock = collide(CollisionNames.SolidCollisionName, x + areaOfEffect, y) as MineBlockEntity;
			if (mineBlock)
			{
				mineBlock.DestroyMine();
			}
			
			mineBlock = collide(CollisionNames.SolidCollisionName, x - areaOfEffect, y) as MineBlockEntity;
			if (mineBlock)
			{
				mineBlock.DestroyMine();
			}
			
			var enemyCollided:BaseEnemyEntity = collide(CollisionNames.EnemyCollisionName, x, y) as BaseEnemyEntity;
			if (enemyCollided)
			{
				var seederCheck:SeederEntity = enemyCollided as SeederEntity;
				
				if (seederCheck)
				{
					enemyCollided.Destroy();
				}
				else
				{
					enemyCollided.EnemyHit(amountOfDamage);
				}
			}
			
			var wormArray:Array = new Array();
			var worm:FrogWormEntity;
			FP.world.getClass(FrogWormEntity, wormArray);
			
			for (var i:int = 0; i < wormArray.length; i += 1)
			{
				worm = wormArray[i] as FrogWormEntity;
				if (FP.distance(worm.x, worm.y, x, y) < worm.width)
				{
					worm.Destroy();
				}
			}
			
			var bossCollided:JrFrogEntity = collide(CollisionNames.BossCollisionName, x, y) as JrFrogEntity;
			if (bossCollided)
			{
				bossCollided.Hit(amountOfDamage);
			}
			
			var yetiCollided:YetiEntity = collide(CollisionNames.BossCollisionName, x, y) as YetiEntity;
			if (yetiCollided)
			{
				yetiCollided.Hit(amountOfDamage);
			}
			
			mineDestroySfx.play();
			explosionEmitter.x = x;
			explosionEmitter.y = y;
			FP.world.add(explosionEmitter);
			FP.world.remove(this);
		}
		
		override public function update():void 
		{
			super.update();
			
			vspeed += gravity;
			
			for (var i:Number = 0; i < vspeed; i += 1)
			{
				if (collide(CollisionNames.SolidCollisionName, x, y + 1) || (collide(CollisionNames.PlayerUnderCollisionName, x, y+1) && !collide(CollisionNames.PlayerUnderCollisionName, x, y)))
				{
					vspeed = 0;
					if (firstCollide)
					{
						firstCollide = false;
						mineCollideSfx.play();
					}
				}
				else
				{
					y += 1;
				}
			}
		}
	}

}