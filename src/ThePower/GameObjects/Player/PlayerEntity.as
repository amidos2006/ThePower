package ThePower.GameObjects.Player 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.Blocks.SaveBlockEntity;
	import ThePower.GameObjects.Enemies.BaseEnemyEntity;
	import ThePower.GameObjects.Enemies.EnemyBulletEntity;
	import ThePower.GameObjects.Enemies.HangSackBallEntity;
	import ThePower.GameObjects.Explosion.AllDirectionExplosion;
	import ThePower.GameObjects.ObjectDirection;
	import ThePower.GlobalGameData;
	import ThePower.LayerConstants;
	import ThePower.OverLayerUI.DeathMenuEntity;
	import ThePower.OverLayerUI.InventoryEntity;
	import ThePower.OverLayerUI.PauseMenuEntity;
	/**
	 * ...
	 * @author Amidos
	 */
	public class PlayerEntity extends Entity
	{
		[Embed(source='../../../../assets/Graphics/sprites/player/UnifiedPlayerSheet.png')]private var playerSheet:Class;
		[Embed(source = '../../../../assets/Sounds/player/walk.mp3')]private var playerWalking:Class;
		[Embed(source = '../../../../assets/Sounds/player/jump.mp3')]private var playerJump:Class;
		[Embed(source = '../../../../assets/Sounds/weapons/shoot.mp3')]private var playerShot:Class;
		[Embed(source = '../../../../assets/Sounds/player/hit.mp3')]private var playerHit:Class;
		[Embed(source = '../../../../assets/Sounds/player/die1.mp3')]private var playerDead:Class;
		[Embed(source = '../../../../assets/Graphics/sprites/player/char_die1.png')]private var playerExplosion:Class;
		[Embed(source = '../../../../assets/Sounds/player/die2.mp3')]private var playerDead2:Class;
		[Embed(source = '../../../../assets/Sounds/weapons/hook.mp3')]private var hookSound:Class;
		[Embed(source = '../../../../assets/Graphics/sprites/player/player_hit_strip5.png')]private var playerHitEffectGraphics:Class;
		
		/**
		 * This is player Sfx that he uses
		 */
		private var playerWalkSfx:Sfx = new Sfx(playerWalking);
		private var playerWalkSfxShadow:Sfx = new Sfx(playerWalking);
		private var playerJumpSfx:Sfx = new Sfx(playerJump);
		private var playerShotSfx:Sfx = new Sfx(playerShot);
		private var playerHitSfx:Sfx = new Sfx(playerHit);
		private var playerDeadSfx:Sfx = new Sfx(playerDead);
		private var playerDead2Sfx:Sfx = new Sfx(playerDead2);
		private var hookSfx:Sfx = new Sfx(hookSound);
		
		/**
		 * This constants is for the keyboard defined keys
		 */
		private const leftMove:String = "Left";
		private const rightMove:String = "Right";
		private const jump:String = "Jump";
		private const shoot:String = "Shoot";
		private const down:String = "Down";
		private const useSpecial:String = "Special";
		private const openInventory:String = "Inventory";
		
		/**
		 * This is the value when the player exceed from any side of the screen the room is changed
		 */
		private const boundriesOfTransition:Number = 15;
		
		/**
		 * This is a variable that holds the amount of damage the player takes when it doesnt have
		 * suit upgrade 1 and he is in snow
		 */
		private const amountOfDamageTakenBySnow:Number = 10;
		
		/**
		 * These are the times of the shotAlarm where the shotAlarm is fast when level 2 and slow
		 * when level 1
		 */
		private const fastShootingTime:Number = 6;
		private const slowShootingTime:Number = 12;
		
		/**
		 * This variables are responsible of the player position
		 */
		public var hspeed:Number = 0;
		public var vspeed:Number = 0;
		public var gravity:Number = 0;
		
		/**
		 * This constants are responsible on controlling the player movement variables
		 */
		private const friction:Number = 0.18;
		private const fallingGravity:Number = 0.25;
		private const acceleration:Number = 0.28;
		private const maxSpeed:Number = 3;
		private const jumpSpeed:Number = 7;
		private const waterFriction:Number = 0.23;
		private const waterFallingGravity:Number = 0.095;
		private const waterMaxSpeed:Number = 1.5;
		private const waterVspeed:Number = 2.75;
		
		/**
		 * This variables are responsible about player status
		 */
		public var playerStatus:String = PlayerStatus.PlayerStandFront;
		public var playerDirection:Number = ObjectDirection.Right;
		public var canBeHit:Boolean = true;
		public var canShoot:Boolean = true;
		public var amountOfMisslePlayerHad:Number = 0;
		public var playerHealth:Number = GlobalGameData.maxHealthAmount;
		public var isUnderWater:Boolean = false;
		public var playerHitted:Boolean = false;
		public var playerFloating:Boolean = false;
		
		/**
		 * This variables are responsible about the player status to be drawn or changed
		 */
		public var spriteMap:Spritemap = new Spritemap(playerSheet, 32, 32, AnimationEnds);
		public var playerHitEffect:Spritemap = new Spritemap(playerHitEffectGraphics, 32, 32, EffectAnimationEnds);
		public var hitAlarm:Alarm = new Alarm(60, EnableHit, Tween.PERSIST);
		public var shootAlarm:Alarm = new Alarm(slowShootingTime, EnableShoot, Tween.PERSIST);
		public var snowHitAlarm:Alarm = new Alarm(30, SnowHit, Tween.LOOPING);
		
		public function PlayerEntity() 
		{
			//Graphic Assigning
			spriteMap.add(PlayerStatus.PlayerWalking, [8,8,8,8, 7,7,7,7, 6,6,6,6, 5,5,5,5], 15, true);
			spriteMap.add(PlayerStatus.PlayerStanding, [10], 15, true);
			spriteMap.add(PlayerStatus.PlayerStandFront, [11], 15, true);
			spriteMap.add(PlayerStatus.PlayerJumping, [12], 15, true);
			spriteMap.add(PlayerStatus.PlayerHook, [13], 15, true);
			
			playerHitEffect.add(PlayerStatus.PlayerHit, [0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4], 5, false);
			
			//Keyboard Assigning
			Input.define(leftMove, Key.LEFT);
			Input.define(rightMove, Key.RIGHT);
			Input.define(jump, Key.UP);
			Input.define(down, Key.DOWN);
			Input.define(shoot, Key.X);
			Input.define(useSpecial, Key.Z);
			Input.define(openInventory, Key.SPACE);
			
			//adding the alarms of the shooting and hitting
			addTween(hitAlarm);
			addTween(shootAlarm);
			addTween(snowHitAlarm, true);
			
			//applying the collision name and collision boxes
			type = CollisionNames.PlayerCollisionName;
			setHitbox(spriteMap.width - 14, spriteMap.height, spriteMap.originX - 7, spriteMap.originY);
			layer = LayerConstants.PlayerLayer;
			graphic = spriteMap;
		}
		
		/**
		 * This function is responsible of intializing the speed of attack of the beam according to
		 * the current type of beam
		 */
		override public function added():void 
		{
			super.added();
			SnowHit();
			if (GlobalGameData.shotPower == 1)
			{
				shootAlarm.reset(slowShootingTime);
			}
			else if (GlobalGameData.shotPower == 2)
			{
				shootAlarm.reset(fastShootingTime);
			}
		}
		
		/**
		 * This function is used to make the player vulnerable to hitting
		 */
		private function EnableHit():void
		{
			canBeHit = true;
		}
		
		/**
		 * It is responsible to remove the player Effect from happening
		 */
		private function EffectAnimationEnds():void
		{
			playerHitted = false;
		}
		
		/**
		 * This function is used to make the player can shoot again (to make time interval between shooting)
		 */
		private function EnableShoot():void
		{
			canShoot = true;
		}
		
		/**
		 * This fuction responsible for making the player hitted
		 */
		private function SnowHit():void
		{
			if (GlobalGameData.suitPower <= 0 && GlobalGameData.snowEffect && !GlobalGameData.pauseGame)
			{
				HitPlayer(amountOfDamageTakenBySnow);
			}
			
		}
		
		/**
		 * is called when a non looping image has finished like the hitting image
		 */
		private function AnimationEnds():void
		{
			if (playerStatus == PlayerStatus.PlayerHit)
			{
				playerStatus = PlayerStatus.PlayerStanding;
			}
		}
		
		/**
		 * This function is responsible for firing bullets
		 */
		private function FireNormalBullet():void
		{
			if (canShoot)
			{
				if (playerStatus == PlayerStatus.PlayerStandFront)
				{
					playerStatus = PlayerStatus.PlayerStanding;
				}
				
				canShoot = false;
				shootAlarm.start();
				FP.world.add(new BulletEntity(playerDirection, x + spriteMap.width / 2, y + spriteMap.height / 2));
				playerShotSfx.play();
			}
		}
		
		private function UseSpecial():void
		{
			if (GlobalGameData.currentAmountOfWeapons > 0)
			{
				switch(GlobalGameData.currentAssignedWeapon)
				{
					case 0:
						if (FP.world.classCount(MineEntity) <= 0)
						{
							FP.world.add(new MineEntity(x + spriteMap.width / 2, y + spriteMap.height / 2));
						}
					break;
					case 1:
						if (FP.world.classCount(MissleEntity) < 3 && amountOfMisslePlayerHad > 0)
						{
							if (playerStatus == PlayerStatus.PlayerStandFront)
							{
								playerStatus = PlayerStatus.PlayerStanding;
							}
				
							amountOfMisslePlayerHad -= 1;
							FP.world.add(new MissleEntity(playerDirection, x + spriteMap.width / 2, y + spriteMap.height / 2));
						}
					break;
					case 2:
						if (FP.world.classCount(RobEntity) <= 0 && !collide(CollisionNames.SolidCollisionName,x,y-1) && collide(CollisionNames.SolidCollisionName,x,y+1))
						{
							hookSfx.play();
							hspeed = 0;
							playerStatus = PlayerStatus.PlayerHook;
							FP.world.add(new RobEntity(x + spriteMap.width / 2, y + spriteMap.height / 2));
						}
					break;
				}
			}
		}
		
		/**
		 * This function make the player status hit and decrease player health
		 * @param	amountOfDamage: this is the amound of damage dealt when the player hit an enemy stuff
		 */
		public function HitPlayer(amountOfDamage:Number , hitSpeed:Number=0):void
		{
			if (canBeHit)
			{
				if (FP.world.classCount(RobEntity) > 0)
				{
					FP.world.remove(FP.world.classFirst(RobEntity));
				}
				
				canBeHit = false;
				hitAlarm.start();
				playerHitted = true;
				playerStatus = PlayerStatus.PlayerStanding;
				playerHitEffect.play(PlayerStatus.PlayerHit, true);
				playerHitSfx.play();
				playerHealth -= amountOfDamage;
				if (collide(CollisionNames.SolidCollisionName, x, y + 1) && vspeed > -3)
				{
					vspeed += -3;
				}
				hspeed = hitSpeed;
				
				if (playerHealth <= 0)
				{
					playerHealth = 0;
					KillPlayer();
				}
			}
		}
		
		/**
		 * This function is responsible of removing player from the world and make all the death effects
		 */
		public function KillPlayer():void
		{
			FP.world.remove(this);
			
			AllDirectionExplosion.GetAllDirectionExplosion(playerExplosion, x, y, 6, 8, 10, 3);
			
			playerDeadSfx.play();
			playerDead2Sfx.play();
			
			playerWalkSfx.stop();
			playerWalkSfxShadow.stop();
			
			FP.world.add(new DeathMenuEntity(FP.width / 2, FP.height / 2));
		}
		
		/**
		 * Check keys for movement under floating water
		 */
		private function CheckFloatingKeys():void
		{
			if (Input.check(leftMove) && !collide(CollisionNames.SolidCollisionName, x - 1, y))
			{
				hspeed = -maxSpeed;
				playerDirection = ObjectDirection.Left;
			}
			
			if (Input.check(rightMove) && !collide(CollisionNames.SolidCollisionName, x + 1, y))
			{
				hspeed = maxSpeed;
				playerDirection = ObjectDirection.Right;
			}
			
			if (!Input.check(leftMove) && !Input.check(rightMove))
			{
				hspeed = 0;
			}
			
			if (Input.check(jump) && !collide(CollisionNames.SolidCollisionName, x , y - 1))
			{
				vspeed = -maxSpeed;
			}
			
			if (Input.check(down) && !collide(CollisionNames.SolidCollisionName, x, y + 1))
			{
				vspeed = maxSpeed;
			}
			
			if (!Input.check(jump) && !Input.check(down))
			{
				vspeed = 0;
			}
		}
		
		/**
		 * This method is responsible for checking on the keyboard keys and do the correct behaviour
		 * based on that key
		 */
		private function CheckKeys():void
		{
			if (GlobalGameData.disabelKeyboard)
			{
				return;
			}
			
			if (Input.check(shoot) && playerStatus != PlayerStatus.PlayerHook)
			{
				FireNormalBullet();
			}
			
			if (Input.pressed(useSpecial))
			{
				UseSpecial();
			}
			
			if (playerFloating)
			{
				CheckFloatingKeys();
				return;
			}
			
			if (Input.check(leftMove) && !collide(CollisionNames.SolidCollisionName, x - 1, y))
			{
				if (playerStatus != PlayerStatus.PlayerHook)
				{
					hspeed -= acceleration;
					playerDirection = ObjectDirection.Left;
				}
			}
			
			if (Input.check(rightMove) && !collide(CollisionNames.SolidCollisionName, x + 1, y))
			{
				if (playerStatus != PlayerStatus.PlayerHook)
				{
					hspeed += acceleration;
					playerDirection = ObjectDirection.Right;
				}
			}
			
			if (Input.pressed(down))
			{
				if (playerStatus != PlayerStatus.PlayerHit && playerStatus != PlayerStatus.PlayerHook)
				{
					var saveBlock:SaveBlockEntity = collide(CollisionNames.SolidCollisionName, x, y + 1) as SaveBlockEntity;
					
					//saving the game
					if (saveBlock)
					{
						playerStatus = PlayerStatus.PlayerStandFront;
						GlobalGameData.SaveData();
					}
					else
					{
						//change weapons
						GlobalGameData.ChangeCurrentAssignedWeapon();
					}
				}
			}
			
			if (collide(CollisionNames.SolidCollisionName,x,y+1))
			{
				if (playerStatus != PlayerStatus.PlayerHit && playerStatus != PlayerStatus.PlayerHook)
				{
					if (hspeed == 0)
					{
						if (playerStatus != PlayerStatus.PlayerStandFront)
						{
							playerStatus = PlayerStatus.PlayerStanding;
						}
					}
					else
					{
						playerStatus = PlayerStatus.PlayerWalking;
					}
				}
			}
			
			if (Input.pressed(jump) && collide(CollisionNames.SolidCollisionName,x,y+1))
			{
				if (playerStatus != PlayerStatus.PlayerHook)
				{
					if (!collide(CollisionNames.SolidCollisionName, x, y - 1))
					{
						vspeed = -jumpSpeed;
						playerJumpSfx.play();
						
						if (playerStatus != PlayerStatus.PlayerHit)
						{
							playerStatus = PlayerStatus.PlayerJumping;
						}
					}
				}
			}
		}
		
		/**
		 * This function is responsible for the player when floating underwater
		 */
		private function ApplyFloatingMovement():void
		{
			if (!collide(CollisionNames.SolidCollisionName, x + hspeed, y))
			{
				x += hspeed;
			}
			
			if (!collide(CollisionNames.SolidCollisionName, x, y + vspeed))
			{
				y += vspeed;
			}
		}
		
		/**
		 * This function is responsible for the changes happens in the player speed and position
		 * according to the current values of speed and acceleration.
		 */
		private function ApplyMovement():void
		{
			if (playerFloating)
			{
				ApplyFloatingMovement();
				return;
			}
			
			var tempFallingGravity:Number = fallingGravity;
			var tempFriction:Number = friction;
			var tempMaxSpeed:Number = maxSpeed;
			
			if (isUnderWater && GlobalGameData.suitPower < 2)
			{
				tempFriction = waterFriction;
				tempFallingGravity = waterFallingGravity;
				tempMaxSpeed = waterMaxSpeed;
				
				if (Math.abs(vspeed) > waterVspeed)
				{
					vspeed = FP.sign(vspeed) * waterVspeed;
				}
			}
			
			if(vspeed < 0 && isUnderWater == false && collide(CollisionNames.WaterCollisionName, x, y + 1))
			{
				vspeed *= 2;
				if (vspeed < -jumpSpeed)
				{
					vspeed = -jumpSpeed;
				}
			}
			
			//Applying the friction on the hspeed
			if (hspeed > 0)
			{
				hspeed -= tempFriction;
				if (hspeed < 0)
				{
					hspeed = 0;
				}
			}
			else if(hspeed < 0)
			{
				hspeed += tempFriction;
				if (hspeed > 0)
				{
					hspeed = 0;
				}
			}
			
			//applying the gravity
			if (!collide(CollisionNames.SolidCollisionName, x, y + 1))
			{
				if (playerStatus != PlayerStatus.PlayerHit && playerStatus != PlayerStatus.PlayerHook)
				{
					playerStatus = PlayerStatus.PlayerJumping;
				}
				gravity = tempFallingGravity;
				if (!Input.check(jump))
				{
					gravity = 2 * tempFallingGravity;
				}
			}
			else
			{
				gravity = 0;
			}
			vspeed += gravity;
			
			//be sure that the speed doesnt exceed max speed
			if (Math.abs(hspeed) > tempMaxSpeed)
			{
				hspeed = FP.sign(hspeed) * tempMaxSpeed;
			}
			
			//apply the hspeed
			for (var i:Number = 0; i < Math.abs(hspeed); i += 1)
			{
				if (!collide(CollisionNames.SolidCollisionName, x + FP.sign(hspeed), y))
				{
					x += FP.sign(hspeed);
				}
				else
				{
					hspeed = 0;
				}
			}
			
			//apply the vspeed
			for (var j:Number = 0; j < Math.abs(vspeed); j += 1)
			{
				if (!collide(CollisionNames.SolidCollisionName, x, y + FP.sign(vspeed)))
				{
					y += FP.sign(vspeed);
				}
				else
				{
					playerWalkSfxShadow.play();
					vspeed = 0;
					if (FP.world.classCount(RobEntity) > 0)
					{
						var rope:RobEntity = FP.world.classFirst(RobEntity) as RobEntity;
						FP.world.remove(rope);
						rope.PlayerUnFreeze();
					}
				}
			}
		}
		
		/**
		 * This function is responsible in applying sounds of the player
		 */
		private function ApplySounds():void
		{
			if (playerStatus == PlayerStatus.PlayerWalking)
			{
				if (!playerWalkSfx.playing)
				{
					playerWalkSfx.loop();
				}
			}
			else
			{
				playerWalkSfx.stop();
			}
		}
		
		/**
		 * This function is responsible for removing player moving sound used when you get an upgrade
		 */
		public function StopPlayerMoving():void
		{
			if (playerStatus == PlayerStatus.PlayerWalking)
			{
				playerStatus = PlayerStatus.PlayerStanding;
				spriteMap.play(playerStatus);
				playerWalkSfx.stop();
				playerWalkSfxShadow.stop();
			}
			
			hspeed = 0;
		}
		
		/**
		 * This class is responsible of checking the player if he passed to a new room or not and
		 * transfer him to the correct one
		 */
		private function PlayerTransition():Boolean
		{	
			if (x > FP.width - boundriesOfTransition)
			{
				FP.world.removeAll();
				FP.world.updateLists();
				
				GlobalGameData.pauseGame = true;
				FP.world.remove(this);
				GlobalGameData.nextRoomNumber += 1;
				x = boundriesOfTransition + 5;
			}
			
			if (x < boundriesOfTransition)
			{
				FP.world.removeAll();
				FP.world.updateLists();
				
				GlobalGameData.pauseGame = true;
				FP.world.remove(this);
				GlobalGameData.nextRoomNumber -= 1;
				x = FP.width - boundriesOfTransition - 5;
			}
			
			if (y < spriteMap.height / 2)
			{
				if (GlobalGameData.nextRoomNumber - GlobalGameData.numberOfRoomsInRow >= 0)
				{
					FP.world.removeAll();
					FP.world.updateLists();
					
					GlobalGameData.pauseGame = true;
					FP.world.remove(this);
					GlobalGameData.nextRoomNumber -= GlobalGameData.numberOfRoomsInRow;
					y = FP.height - spriteMap.height / 2;
				}
			}
			
			if (y > FP.height - spriteMap.height/2)
			{
				FP.world.removeAll();
				FP.world.updateLists();
				
				GlobalGameData.pauseGame = true;
				FP.world.remove(this);
				GlobalGameData.nextRoomNumber += GlobalGameData.numberOfRoomsInRow;
				y = spriteMap.height / 2;
			}
			
			return GlobalGameData.pauseGame;
		}
		
		/**
		 * Get lowest point in the player image
		 * @return y position of player plus distance between the originY and end of the image
		 */
		public function GetLowestYInPlayer():Number
		{
			return y + (spriteMap.height - spriteMap.originY);
		}
		
		public function FloatPlayer(input:Boolean):void
		{
			playerFloating = input;
			
			vspeed = 0;
			hspeed = 0;
		}
		
		private function ApplyDamage():void
		{
			var collidedEnemy:BaseEnemyEntity = collide(CollisionNames.EnemyCollisionName, x, y) as BaseEnemyEntity;
			
			if (collidedEnemy)
			{
				var directionOfHit:Number = collidedEnemy.GetEnemyDirection();
				if (directionOfHit == 0)
				{
					directionOfHit = 2 * FP.rand(2) - 1;
				}
				HitPlayer(collidedEnemy.GetAmountOfDamage(), 4 * directionOfHit);
				
				if (collidedEnemy as HangSackBallEntity)
				{
					collidedEnemy.Destroy();
				}
			}
			
			var collidedBulletEnemy:EnemyBulletEntity = collide(CollisionNames.EnemyBulletCollisionName, x, y) as EnemyBulletEntity;
			
			if (collidedBulletEnemy)
			{
				directionOfHit = collidedBulletEnemy.GetDirection();
				if (directionOfHit == 0)
				{
					directionOfHit = 2 * FP.rand(2) - 1;
				}
				
				HitPlayer(collidedBulletEnemy.GetAmountOfDamage(), 4 * directionOfHit);
				collidedBulletEnemy.DestroyBullet();
			}
		}
		
		/**
		 * This is overload over the update of the entity so that I can call all my function so the player
		 * do the required moves according to his state
		 */
		override public function update():void 
		{
			visible = true;
			
			if (GlobalGameData.pauseGame)
			{
				return;
			}
			
			super.update();
			
			ApplyMovement();
			
			if (playerStatus != PlayerStatus.PlayerHook)
			{
				CheckKeys();
			}
			
			if (Input.pressed(Key.ESCAPE))
			{
				GlobalGameData.pauseGame = true;
				GlobalGameData.PauseGameWorld(false, true);
			}
			
			if (Input.pressed(Key.SPACE))
			{				
				GlobalGameData.pauseGame = true;
				GlobalGameData.PauseGameWorld(true, false);
			}
			
			ApplySounds();
			
			ApplyDamage();
			
			if (playerDirection == ObjectDirection.Left)
			{
				spriteMap.flipped = true;
			}
			else if (playerDirection == ObjectDirection.Right)
			{
				spriteMap.flipped = false;
			}
			
			isUnderWater = false;
			if (collide(CollisionNames.WaterCollisionName, x, y))
			{
				isUnderWater = true;
			}
			
			if (playerHitted)
			{
				playerHitEffect.update();
			}
			
			if (playerFloating)
			{
				playerStatus = PlayerStatus.PlayerJumping;
			}
			
			spriteMap.play(playerStatus);
			
			if (PlayerTransition())
			{
				return;
			}
		}
		
		/**
		 * Override the render method if wanna check collision rectangles or other stuffs
		 */
		override public function render():void 
		{
			super.render();
			if (playerHitted)
			{
				playerHitEffect.render(FP.buffer, new Point(x, y), FP.camera);
			}
		}
	}

}