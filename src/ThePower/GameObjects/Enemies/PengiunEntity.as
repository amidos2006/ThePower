package ThePower.GameObjects.Enemies 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.Player.PlayerEntity;
	import ThePower.GlobalGameData;
	/**
	 * ...
	 * @author Amidos
	 */
	public class PengiunEntity extends BaseEnemyEntity
	{
		[Embed(source = '../../../../assets/Graphics/sprites/enemies/snow/big_penguin.png')]private var bigPenguinGraphics:Class;
		[Embed(source = '../../../../assets/Graphics/sprites/enemies/snow/peguin.png')]private var pengiunGraphics:Class;
		[Embed(source = '../../../../assets/Sounds/enemies/penguin_jump.mp3')]private var jumpSound:Class;
		
		private var jumpSfx:Sfx = new Sfx(jumpSound);
		
		private var hspeed:Number = 2;
		private var gravity:Number = 0.25;
		private var vspeed:Number = 0;
		private var boundry:Number = 10;
		private var bounceJump:Number = 4.5;
		
		private var changeDirectionAlarm:Alarm = new Alarm(20, AlarmEnded, Tween.PERSIST);
		
		public function PengiunEntity(xIn:Number, yIn:Number, layerConstant:Number, power:Number) 
		{
			var tempG:*;
			var tempSize:Number;
			var tempHealth:Number;
			var tempDamage:Number;
			
			if (power == 0)
			{
				tempG = pengiunGraphics;
				tempSize = 32;
				tempHealth = 3;
				tempDamage = 10;
			}
			else
			{
				tempG = bigPenguinGraphics;
				tempSize = 64;
				tempHealth = 25;
				tempDamage = 25;
			}
			
			super(tempG, tempSize, tempSize, 0x7575FF, tempHealth, tempDamage);
			
			x = xIn;
			y = yIn;
			layer = layerConstant;
			
			spriteMap.add(EnemyStatus.EnemyMoving, [0], 15, true);
			enemyStatus = EnemyStatus.EnemyMoving;
			
			if (FP.world.classCount(PlayerEntity) > 0)
			{
				if (FP.sign(GlobalGameData.playerEntity.x - x) != 0)
				{
					enemyDirection = FP.sign(GlobalGameData.playerEntity.x - x);
				}
			}
			
			addTween(changeDirectionAlarm, false);
			
			if (power != 0)
			{
				setHitbox(spriteMap.width - 20, spriteMap.height, spriteMap.originX - 10, spriteMap.originY);
			}
			
			jumpSfx.volume = 0.5;
		}
		
		private function AlarmEnded():void
		{
			if (FP.world.classCount(PlayerEntity) > 0)
			{
				if (FP.sign(GlobalGameData.playerEntity.x - x) != 0)
				{
					enemyDirection = FP.sign(GlobalGameData.playerEntity.x - x);
				}
			}
		}
		
		private function ApplyMotion():void
		{
			var i:Number = 0;
			
			if (!collide(CollisionNames.SolidCollisionName, x, y + 1))
			{
				vspeed += gravity;
			}
			
			for (i = 0; i < Math.abs(vspeed); i += 1)
			{
				y += FP.sign(vspeed);
				if (collide(CollisionNames.SolidCollisionName, x, y + 1))
				{
					vspeed = -bounceJump;
					jumpSfx.play(0.1);
					break;
				}
			}
			
			for (i = 0; i < hspeed; i += 1)
			{
				if (collide(CollisionNames.SolidCollisionName, x + 2* enemyDirection, y) || x + enemyDirection < boundry || x + spriteMap.width + enemyDirection > FP.width - boundry)
				{
					enemyDirection *= -1;
				}
				else
				{
					x += enemyDirection;
				}
			}
		}
		
		override public function update():void 
		{
			if (GlobalGameData.pauseGame)
			{
				return;
			}
			
			super.update();
			
			ApplyMotion();
			
			if (FP.world.classCount(PlayerEntity) > 0)
			{
				if (enemyDirection != FP.sign(GlobalGameData.playerEntity.x - x) && !changeDirectionAlarm.active && GlobalGameData.playerEntity.y == y)
				{
					changeDirectionAlarm.start();
				}
			}
		}
		
	}

}