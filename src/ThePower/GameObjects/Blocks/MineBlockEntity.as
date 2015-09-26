package ThePower.GameObjects.Blocks 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.Explosion.ExplosionEmitterEntity;
	import ThePower.GlobalGameData;
	/**
	 * ...
	 * @author Amidos
	 */
	public class MineBlockEntity extends Entity
	{
		[Embed(source = '../../../../assets/Graphics/sprites/blocks/mine_block.png')]private var mineBlock:Class;
		[Embed(source = '../../../../assets/Graphics/sprites/weapons/mine-missile_explosion_strip5.png')]private var explosion:Class;
		
		private var image:Image = new Image(mineBlock);
		private var explosionEmitter:ExplosionEmitterEntity = new ExplosionEmitterEntity(explosion, 16, 16, 0xFFFFFF, [0, 1, 2, 3, 4], false, 10);
		
		public function MineBlockEntity(xIn:Number, yIn:Number, layerConstant:Number) 
		{
			x = xIn;
			y = yIn;
			layer = layerConstant;
			
			graphic = image;
			
			type = CollisionNames.SolidCollisionName;
			setHitbox(image.width, image.height, image.originX, image.originY);
		}
		
		public function DestroyMine():void
		{
			explosionEmitter.x = x;
			explosionEmitter.y = y;
			FP.world.add(explosionEmitter);
			FP.world.remove(this);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (collide(CollisionNames.PlayerMissleCollisionName, x, y))
			{
				if (GlobalGameData.misslePower >= 1)
				{
					DestroyMine();
				}
			}
		}
		
	}

}