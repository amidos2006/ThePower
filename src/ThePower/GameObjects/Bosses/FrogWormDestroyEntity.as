package ThePower.GameObjects.Bosses 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import ThePower.LayerConstants;
	/**
	 * ...
	 * @author Amidos
	 */
	public class FrogWormDestroyEntity extends Entity
	{
		[Embed(source = "../../../../assets/Graphics/sprites/enemies/cave/worm_die_strip4.png")]private var wormDieClass:Class;
		
		private var spriteMap:Spritemap = new Spritemap(wormDieClass, 32, 32, AnimationEnd);
		
		public function FrogWormDestroyEntity(xIn:int) 
		{
			x = xIn - spriteMap.width / 2;
			y = FP.height - 64;
			
			spriteMap.add("default", [0, 1, 2, 3], 0.3, false);
			graphic = spriteMap;
			
			spriteMap.play("default");
			
			layer = LayerConstants.HighObjectLayer;
		}
		
		private function AnimationEnd():void
		{
			FP.world.remove(this);
		}
		
	}

}