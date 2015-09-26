package ThePower.GameObjects.Blocks 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Draw;
	import ThePower.CollisionNames;
	/**
	 * ...
	 * @author Amidos
	 */
	public class WaterBlockEntity extends Entity
	{
		[Embed(source = '../../../../assets/Graphics/sprites/blocks/water.png')]private var waterGraphics:Class;
		
		private var image:Image = new Image(waterGraphics);
		
		public function WaterBlockEntity(xIn:Number, yIn:Number, widthIn:Number, heightIn:Number, layerConstant:Number) 
		{
			x = xIn;
			y = yIn;
			layer = layerConstant;
			
			image.scaleX = widthIn / 32;
			image.scaleY = heightIn / 32;
			graphic = image;
			
			type = CollisionNames.WaterCollisionName;
			setHitbox(widthIn, heightIn, image.originX * image.scaleX, image.originY * image.scaleY);
		}
		
		override public function render():void 
		{
			super.render();
		}
		
	}

}