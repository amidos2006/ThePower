package ThePower.GameObjects.PickUps 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	import ThePower.CollisionNames;
	import ThePower.GlobalGameData;
	import ThePower.OverLayerUI.TextBoxEntity;
	/**
	 * ...
	 * @author Amidos
	 */
	public class ExtraMisslePickUpEntity extends PickUpEntity
	{
		[Embed(source = '../../../../assets/Graphics/sprites/pick ups/extra_missiles_pickup_strip10.png')]private var extraMisslePickUpClass:Class;
		
		public function ExtraMisslePickUpEntity(xIn:Number, yIn:Number, layerConstant:Number) 
		{
			spriteMap = new Spritemap(extraMisslePickUpClass, 32, 32);
			
			super(xIn, yIn, layerConstant);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (collide(CollisionNames.PlayerCollisionName, x , y))
			{
				GlobalGameData.maxMissleAmount += pickUpAmount;
				GlobalGameData.playerEntity.amountOfMisslePlayerHad += pickUpAmount;
				GlobalGameData.numberOfMisslePicks += 1;
				GlobalGameData.misslesPickups[GlobalGameData.currentRoomNumber] = false;
				itemPickUpSfx.play();
				TextBoxEntity.ShowTextBox("Missiles capacity increased by 4", itemPickUpSfx.length * FP.frameRate);
				FP.world.remove(this);
			}
		}
		
	}

}