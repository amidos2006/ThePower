package ThePower.GameObjects.Blocks 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.Player.PlayerEntity;
	import ThePower.GlobalGameData;
	/**
	 * ...
	 * @author Amidos
	 */
	public class JumpThroughBlockEntity extends Entity
	{
		[Embed(source = '../../../../assets/Graphics/sprites/blocks/jump_trough_block.png')]private var jumpThrough:Class;
		
		private var image:Image = new Image(jumpThrough);
		
		public function JumpThroughBlockEntity(xIn:Number , yIn:Number, layerConstant:Number) 
		{
			graphic = image;
			
			layer = layerConstant;
			x = xIn;
			y = yIn;
			setHitbox(image.width, image.height, image.originX, image.originY);
		}
		
		override public function update():void 
		{
			if (GlobalGameData.pauseGame)
			{
				FP.console.log(GlobalGameData.pauseGame);
				return;
			}
			
			super.update();
			
			if (FP.world.classCount(PlayerEntity) > 0)
			{
				if (GlobalGameData.playerEntity.GetLowestYInPlayer() <= y)
				{
					type = CollisionNames.SolidCollisionName;
				}
				else
				{
					type = CollisionNames.PlayerUnderCollisionName;
				}
			}
		}
		
	}

}