package ThePower.GameObjects.Blocks 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.Explosion.ExplosionEmitterEntity;
	import ThePower.GlobalGameData;
	/**
	 * ...
	 * @author Amidos
	 */
	public class SaveBlockEntity extends Entity
	{
		[Embed(source = '../../../../assets/Graphics/sprites/blocks/save_strip10.png')]private var saveBlock:Class;
		
		private const imageStatus:String = "image";
		
		private var spriteMap:Spritemap = new Spritemap(saveBlock, 32, 32);
		
		public function SaveBlockEntity(xIn:Number, yIn:Number, layerConstant:Number) 
		{
			x = xIn;
			y = yIn;
			layer = layerConstant;
			
			spriteMap.add(imageStatus, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 0.5, true);
			spriteMap.play(imageStatus);
			graphic = spriteMap;
			
			type = CollisionNames.SolidCollisionName;
			setHitbox(spriteMap.width, spriteMap.height, spriteMap.originX, spriteMap.originY);
		}
	}

}