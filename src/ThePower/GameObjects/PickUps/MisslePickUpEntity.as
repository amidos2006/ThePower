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
	public class MisslePickUpEntity extends PickUpEntity
	{
		[Embed(source="../../../../assets/Graphics/sprites/pick ups/missile_pickup_strip10.png")]private var misslePickUpClass:Class;
		
		public function MisslePickUpEntity(xIn:Number, yIn:Number, layerConstant:Number) 
		{
			spriteMap = new Spritemap(misslePickUpClass, 32, 32);
			
			super(xIn, yIn, layerConstant);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (collide(CollisionNames.PlayerCollisionName, x , y))
			{
				itemPickUpSfx.play();
				GlobalGameData.currentAmountOfWeapons += 1;
				GlobalGameData.maxMissleAmount += 4;
				GlobalGameData.playerEntity.amountOfMisslePlayerHad = GlobalGameData.maxMissleAmount;
				GlobalGameData.misslePower += 1;
				GlobalGameData.missleUpgradePickup = false;
				GlobalGameData.currentAssignedWeapon = GlobalGameData.currentAmountOfWeapons - 1;
				TextBoxEntity.ShowTextBox("You got the missles # You can use missles by Pressing Z # # Press down to switch weapons", (itemPickUpSfx.length + 1) * FP.frameRate);
				FP.world.remove(this);
				return;
			}
		}
	}

}