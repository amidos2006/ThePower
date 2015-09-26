package ThePower.GameWorlds 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import ThePower.GlobalGameData;
	/**
	 * ...
	 * @author Amidos
	 */
	public class SnowGenerator extends Entity
	{
		private const numberOfDivisions:Number = 4;
		private const numberOfIntialization:Number = 1;
		
		private var snowAlarm:Alarm = new Alarm(10, GenerateSnow, Tween.LOOPING);
		
		public function SnowGenerator() 
		{
			addTween(snowAlarm, true);
		}
		
		override public function added():void 
		{
			super.added();
			Intialize();
		}
		
		private function GenerateSnow():void
		{
			var divisionPart:Number = FP.width / numberOfDivisions;
			
			for (var i:Number = 0; i < numberOfDivisions; i += 1)
			{
				var tempX:Number = FP.random * divisionPart + i * divisionPart;
				var tempY:Number = -10;
				
				FP.world.add(new SnowParticle(tempX, tempY));
			}
		}
		
		private function Intialize():void
		{
			var divisionPart:Number = FP.width / numberOfDivisions;
			
			for (var j:Number = 0; j < FP.height; j += GlobalGameData.gridSize / 2* FP.random)
			{
				for (var nothing:Number = 0; nothing < numberOfIntialization; nothing += 1)
				{
					for (var i:Number = 0; i < numberOfDivisions; i += 1)
					{
						var tempX:Number = FP.random * divisionPart + i * divisionPart;
						var tempY:Number = j;
						
						FP.world.add(new SnowParticle(tempX, tempY));
					}
				}
			}
		}
	}

}