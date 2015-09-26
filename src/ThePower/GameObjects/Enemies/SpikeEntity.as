package ThePower.GameObjects.Enemies 
{
	import net.flashpunk.utils.Draw;
	/**
	 * ...
	 * @author Amidos
	 */
	public class SpikeEntity extends BaseEnemyEntity
	{
		[Embed(source = '../../../../assets/Graphics/sprites/enemies/water/spikes.png')]private var spikesGraphics:Class;
		
		public function SpikeEntity(xIn:Number, yIn:Number, layerConstant:Number) 
		{
			super(spikesGraphics, 16, 16, 0x000000, 1, 20);
			
			x = xIn;
			y = yIn;
			layer = layerConstant;
		}
		
		override public function EnemyHit(amountOfDamage:Number, isMissle:Boolean = false):Boolean 
		{
			return false;
		}
	}

}