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
	public class SuitLevel2PickUpEntity extends PickUpEntity
	{
		[Embed(source='../../../../assets/Graphics/sprites/pick ups/suit2_pickup_strip10.png')]private var suitLevel2PickUpClass:Class;
		
		public function SuitLevel2PickUpEntity(xIn:Number, yIn:Number, layerConstant:Number) 
		{
			spriteMap = new Spritemap(suitLevel2PickUpClass, 32, 32);
			
			super(xIn, yIn, layerConstant);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (collide(CollisionNames.PlayerCollisionName, x , y))
			{
				itemPickUpSfx.play();
				GlobalGameData.suitPower += 1;
				GlobalGameData.suitUpgradeLevel2PickUp = false;
				TextBoxEntity.ShowTextBox("You got Suit Upgrade 2.", itemPickUpSfx.length * FP.frameRate);
				FP.world.remove(this);
				return;
			}
		}
		
	}

}