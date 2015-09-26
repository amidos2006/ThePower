package ThePower.IntroObjects 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Image;
	import ThePower.LayerConstants;
	/**
	 * ...
	 * @author Amidos
	 */
	public class BlackOverLayerEntity extends Entity
	{
		[Embed(source = '../../../assets/Graphics/Intro/BlackLayer.PNG')]private var blackLayer:Class;
		
		private var blackImage:Backdrop = new Backdrop(blackLayer);
		private var alphaIncrement:Number = 0.02;
		
		public var alphaImage:Number = 0;
		
		public function BlackOverLayerEntity() 
		{
			blackImage.alpha = 0;
			graphic = blackImage;
			
			layer = LayerConstants.OverLayer;
		}
		
		override public function update():void 
		{
			super.update();
			
			blackImage.alpha += alphaIncrement;
			alphaImage = blackImage.alpha;
		}
		
		override public function render():void 
		{
			super.render();
		}
	}

}