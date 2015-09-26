package ThePower.GameObjects.Enemies 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.utils.Data;
	import net.flashpunk.utils.Draw;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.Explosion.ExplosionEmitterEntity;
	import ThePower.GameObjects.ObjectDirection;
	import ThePower.GlobalGameData;
	/**
	 * ...
	 * @author Amidos
	 */
	public class BaseEnemyEntity extends Entity
	{
		[Embed(source = '../../../../assets/Graphics/sprites/enemies/enemy_destroy_strip5.png')]private var explosionSource:Class;
		[Embed(source = '../../../../assets/Graphics/sprites/enemies/enemy_hit_strip3.png')]private var enemyHitGraphics:Class;
		[Embed(source = '../../../../assets/Sounds/enemies/hit.mp3')]private var enemyHitSound:Class;
		[Embed(source = '../../../../assets/Sounds/enemies/enemy_destroy1.mp3')]private var enemyDestroySound:Class;
		[Embed(source = '../../../../assets/Sounds/enemies/enemy_destroy2.mp3')]private var enemyDestroy2Sound:Class;
		
		private var enemyHitSfx:Sfx = new Sfx(enemyHitSound);
		private var enemyDestroySfx:Sfx = new Sfx(enemyDestroySound);
		private var enemyDestroy2Sfx:Sfx = new Sfx(enemyDestroy2Sound);
		
		private var enemyHit:Spritemap = new Spritemap(enemyHitGraphics, 32, 32, AnimationEnds);
		private var enemyHitName:String = "Hit";
		private var enemyIsHitted:Boolean = false;
		
		protected var hitPoints:Number = 0;
		protected var spriteMap:Spritemap;
		protected var amountOfDamageToPlayer:Number;
		protected var enemyDirection:Number = ObjectDirection.Right;
		protected var enemyStatus:String;
		protected var onlyKillByMissleLevel:Number = 0;
		
		protected var explosionEmitter:ExplosionEmitterEntity;
		
		public function BaseEnemyEntity(source:*, frameWidth:uint, frameHeight:uint, color:uint, hitPointsIn:Number, amountOfDamage:Number) 
		{
			explosionEmitter = new ExplosionEmitterEntity(explosionSource, 12, 12, color, [0, 1, 2, 3, 4], false, 10);
			
			spriteMap = new Spritemap(source, frameWidth, frameHeight);
			
			enemyHit.add(enemyHitName, [0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4], 5, false);
			enemyHit.color = color;
			enemyHit.scaleX = frameWidth / 32;
			enemyHit.scaleY = frameHeight / 32;
			
			hitPoints = hitPointsIn;
			amountOfDamageToPlayer = amountOfDamage;
			
			graphic = spriteMap;
			
			type = CollisionNames.EnemyCollisionName;
			setHitbox(spriteMap.width, spriteMap.height, spriteMap.originX, spriteMap.originY);
		}
		
		public function GetAmountOfDamage():Number
		{
			return amountOfDamageToPlayer;
		}
		
		private function AnimationEnds():void
		{
			enemyIsHitted = false;
		}
		
		public function EnemyHit(amountOfDamage:Number, isMissle:Boolean = false):Boolean
		{
			if (!enemyIsHitted)
			{
				if (onlyKillByMissleLevel <= 0)
				{
					enemyHitSfx.play(0.25);
					enemyIsHitted = true;
					hitPoints -= amountOfDamage;
					enemyHit.play(enemyHitName, true);
				}
				else
				{
					if (isMissle && GlobalGameData.misslePower >= onlyKillByMissleLevel)
					{
						enemyHitSfx.play(0.25);
						enemyIsHitted = true;
						hitPoints -= amountOfDamage;
						enemyHit.play(enemyHitName, true);
					}
				}
			}
			return true;
		}
		
		public function Destroy():void
		{
			enemyDestroySfx.play();
			enemyDestroy2Sfx.play();
			explosionEmitter.x = x + spriteMap.width/2;
			explosionEmitter.y = y + + spriteMap.height/2;
			FP.world.add(explosionEmitter);
			FP.world.remove(this);
		}
		
		override public function update():void 
		{
			if (GlobalGameData.pauseGame)
			{
				return;
			}
			
			super.update();
			
			if (enemyIsHitted)
			{
				enemyHit.update();
			}
			
			if (hitPoints <= 0)
			{
				Destroy();
			}
			
			spriteMap.play(enemyStatus);
			
			if (enemyDirection == ObjectDirection.Left)
			{
				spriteMap.flipped = true;
			}
			else if (enemyDirection == ObjectDirection.Right)
			{
				spriteMap.flipped = false;
			}
		}
		
		public function GetEnemyDirection():Number
		{
			return enemyDirection;
		}
		
		public function isAlive():Boolean
		{
			if (hitPoints > 0)
			{
				return true;
			}
			
			return false;
		}
		
		override public function render():void 
		{
			super.render();
			if (enemyIsHitted)
			{
				enemyHit.render(FP.buffer, new Point(x, y), FP.camera);
			}
		}
	}

}