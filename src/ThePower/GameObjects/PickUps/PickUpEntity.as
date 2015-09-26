package ThePower.GameObjects.PickUps 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	import ThePower.GameObjects.Blocks.BossBarrierBlockGenerator;
	import ThePower.GlobalGameData;
	/**
	 * ...
	 * @author Amidos
	 */
	public class PickUpEntity extends Entity
	{
		[Embed(source = '../../../../assets/Sounds/player/item_pickup.mp3')]private var itemPickUp:Class;
		
		protected var itemPickUpSfx:Sfx = new Sfx(itemPickUp);
		
		protected const image:String = "Image";
		
		protected var spriteMap:Spritemap;
		protected var pickUpAmount:Number = 4;
		
		private var speed:Number = 0.25;
		private var rangeOfMotion:Number = 5;
		private var originalX:Number;
		private var originalY:Number;
		
		public function PickUpEntity(xIn:Number, yIn:Number, layerConstant:Number) 
		{
			x = xIn;
			y = yIn;
			
			originalX = xIn;
			originalY = yIn;
			
			spriteMap.add(image, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 0.5, true);
			spriteMap.play(image);
			graphic = spriteMap;
			
			layer = layerConstant;
			
			setHitbox(spriteMap.width, spriteMap.height, spriteMap.originX, spriteMap.originY);
		}
		
		override public function removed():void 
		{
			super.removed();
			
			if (GlobalGameData.currentRoomNumber == 45 || GlobalGameData.currentRoomNumber == 46 || GlobalGameData.currentRoomNumber == 47)
			{
				BossBarrierBlockGenerator.DeleteBarrier();
			}
		}
		
		override public function update():void 
		{
			super.update();
			
			y += speed;
			if (y > originalY + rangeOfMotion || y < originalY - rangeOfMotion)
			{
				speed *= -1;
				y += speed;
			}
		}
		
	}

}