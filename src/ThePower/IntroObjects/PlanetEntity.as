package ThePower.IntroObjects 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import ThePower.LayerConstants;
	/**
	 * ...
	 * @author Amidos
	 */
	public class PlanetEntity extends Entity
	{
		[Embed(source = '../../../assets/Graphics/Intro/planet.png')]private var planet:Class;
		
		private var planetImage:Image = new Image(planet);
		
		public function PlanetEntity() 
		{
			graphic = planetImage;
			
			layer = LayerConstants.TilesBelowLayer;
		}
		
	}

}