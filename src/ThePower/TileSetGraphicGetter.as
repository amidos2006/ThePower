package ThePower 
{
	/**
	 * ...
	 * @author Amidos
	 */
	public class TileSetGraphicGetter
	{
		[Embed(source = '../../assets/Graphics/tile_sets/castle.png')] private static var castle:Class;
		[Embed(source = '../../assets/Graphics/tile_sets/cave.png')] private static var cave:Class;
		[Embed(source = '../../assets/Graphics/tile_sets/forest.png')] private static var forest:Class;
		[Embed(source = '../../assets/Graphics/tile_sets/snow.png')] private static var snow:Class;
		[Embed(source = '../../assets/Graphics/tile_sets/water.png')] private static var water:Class;
		
		/**
		 * Get the graphics tileset that correspond to the name
		 * @param	name: this is the name of the tileset identified in the level file
		 * @return the class of graphics correspond to the name of tileset passed
		 */
		public static function GetTileSetGraphic(name:String):Class
		{
			switch(name)
			{
				case "cave":
					return cave;
				case "castle":
					return castle;
				case "forest":
					return forest;
				case "snow":
					return snow;
				case "water":
					return water;
			}
			
			return null;
		}
		
	}

}