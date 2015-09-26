package ThePower.GameWorlds 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Tilemap;
	import ThePower.GlobalGameData;
	import ThePower.LayerConstants;
	import ThePower.TileSetGraphicGetter;
	/**
	 * ...
	 * @author Amidos
	 */
	public class GameTileMap extends Entity
	{
		public var tileMap:Tilemap;
		
		public function GameTileMap(tileMapName:String, tilePosition:Number) 
		{
			x = 0;
			y = 0;
			layer = tilePosition;
			
			//assign the tileMap
			tileMap = new Tilemap(TileSetGraphicGetter.GetTileSetGraphic(tileMapName), FP.width, FP.height, GlobalGameData.gridSize, GlobalGameData.gridSize);
			
			graphic = tileMap;
		}
		
	}

}