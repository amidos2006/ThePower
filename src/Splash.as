package  
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import mx.core.ByteArrayAsset;
	import ThePower.GlobalGameData;
	/**
	 * ...
	 * @author Amidos
	 */
	public class Splash extends MovieClip
	{
		[Embed(source = "../SponsorPack/Splash.swf", mimeType = "application/octet-stream")]private var gamePirateSplash:Class;
		
		private var splashLogo:MovieClip;
		private var loader:Loader = new Loader;
		private var byteArrayAsset:ByteArrayAsset;
		private var alphaSpeed:Number = 0.02;
		private var count:Number = 0;
		
		public function Splash() 
		{
			byteArrayAsset = new gamePirateSplash;
			loader.contentLoaderInfo.addEventListener(Event.INIT, loaderCompleteListener, false, 0, true);
			loader.loadBytes(byteArrayAsset);
		}
		
		private function loaderCompleteListener(event:Event):void
		{
			splashLogo = MovieClip(loader.content);
			splashLogo.x = 310;
			splashLogo.y = 225;
			addChild(splashLogo);
			
			addEventListener(Event.ENTER_FRAME, Update, false, 0, true);
			addEventListener(MouseEvent.CLICK, GoToSponsorLink, false, 0, true);
		}
		
		private function GoToSponsorLink(event:MouseEvent):void
		{
			var myURL:URLRequest = new URLRequest(GlobalGameData.sponosrLink);
			navigateToURL(myURL, "_blank");
		}
		
		private function Update(event:Event):void
		{
			if (splashLogo.currentFrame >= splashLogo.totalFrames)
			{
				count += 1;
				
				if (count > 30*4)
				{
					removeEventListener(Event.ENTER_FRAME, Update);
					removeEventListener(MouseEvent.CLICK, GoToSponsorLink);
					removeChild(splashLogo);
				
					addChild(new Main());
				}
			}
		}
		
	}

}