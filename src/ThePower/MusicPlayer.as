package ThePower 
{
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.sound.SfxFader;
	import ThePower.GameObjects.ObjectDirection;
	/**
	 * ...
	 * @author Amidos
	 */
	public class MusicPlayer
	{
		[Embed(source = '../../assets/Music/thepower_1.mp3')]private static var music0:Class;
		[Embed(source = '../../assets/Music/thepower_synthony.mp3')]private static var music1:Class;
		[Embed(source = '../../assets/Music/thepower_shadowlands.mp3')]private static var music2:Class;
		[Embed(source = '../../assets/Music/thepower_whatt.mp3')]private static var music3:Class;
		[Embed(source = '../../assets/Music/thepower_2.mp3')]private static var music4:Class;
		[Embed(source = '../../assets/Music/thepower_castle.mp3')]private static var music5:Class;
		[Embed(source = '../../assets/Music/thepower_boss.mp3')]private static var music6:Class;
		[Embed(source = "../../assets/Music/thepower_end_good.mp3")]private static var music7:Class;
		[Embed(source = "../../assets/Music/thepower_end_bad.mp3")]private static var music8:Class;
		
		private static var music0Sfx:Sfx = new Sfx(music0);
		private static var music1Sfx:Sfx = new Sfx(music1);
		private static var music2Sfx:Sfx = new Sfx(music2);
		private static var music3Sfx:Sfx = new Sfx(music3);
		private static var music4Sfx:Sfx = new Sfx(music4);
		private static var music5Sfx:Sfx = new Sfx(music5);
		private static var music6Sfx:Sfx = new Sfx(music6);
		private static var music7Sfx:Sfx = new Sfx(music7);
		private static var music8Sfx:Sfx = new Sfx(music8);
		
		public static const Title_Music:Number = 0;
		public static const Intro_Music:Number = 0;
		public static const Snow_Music:Number = 1;
		public static const Forest_Music:Number = 2;
		public static const Cave_Music:Number = 3;
		public static const Water_Music:Number = 4;
		public static const Castle_Music:Number = 5;
		public static const Boss_Music:Number = 6;
		public static const Good_Ending_Music:Number = 7;
		public static const Bad_Ending_Music:Number = 8;
		
		private static var currentlyPlayingMusic:Number = -1;
		private static var musicArray:Array = new Array(music0Sfx, music1Sfx, music2Sfx, music3Sfx, music4Sfx, music5Sfx, music6Sfx, music7Sfx, music8Sfx);
		
		private static var direction:Number = ObjectDirection.None;
		
		public static function Stop():void
		{
			if (currentlyPlayingMusic != -1)
			{
				musicArray[currentlyPlayingMusic].stop();
				currentlyPlayingMusic = -1;
			}
		}
		
		public static function Play(input:Number):void
		{
			if (currentlyPlayingMusic != input)
			{
				Stop();
				
				currentlyPlayingMusic = input;
				
				if (input != -1)
				{
					musicArray[input].loop(0.8);
				}
			}
		}
	}

}