package ThePower.GameObjects.Player 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Draw;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.Blocks.SolidEntity;
	import ThePower.GameObjects.Bosses.FrogEntity;
	import ThePower.GameObjects.Enemies.BaseEnemyEntity;
	import ThePower.GameObjects.Enemies.BirdEntity;
	import ThePower.GameObjects.Enemies.HangSackBallEntity;
	import ThePower.GameObjects.Enemies.HangSackEntity;
	import ThePower.GlobalGameData;
	import ThePower.LayerConstants;
	/**
	 * ...
	 * @author Amidos
	 */
	public class RobEntity extends Entity
	{
		[Embed(source = '../../../../assets/Graphics/sprites/weapons/hook.png')]private var hookGraphics:Class;
		[Embed(source = '../../../../assets/Graphics/sprites/weapons/hook_rope.png')]private var ropeGraphics:Class;
		[Embed(source = '../../../../assets/Sounds/weapons/hook_collide.mp3')]private var hookCollide:Class;
		
		private var hookCollideSfx:Sfx = new Sfx(hookCollide);
		
		private var hookImage:Image = new Image(hookGraphics);
		private var ropeImage:Image = new Image(ropeGraphics);
		private var speed:Number = 7;
		private var reachTop:Boolean = false;
		
		public function RobEntity(xIn:Number, yIn:Number) 
		{
			x = xIn;
			y = yIn;
			
			hookImage.centerOO();
			
			graphic = hookImage;
			
			layer = LayerConstants.HighObjectLayer;
			
			setHitbox(hookImage.width, hookImage.height, hookImage.originX, hookImage.originY);
		}
		
		public function PlayerUnFreeze():void
		{
			GlobalGameData.playerEntity.playerStatus = PlayerStatus.PlayerStanding;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (!reachTop)
			{
				for (var i:Number = 0; i < speed; i += 1)
				{
					var collideObject:Entity = collide(CollisionNames.SolidCollisionName, x, y - 1);
					var collideSolid:SolidEntity = collideObject as SolidEntity;
					var enemyHit:Entity = collide(CollisionNames.EnemyCollisionName, x, y - 1);
					var birdEnemy:BirdEntity = enemyHit as BirdEntity;
					var hangSackBall:HangSackBallEntity = enemyHit as HangSackBallEntity;
					var hangSack:HangSackEntity = enemyHit as HangSackEntity;
					var bossHit:Entity = collide(CollisionNames.BossCollisionName, x, y - 1);
					var frogBoss:FrogEntity = bossHit as FrogEntity;
					
					if (!collideSolid && collideObject)
					{
						hookCollideSfx.play();
						PlayerUnFreeze();
						FP.world.remove(this);
						return;
					}
					
					if (collideSolid)
					{
						hookCollideSfx.play();
						reachTop = true;
						return;
					}
					
					if (!birdEnemy &&!hangSackBall && !hangSack && enemyHit)
					{
						PlayerUnFreeze();
						FP.world.remove(this);
						return;
					}
					
					if (birdEnemy || hangSack || hangSackBall)
					{
						(enemyHit as BaseEnemyEntity).Destroy();
						PlayerUnFreeze();
						FP.world.remove(this);
						return;
					}
					
					if (frogBoss)
					{
						if (frogBoss.Hitable())
						{
							frogBoss.Hit();
							PlayerUnFreeze();
							FP.world.remove(this);
							return;
						}
					}
					
					y -= 1;
				}
			}
			else
			{
				GlobalGameData.playerEntity.vspeed = -speed;
				if (collide(CollisionNames.PlayerCollisionName, x, y))
				{
					GlobalGameData.playerEntity.vspeed = -speed;
					PlayerUnFreeze();
					FP.world.remove(this);
					return;
				}
			}
			
			
			if (y < 0)
			{
				PlayerUnFreeze();
				FP.world.remove(this);
				return;
			}
		}
		
		override public function render():void 
		{
			var scale:Number = Math.abs(y - (GlobalGameData.playerEntity.y + GlobalGameData.playerEntity.spriteMap.height/2)) / ropeImage.height;
			ropeImage.scaleY = scale;
			ropeImage.render(FP.buffer, new Point(x - 2, y), FP.camera);
			
			super.render();
		}
		
	}

}