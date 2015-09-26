package ThePower.GameObjects.Bosses 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.Blocks.BossBarrierBlockGenerator;
	import ThePower.GameObjects.Blocks.SolidEntity;
	import ThePower.GameObjects.Enemies.AnimatedMovingParticleEntity;
	import ThePower.GameObjects.Explosion.ExplosionEmitterEntity;
	import ThePower.GameObjects.PickUps.ExtraMisslePickUpEntity;
	import ThePower.GameObjects.PickUps.LifePickUpEntity;
	import ThePower.GameObjects.Player.BulletEntity;
	import ThePower.GameObjects.Player.MissleEntity;
	import ThePower.GameObjects.Player.PlayerEntity;
	import ThePower.GameWorlds.RoomWorld;
	import ThePower.GlobalGameData;
	import ThePower.LayerConstants;
	import ThePower.MusicPlayer;
	import ThePower.OverLayerUI.TextBoxEntity;
	/**
	 * ...
	 * @author Amidos
	 */
	public class GaurdianEntity extends Entity
	{
		[Embed(source = "../../../../assets/Graphics/sprites/enemies/castle/power_guardian_strip.png")]private var guardianGraphicsClass:Class;
		[Embed(source = '../../../../assets/Graphics/sprites/weapons/missile_trail_strip5.png')]private var steamParticle:Class;
		[Embed(source = '../../../../assets/Graphics/sprites/enemies/enemy_hit_strip3.png')]private var enemyHitGraphics:Class;
		[Embed(source = "../../../../assets/Sounds/boss/guard_slash.mp3")]private var guardianSlashSound:Class;
		[Embed(source = '../../../../assets/Sounds/boss/boss_destroy.mp3')]private var bossDestroySound:Class;
		
		private const STANDING:String = "standing";
		private const RUNNING:String = "running";
		private const JUMPING:String = "jumping";
		private const ATTACKING:String = "attacking";
		
		private var slashSfx:Sfx = new Sfx(guardianSlashSound);
		private var bossDestroySfx:Sfx = new Sfx(bossDestroySound);
		private var spriteMap:Spritemap = new Spritemap(guardianGraphicsClass, 32, 32, SpriteAnimationEnds);
		private var enemyHit:Spritemap = new Spritemap(enemyHitGraphics, 32, 32, AnimationEnds);
		
		private var enemyHitName:String = "Hit";
		private var status:String = STANDING;
		private var startAttack:Alarm;
		private var attackAlarm:Alarm = new Alarm(70, SlashLaser, Tween.PERSIST);
		private var hspeed:int = 2;
		private var enemyIsHitted:Boolean = false;
		private var health:Number = 20;
		private var damage:Number = 10;
		private var showReaction:Boolean = false;
		private var gravity:Number = 0.25;
		private var vspeed:Number = 0;
		private var jumpSpeed:Number = -5;
		private var distanceToJump:Number = 80;
		private var blockDistanceJump:Number = 50;
		
		public function GaurdianEntity(xIn:int, yIn:int, showReactionIn:Boolean, direction:int = 1, isLevelTwo:Boolean = false) 
		{
			trace("Guardian Created");
			
			x = xIn + spriteMap.width / 2;
			y = yIn + spriteMap.height / 2;
			hspeed *= direction;
			showReaction = showReactionIn;
			
			visible = false;
			
			startAttack = new Alarm(50 + 50 * FP.random, SlashLaser, Tween.ONESHOT);
			addTween(startAttack);
			addTween(attackAlarm);
			
			spriteMap.centerOO();
			spriteMap.add(STANDING, [4]);
			spriteMap.add(RUNNING, [0, 1, 2, 3], 0.25);
			spriteMap.add(JUMPING, [5]);
			spriteMap.add(ATTACKING, [6, 6, 6, 6, 6], 0.25, false);
			graphic = spriteMap;
			
			enemyHit.centerOO();
			enemyHit.add(enemyHitName, [0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4], 5, false);
			enemyHit.color = 0xE3D3F1;
			enemyHit.scaleX = spriteMap.width / 32;
			enemyHit.scaleY = spriteMap.height / 32;
			
			setHitbox(spriteMap.width / 2, spriteMap.height, spriteMap.originX - spriteMap.width / 4, spriteMap.originY);
			
			if (isLevelTwo)
			{
				health = 150;
				damage = 40;
			}
		}
		
		private function SlashLaser():void
		{
			slashSfx.play();
			
			status = ATTACKING;
			
			if (FP.sign(GlobalGameData.playerEntity.x - x) != 0)
			{
				hspeed = Math.abs(hspeed) * FP.sign(GlobalGameData.playerEntity.x - x);
			}
			
			FP.world.add(new GuardianShotEntity(x, y, FP.sign(hspeed), damage));
			
			attackAlarm.start();
		}
		
		private function ShowBoss(levelNumber:int):void
		{
			if (showReaction)
			{
				MusicPlayer.Stop();
				
				BossBarrierBlockGenerator.ShowBarrier(levelNumber);
				
				switch(levelNumber)
				{
					case 47:
						TextBoxEntity.ShowTextBox("Your greed is beyond measure, stranger, and it has taken you too far, but this is as far as you will come.");
					break;
					case 46:
						TextBoxEntity.ShowTextBox("You persist, stranger? You persist in vain. \"The Power\" is not for the likes of you.");
					break;
					case 45:
						TextBoxEntity.ShowTextBox("You think you can just come to our Home and take away anything you desire!? Everything in our land is ours to keep. That means you too, stranger.");
					break;
					case 53:
						TextBoxEntity.ShowTextBox("Your greed ends here and now, stranger!");
					break;
					case 52:
						TextBoxEntity.ShowTextBox("I told you your persistence was in vain!");
					break;
					case 51:
						TextBoxEntity.ShowTextBox("You should have gone away when you had the chance!");
					break;
				}
			}
			
			for (var i:int = 0; i < 20; i += 1)
			{
				var direction:Number = 90 + (FP.random - 0.5) * 40;
				var speed:Number = 1.5 + FP.random * 0.5;
				FP.world.add(new AnimatedMovingParticleEntity(steamParticle, 7, 7, [0], direction, speed, x, y + spriteMap.height / 2 + 5, 1, layer));
			}
			
			visible = true;
		}
		
		private function SpriteAnimationEnds():void
		{
			if (status == ATTACKING)
			{
				status = RUNNING;
				if (!collide(CollisionNames.SolidCollisionName, x, y + 1))
				{
					status = JUMPING;
				}
			}
		}
		
		private function AnimationEnds():void
		{
			enemyIsHitted = false;
		}
		
		private function ThrowPickUp():void
		{
			switch(GlobalGameData.currentRoomNumber)
			{
				case 47:
					FP.world.add(new LifePickUpEntity(304, 384, LayerConstants.ObjectLayer));
				break;
				case 46:
					FP.world.add(new LifePickUpEntity(320, 320, LayerConstants.ObjectLayer));
				break;
				case 45:
					FP.world.add(new ExtraMisslePickUpEntity(304, 384, LayerConstants.ObjectLayer));
				break;
			}
			
			if (GlobalGameData.currentRoomNumber == 51 || GlobalGameData.currentRoomNumber == 52 || GlobalGameData.currentRoomNumber == 53)
			{
				BossBarrierBlockGenerator.DeleteBarrier();
			}
		}
		
		public function Hit(amountOfDamage:Number):void
		{
			health -= amountOfDamage;
			enemyIsHitted = true;
			enemyHit.play(enemyHitName, true);
			
			if (health <= 0)
			{
				Destroy();
				
				if (GlobalGameData.bosses[GlobalGameData.currentRoomNumber] && FP.world.classCount(GaurdianEntity) <= 1)
				{
					ThrowPickUp();
					
					GlobalGameData.bosses[GlobalGameData.currentRoomNumber] = false;
					
					(FP.world as RoomWorld).PlayProperMusic();
					
					var slashesObjects:Vector.<GuardianShotEntity> = new Vector.<GuardianShotEntity>();
					
					FP.world.getClass(GuardianShotEntity, slashesObjects);
					for (var i:int = 0; i < slashesObjects.length; i += 1)
					{
						FP.world.remove(slashesObjects[i]);
					}
				}
			}
		}
		
		public function Destroy():void
		{
			bossDestroySfx.play();
			
			FP.world.remove(this);
			
			var explosion:ExplosionEmitterEntity = new ExplosionEmitterEntity(enemyHitGraphics, 24, 24, 0xE3D3F1, [0], false, 8, true);
			explosion.x = x + spriteMap.width/2;
			explosion.y = y + spriteMap.height/2;
			FP.world.add(explosion);
			
			explosion = new ExplosionEmitterEntity(enemyHitGraphics, 12, 12, 0xE3D3F1, [0], false, 8, false);
			explosion.x = x + spriteMap.width/2;
			explosion.y = y + spriteMap.height/2;
			FP.world.add(explosion);
			
			slashSfx.stop();
		}
		
		private function ApplyJumping():void
		{
			if (!visible)
			{
				return;
			}
			
			if (status != JUMPING)
			{
				var block:SolidEntity = collide(CollisionNames.SolidCollisionName, x + FP.sign(hspeed) * blockDistanceJump, y) as SolidEntity;
				if (block)
				{
					vspeed = jumpSpeed;
					status = JUMPING;
				}
				
				var bullet:Array = new Array(); 
				FP.world.getClass(BulletEntity, bullet);
				
				for (var i:Number = 0; i < bullet.length; i += 1)
				{
					if (distanceToPoint(bullet[i].x, bullet[i].y) < distanceToJump 
						&& Math.floor(bullet[i].y / GlobalGameData.gridSize) == Math.floor(y / GlobalGameData.gridSize))
					{
						vspeed = jumpSpeed;
						status = JUMPING;
					}
				}
				
				var missles:Array = new Array(); 
				FP.world.getClass(MissleEntity, missles);
				
				for (i = 0; i < missles.length; i += 1)
				{
					if (distanceToPoint(missles[i].x, missles[i].y) < distanceToJump)
					{
						status = JUMPING;
						vspeed = jumpSpeed;
					}
				}
			}
		}
		
		private function ApplyPhysics():void
		{	
			if (status != STANDING)
			{
				if (collide(CollisionNames.SolidCollisionName, x + hspeed, y))
				{
					hspeed *= -1;
				}
				
				x += hspeed;
			}
			
			if (status == JUMPING)
			{
				vspeed += gravity;
				if (vspeed > 0)
				{
					for (var i:int = 0; i < Math.abs(vspeed); i += 1)
					{
						if (!collide(CollisionNames.SolidCollisionName, x, y + 1))
						{
							y += 1;
						}
						else
						{
							status = RUNNING;
							break;
						}
					}
				}
				else
				{
					y += vspeed;
				}
			}
		}
		
		private function CheckShowBoss():void 
		{
			if (!visible && GlobalGameData.bosses[GlobalGameData.currentRoomNumber])
			{
				switch(GlobalGameData.currentRoomNumber)
				{
					case 47:
						if (GlobalGameData.playerEntity.x < 576)
						{
							ShowBoss(GlobalGameData.currentRoomNumber);
						}
					break;
					case 46:
						if (GlobalGameData.playerEntity.x < 576)
						{
							ShowBoss(GlobalGameData.currentRoomNumber);
						}
					break;
					case 45:
						if (GlobalGameData.playerEntity.x < 320)
						{
							ShowBoss(GlobalGameData.currentRoomNumber);
						}
					break;
					case 53:
						if (GlobalGameData.playerEntity.x < 576)
						{
							ShowBoss(GlobalGameData.currentRoomNumber);
						}
					break;
					case 52:
						if (GlobalGameData.playerEntity.x < 576)
						{
							ShowBoss(GlobalGameData.currentRoomNumber);
						}
					break;
					case 51:
						if (GlobalGameData.playerEntity.x < 320)
						{
							ShowBoss(GlobalGameData.currentRoomNumber);
						}
					break;
				}
			}
		}
		
		private function ApplyDamage():void
		{
			if (!visible)
			{
				return;
			}
			
			var bullet:BulletEntity = collide(CollisionNames.PlayerBulletCollisionName, x, y) as BulletEntity;
			if (bullet)
			{
				FP.world.remove(bullet);
				Hit(bullet.GetBulletDamage());
			}
			
			var missle:MissleEntity = collide(CollisionNames.PlayerMissleCollisionName, x, y) as MissleEntity;
			if (missle)
			{
				missle.MissleDestroy();
				Hit(missle.GetMissleDamage());
			}
			
			var player:PlayerEntity = collide(CollisionNames.PlayerCollisionName, x, y) as PlayerEntity;
			if (player && visible)
			{
				player.HitPlayer(damage, hspeed);
			}
		}
		
		override public function update():void 
		{
			if (GlobalGameData.pauseGame)
			{
				return;
			}
			
			if (FP.world.classCount(TextBoxEntity) == 0 && visible && !startAttack.active)
			{
				status = RUNNING;
				MusicPlayer.Play(MusicPlayer.Boss_Music);
				startAttack.start();
			}
			
			if (!collide(CollisionNames.SolidCollisionName, x, y + 1))
			{
				status = JUMPING;
			}
			
			spriteMap.flipped = false;
			if (hspeed < 0)
			{
				spriteMap.flipped = true;
			}
			
			super.update();
			
			CheckShowBoss();
			
			ApplyDamage();
			
			ApplyJumping();
			
			ApplyPhysics();
			
			spriteMap.play(status);
			
			enemyHit.update();
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