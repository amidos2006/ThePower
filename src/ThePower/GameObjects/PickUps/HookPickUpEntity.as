package ThePower.GameObjects.PickUps 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.Bosses.GaintChunkEntity;
	import ThePower.GameObjects.Bosses.GaintSeederEntity;
	import ThePower.GameObjects.Player.PlayerStatus;
	import ThePower.GlobalGameData;
	import ThePower.OverLayerUI.TextBoxEntity;
	/**
	 * ...
	 * @author Amidos
	 */
	public class HookPickUpEntity extends PickUpEntity
	{
		[Embed(source='../../../../assets/Graphics/sprites/pick ups/hook_pickup_strip10.png')]private var hookPickUpClass:Class;
		
		private var showText:Boolean = false;
		private var collisionWithPlayer:Boolean = false;
		
		public function HookPickUpEntity(xIn:Number, yIn:Number, layerConstant:Number) 
		{
			spriteMap = new Spritemap(hookPickUpClass, 32, 32);
			
			super(xIn, yIn, layerConstant);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (!collisionWithPlayer && collide(CollisionNames.PlayerCollisionName, x , y))
			{
				itemPickUpSfx.play();
				GlobalGameData.currentAmountOfWeapons += 1;
				TextBoxEntity.ShowTextBox("You got the hook # You can use hook by Pressing Z # # Press down to switch weapons", (itemPickUpSfx.length + 1) * FP.frameRate);
				collisionWithPlayer = true;
				
				return;
			}
			
			if (FP.world.classCount(TextBoxEntity) <= 0 && collisionWithPlayer)
			{
				FP.world.remove(this);
			}
		}
	}

}