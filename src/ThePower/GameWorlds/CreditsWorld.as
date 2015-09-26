package ThePower.GameWorlds 
{
	import net.flashpunk.World;
	import ThePower.IntroObjects.CreditsEntity;
	/**
	 * ...
	 * @author Amidos
	 */
	public class CreditsWorld extends World
	{
		private var creditsEntity:CreditsEntity = new CreditsEntity();
		
		public function CreditsWorld() 
		{
			add(creditsEntity);
			creditsEntity.Appear();
		}
		
	}

}