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
	public class MinePickUpEntity extends PickUpEntity
	{
		[Embed(source='../../../../assets/Graphics/sprites/pick ups/mine_pickup_strip10.png')]private var minePickUpClass:Class;
		
		private var showText:Boolean = false;
		
		public function MinePickUpEntity(xIn:Number, yIn:Number, layerConstant:Number) 
		{
			spriteMap = new Spritemap(minePickUpClass, 32, 32);
			
			super(xIn, yIn, layerConstant);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (collide(CollisionNames.PlayerCollisionName, x , y) && !showText)
			{
				itemPickUpSfx.play();
				GlobalGameData.currentAmountOfWeapons += 1;
				TextBoxEntity.ShowTextBox("You got the mines # You can use mines by Pressing Z", itemPickUpSfx.length * FP.frameRate);
				showText = true;
				return;
			}
			
			if (FP.world.classCount(TextBoxEntity) == 0 && showText)
			{
				(FP.world.classFirst(GaintSeederEntity) as GaintSeederEntity).ShowBoss();
				FP.world.remove(this);
			}
		}
		
		override public function render():void 
		{
			if (!showText)
			{
				super.render();
			}
		}
	}

}