package ThePower.GameObjects.Blocks 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.Explosion.ExplosionEmitterEntity;
	import ThePower.GlobalGameData;
	import ThePower.LayerConstants;
	/**
	 * ...
	 * @author Amidos
	 */
	public class BossBarrierBlockGenerator
	{
		[Embed(source = '../../../../assets/Sounds/boss/create_barrier.mp3')]private static var createBarrierSound:Class;
		
		private static var createBarrierSfx:Sfx = new Sfx(createBarrierSound);
		
		private static var barrierVector:Vector.<BarrierBlockEntity> = new Vector.<BarrierBlockEntity>();
		
		public static function ShowBarrier(roomNumber:Number):void
		{
			createBarrierSfx.play();
			
			switch(roomNumber)
			{
				case 4:
					barrierVector.push(new BarrierBlockEntity(608, 320, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 352, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 384, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 416, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 320, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 352, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 384, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 416, LayerConstants.ObjectLayer));
				break;
				case 6:
					barrierVector.push(new BarrierBlockEntity(608, 320, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 352, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 384, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 416, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 320, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 352, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 384, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 416, LayerConstants.ObjectLayer));
				break;
				case 13:
					barrierVector.push(new BarrierBlockEntity(480, 416, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 416, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 384, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 352, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 320, LayerConstants.ObjectLayer));
				break;
				case 23:
					barrierVector.push(new BarrierBlockEntity(608, 320, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 352, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 384, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 416, LayerConstants.ObjectLayer));
				break;
				case 27:
					barrierVector.push(new BarrierBlockEntity(608, 384, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 416, LayerConstants.ObjectLayer));
				break;
				case 38:
					barrierVector.push(new BarrierBlockEntity(544, 64, LayerConstants.ObjectLayer));
				break;
				case 45:
					barrierVector.push(new BarrierBlockEntity(0, 192, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 224, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 256, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 288, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 320, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 352, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 384, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 192, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 224, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 256, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 288, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 320, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 352, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 384, LayerConstants.ObjectLayer));
				break;
				case 46:
					barrierVector.push(new BarrierBlockEntity(0, 192, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 224, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 256, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 288, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 320, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 352, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 384, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 192, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 224, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 256, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 288, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 320, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 352, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 384, LayerConstants.ObjectLayer));
				break;
				case 47:
					barrierVector.push(new BarrierBlockEntity(0, 192, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 224, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 256, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 288, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 320, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 352, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 384, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 192, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 224, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 256, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 288, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 320, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 352, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 384, LayerConstants.ObjectLayer));
				break;
				case 51:
					barrierVector.push(new BarrierBlockEntity(0, 192, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 224, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 256, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 288, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 320, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 352, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 384, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 192, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 224, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 256, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 288, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 320, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 352, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 384, LayerConstants.ObjectLayer));
				break;
				case 52:
					barrierVector.push(new BarrierBlockEntity(0, 192, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 224, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 256, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 288, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 320, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 352, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 384, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 192, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 224, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 256, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 288, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 320, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 352, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 384, LayerConstants.ObjectLayer));
				break;
				case 53:
					barrierVector.push(new BarrierBlockEntity(0, 192, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 224, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 256, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 288, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 320, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 352, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(0, 384, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 192, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 224, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 256, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 288, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 320, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 352, LayerConstants.ObjectLayer));
					barrierVector.push(new BarrierBlockEntity(608, 384, LayerConstants.ObjectLayer));
				break;
			}
			
			for (var i:Number = 0; i < barrierVector.length; i += 1)
			{
				FP.world.add(barrierVector[i]);
			}
		}
		
		public static function DeleteBarrier():void
		{
			for (var i:Number = 0; i < barrierVector.length; i += 1)
			{
				FP.world.remove(barrierVector[i]);
			}
			
			barrierVector = new Vector.<BarrierBlockEntity>();
			
			if (GlobalGameData.currentRoomNumber == 53 || GlobalGameData.currentRoomNumber == 52 || GlobalGameData.currentRoomNumber == 51 || 
				GlobalGameData.currentRoomNumber == 47 || GlobalGameData.currentRoomNumber == 46 || GlobalGameData.currentRoomNumber == 45)
			{
				barrierVector.push(new BarrierBlockEntity(608, 192, LayerConstants.ObjectLayer));
				barrierVector.push(new BarrierBlockEntity(608, 224, LayerConstants.ObjectLayer));
				barrierVector.push(new BarrierBlockEntity(608, 256, LayerConstants.ObjectLayer));
				barrierVector.push(new BarrierBlockEntity(608, 288, LayerConstants.ObjectLayer));
				barrierVector.push(new BarrierBlockEntity(608, 320, LayerConstants.ObjectLayer));
				barrierVector.push(new BarrierBlockEntity(608, 352, LayerConstants.ObjectLayer));
				barrierVector.push(new BarrierBlockEntity(608, 384, LayerConstants.ObjectLayer));
				
				for (i = 0; i < barrierVector.length; i += 1)
				{
					FP.world.add(barrierVector[i]);
				}
			}
		}
	}

}