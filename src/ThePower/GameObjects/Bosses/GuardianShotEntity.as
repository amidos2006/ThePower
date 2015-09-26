package ThePower.GameObjects.Bosses 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.Player.PlayerEntity;
	import ThePower.GlobalGameData;
	/**
	 * ...
	 * @author Amidos
	 */
	public class GuardianShotEntity extends Entity
	{
		[Embed(source = "../../../../assets/Graphics/sprites/enemies/castle/power_guardian_attack_strip3.png")]private var shotClass:Class;
		
		private var spriteMap:Spritemap  = new Spritemap(shotClass, 16, 23);
		private var speed:int = 7;
		private var damage:int = 10;
		
		public function GuardianShotEntity(inX:int, inY:int, direction:int, damageIn:int = 10) 
		{
			x = inX;
			y = inY;
			speed *= direction;
			
			spriteMap.centerOO();
			spriteMap.add("normal", [0, 1, 2], 0.25);
			spriteMap.play("normal");
			graphic = spriteMap;
			
			damage = damageIn;
			
			setHitbox(spriteMap.width, spriteMap.height, spriteMap.originX, spriteMap.originY);
		}
		
		override public function update():void 
		{
			if (GlobalGameData.pauseGame)
			{
				return;
			}
			
			super.update();
			
			x += speed;
			
			if (x > FP.width + spriteMap.width || x < -spriteMap.width)
			{
				FP.world.remove(this);
			}
			
			spriteMap.flipped = false;
			if (speed < 0)
			{
				spriteMap.flipped = true;
			}
			
			var tempPlayer:PlayerEntity = collide(CollisionNames.PlayerCollisionName, x, y) as PlayerEntity;
			if (tempPlayer)
			{
				tempPlayer.HitPlayer(damage, FP.sign(speed) * 4);
				FP.world.remove(this);
			}
		}
		
	}

}