package ThePower 
{
	import flash.utils.ByteArray;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Amidos
	 */
	public class LevelGetter
	{
		[Embed(source = '../../assets/Rooms/room0.oel', mimeType = 'application/octet-stream')]private static var room0:Class;
		[Embed(source = '../../assets/Rooms/room1.oel', mimeType = 'application/octet-stream')]private static var room1:Class;
		[Embed(source = '../../assets/Rooms/room2.oel', mimeType = 'application/octet-stream')]private static var room2:Class;
		[Embed(source = '../../assets/Rooms/room3.oel', mimeType = 'application/octet-stream')]private static var room3:Class;
		[Embed(source = '../../assets/Rooms/room4.oel', mimeType = 'application/octet-stream')]private static var room4:Class;
		[Embed(source = '../../assets/Rooms/room5.oel', mimeType = 'application/octet-stream')]private static var room5:Class;
		[Embed(source = '../../assets/Rooms/room6.oel', mimeType = 'application/octet-stream')]private static var room6:Class;
		[Embed(source = '../../assets/Rooms/room7.oel', mimeType = 'application/octet-stream')]private static var room7:Class;
		[Embed(source = '../../assets/Rooms/room8.oel', mimeType = 'application/octet-stream')]private static var room8:Class;
		[Embed(source = '../../assets/Rooms/room9.oel', mimeType = 'application/octet-stream')]private static var room9:Class;
		[Embed(source = '../../assets/Rooms/room10.oel', mimeType = 'application/octet-stream')]private static var room10:Class;
		[Embed(source = '../../assets/Rooms/room11.oel', mimeType = 'application/octet-stream')]private static var room11:Class;
		[Embed(source = '../../assets/Rooms/room12.oel', mimeType = 'application/octet-stream')]private static var room12:Class;
		[Embed(source = '../../assets/Rooms/room13.oel', mimeType = 'application/octet-stream')]private static var room13:Class;
		[Embed(source = '../../assets/Rooms/room14.oel', mimeType = 'application/octet-stream')]private static var room14:Class;
		[Embed(source = '../../assets/Rooms/room15.oel', mimeType = 'application/octet-stream')]private static var room15:Class;
		[Embed(source = '../../assets/Rooms/room16.oel', mimeType = 'application/octet-stream')]private static var room16:Class;
		[Embed(source = '../../assets/Rooms/room17.oel', mimeType = 'application/octet-stream')]private static var room17:Class;
		[Embed(source = '../../assets/Rooms/room18.oel', mimeType = 'application/octet-stream')]private static var room18:Class;
		[Embed(source = '../../assets/Rooms/room19.oel', mimeType = 'application/octet-stream')]private static var room19:Class;
		[Embed(source = '../../assets/Rooms/room20.oel', mimeType = 'application/octet-stream')]private static var room20:Class;
		[Embed(source = '../../assets/Rooms/room21.oel', mimeType = 'application/octet-stream')]private static var room21:Class;
		[Embed(source = '../../assets/Rooms/room22.oel', mimeType = 'application/octet-stream')]private static var room22:Class;
		[Embed(source = '../../assets/Rooms/room23.oel', mimeType = 'application/octet-stream')]private static var room23:Class;
		[Embed(source = '../../assets/Rooms/room24.oel', mimeType = 'application/octet-stream')]private static var room24:Class;
		[Embed(source = '../../assets/Rooms/room25.oel', mimeType = 'application/octet-stream')]private static var room25:Class;
		[Embed(source = '../../assets/Rooms/room26.oel', mimeType = 'application/octet-stream')]private static var room26:Class;
		[Embed(source = '../../assets/Rooms/room27.oel', mimeType = 'application/octet-stream')]private static var room27:Class;
		[Embed(source = '../../assets/Rooms/room28.oel', mimeType = 'application/octet-stream')]private static var room28:Class;
		[Embed(source = '../../assets/Rooms/room29.oel', mimeType = 'application/octet-stream')]private static var room29:Class;
		[Embed(source = '../../assets/Rooms/room30.oel', mimeType = 'application/octet-stream')]private static var room30:Class;
		[Embed(source = '../../assets/Rooms/room31.oel', mimeType = 'application/octet-stream')]private static var room31:Class;
		[Embed(source = '../../assets/Rooms/room32.oel', mimeType = 'application/octet-stream')]private static var room32:Class;
		[Embed(source = '../../assets/Rooms/room33.oel', mimeType = 'application/octet-stream')]private static var room33:Class;
		[Embed(source = '../../assets/Rooms/room34.oel', mimeType = 'application/octet-stream')]private static var room34:Class;
		[Embed(source = '../../assets/Rooms/room35.oel', mimeType = 'application/octet-stream')]private static var room35:Class;
		[Embed(source = '../../assets/Rooms/room36.oel', mimeType = 'application/octet-stream')]private static var room36:Class;
		[Embed(source = '../../assets/Rooms/room37.oel', mimeType = 'application/octet-stream')]private static var room37:Class;
		[Embed(source = '../../assets/Rooms/room38.oel', mimeType = 'application/octet-stream')]private static var room38:Class;
		[Embed(source = '../../assets/Rooms/room39.oel', mimeType = 'application/octet-stream')]private static var room39:Class;
		[Embed(source = '../../assets/Rooms/room40.oel', mimeType = 'application/octet-stream')]private static var room40:Class;
		[Embed(source = '../../assets/Rooms/room41.oel', mimeType = 'application/octet-stream')]private static var room41:Class;
		[Embed(source = '../../assets/Rooms/room42.oel', mimeType = 'application/octet-stream')]private static var room42:Class;
		[Embed(source = '../../assets/Rooms/room43.oel', mimeType = 'application/octet-stream')]private static var room43:Class;
		[Embed(source = '../../assets/Rooms/room44.oel', mimeType = 'application/octet-stream')]private static var room44:Class;
		[Embed(source = '../../assets/Rooms/room45.oel', mimeType = 'application/octet-stream')]private static var room45:Class;
		[Embed(source = '../../assets/Rooms/room46.oel', mimeType = 'application/octet-stream')]private static var room46:Class;
		[Embed(source = '../../assets/Rooms/room47.oel', mimeType = 'application/octet-stream')]private static var room47:Class;
		[Embed(source = '../../assets/Rooms/room48.oel', mimeType = 'application/octet-stream')]private static var room48:Class;
		[Embed(source = '../../assets/Rooms/room49.oel', mimeType = 'application/octet-stream')]private static var room49:Class;
		[Embed(source = '../../assets/Rooms/room50.oel', mimeType = 'application/octet-stream')]private static var room50:Class;
		[Embed(source = '../../assets/Rooms/room51.oel', mimeType = 'application/octet-stream')]private static var room51:Class;
		[Embed(source = '../../assets/Rooms/room52.oel', mimeType = 'application/octet-stream')]private static var room52:Class;
		[Embed(source = '../../assets/Rooms/room53.oel', mimeType = 'application/octet-stream')]private static var room53:Class;
		[Embed(source = '../../assets/Rooms/room54.oel', mimeType = 'application/octet-stream')]private static var room54:Class;
		
		private static var levels:Array = new Array(room0, room1, room2, room3, room4, room5, room6, room7, room8, room9, room10, room11, room12, room13, room14, room15, room16, room17, room18, room19, room20, room21, room22, room23, room24, room25, room26, room27, room28, room29, room30, room31, room32, room33, room34, room35, room36, room37, room38, room39, room40, room41, room42, room43, room44, room45, room46, room47, room48, room49, room50, room51, room52, room53, room54);
		
		public static function GetLevel(levelNumber:Number):XML
		{	
			if (levelNumber < levels.length)
			{
				return FP.getXML(levels[levelNumber]);
			}
			
			return null;
		}
	}

}