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
	import ThePower.GameObjects.Bosses.FrogEntity;
	import ThePower.GameObjects.Bosses.GaintChunkEntity;
	import ThePower.GameObjects.Bosses.GaintSeederEntity;
	import ThePower.GameObjects.Player.PlayerStatus;
	import ThePower.GameWorlds.RoomWorld;
	import ThePower.GlobalGameData;
	import ThePower.OverLayerUI.TextBoxEntity;
	/**
	 * ...
	 * @author Amidos
	 */
	public class BulletLevel2PickUpEntity extends PickUpEntity
	{
		[Embed(source="../../../../assets/Graphics/sprites/pick ups/upgraded_shot_pickup_strip10.png")]private var shotUpgradePickUpClass:Class;
		
		private var showText:Boolean = false;
		
		public function BulletLevel2PickUpEntity(xIn:Number, yIn:Number, layerConstant:Number) 
		{
			spriteMap = new Spritemap(shotUpgradePickUpClass, 32, 32);
			
			super(xIn, yIn, layerConstant);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (collide(CollisionNames.PlayerCollisionName, x , y))
			{
				itemPickUpSfx.play();
				GlobalGameData.shotPower += 1;
				TextBoxEntity.ShowTextBox("You got The Beam Upgrade", itemPickUpSfx.length * FP.frameRate);
				FP.world.remove(this);
				BossBarrierBlockGenerator.DeleteBarrier();
				(FP.world as RoomWorld).PlayProperMusic();
				(FP.world.classFirst(FrogEntity) as FrogEntity).SleepWell();
			}
		}
	}

}