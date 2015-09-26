package ThePower.GameObjects.PickUps 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.Player.PlayerStatus;
	import ThePower.GlobalGameData;
	import ThePower.OverLayerUI.TextBoxEntity;
	/**
	 * ...
	 * @author Amidos
	 */
	public class LifePickUpEntity extends PickUpEntity
	{
		[Embed(source='../../../../assets/Graphics/sprites/pick ups/life_pickup_strip10.png')]private var lifePickUpClass:Class;
		
		public function LifePickUpEntity(xIn:Number, yIn:Number, layerConstant:Number) 
		{
			spriteMap = new Spritemap(lifePickUpClass, 32, 32);
			
			super(xIn, yIn, layerConstant);
			
			pickUpAmount = 20;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (collide(CollisionNames.PlayerCollisionName, x , y))
			{
				GlobalGameData.maxHealthAmount += pickUpAmount;
				GlobalGameData.playerEntity.playerHealth += pickUpAmount;
				GlobalGameData.numberOfHealthPicks += 1;
				GlobalGameData.healthPickups[GlobalGameData.currentRoomNumber] = false;
				itemPickUpSfx.play();
				TextBoxEntity.ShowTextBox("Energy capacity increased by 20", itemPickUpSfx.length * FP.frameRate);
				FP.world.remove(this);
			}
		}
	}

}