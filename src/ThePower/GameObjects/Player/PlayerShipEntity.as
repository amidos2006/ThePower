package ThePower.GameObjects.Player 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Amidos
	 */
	public class PlayerShipEntity extends Entity
	{
		[Embed(source = '../../../../assets/Graphics/sprites/player/ship.png')]private var shipGraphics:Class;
		
		public function PlayerShipEntity(xIn:Number, yIn:Number, layerConstant:Number) 
		{
			x = xIn;
			y = yIn;
			layer = layerConstant;
			
			graphic = new Image(shipGraphics);
		}
		
	}

}