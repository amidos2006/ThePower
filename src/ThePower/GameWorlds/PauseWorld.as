package ThePower.GameWorlds 
{
	import flash.display.BitmapData;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	import ThePower.LayerConstants;
	/**
	 * ...
	 * @author Amidos
	 */
	public class PauseWorld extends World
	{
		private var image:Image;
		
		public function PauseWorld(bitmapClass:BitmapData) 
		{
			image = new Image(bitmapClass);
			
			addGraphic(image, LayerConstants.TilesBelowLayer);
		}
		
		public function ChangeImage(bitmapClass:BitmapData):void
		{
			image = new Image(bitmapClass);
			addGraphic(image, LayerConstants.TilesBelowLayer);
		}
		
	}

}