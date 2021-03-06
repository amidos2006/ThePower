package ThePower.GameObjects.PickUps 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.Blocks.BossBarrierBlockGenerator;
	import ThePower.GameObjects.Bosses.GaintChunkEntity;
	import ThePower.GameObjects.Bosses.GaintSeederEntity;
	import ThePower.GameObjects.Player.PlayerStatus;
	import ThePower.GlobalGameData;
	import ThePower.OverLayerUI.TextBoxEntity;
	/**
	 * ...
	 * @author Amidos
	 */
	public class SuperMisslePickUpEntity extends PickUpEntity
	{
		[Embed(source="../../../../assets/Graphics/sprites/pick ups/super_missile_pickup_strip10.png")]private var misslePickUpClass:Class;
		
		public function SuperMisslePickUpEntity(xIn:Number, yIn:Number, layerConstant:Number) 
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
				GlobalGameData.playerEntity.amountOfMisslePlayerHad = GlobalGameData.maxMissleAmount;
				GlobalGameData.misslePower += 1;
				TextBoxEntity.ShowTextBox("You got The Missle Upgrade.", itemPickUpSfx.length * FP.frameRate);
				FP.world.remove(this);
				BossBarrierBlockGenerator.DeleteBarrier();
				return;
			}
		}
	}

}