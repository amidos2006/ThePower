package  
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.navigateToURL;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.system.Security;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	/**
	 * ...
	 * @author Amidos
	 */
	
	[SWF(width = "640", height = "480", backgroundColor="#000000")]
	public class Preloader extends MovieClip
	{
		[Embed(source = '../assets/Graphics/impact.ttf', embedAsCFF = "false", fontFamily = 'GameFont')]static private var gameFont:Class;
		//[Embed(source = '../Graphics/Sponsor.png')]static private var sponsorImg:Class;
		[Embed(source = '../assets/Graphics/LoadingScreen.png')]static private var loadingBackImg:Class;
		
		private var text:TextField = new TextField();
		private var loadingText:TextField = new TextField();
		//private var sponsorLogo:Bitmap = new sponsorImg;
		private var background:Bitmap = new loadingBackImg;
		private var loadingTextFormat:TextFormat = new TextFormat();
		private var textFormat:TextFormat = new TextFormat();
		private var font:Font = new gameFont() as Font;
		private var loadedBytes:Number = 0;
		private var totalBytes:Number = 4235;
		private var notLoaded:Boolean = true;
		private var gamepirateButton:gpirate33_piratebutton = new gpirate33_piratebutton();
		
		public function Preloader() 
		{	
			addChild(background);
			
			addChild(loadingText);
			
			gamepirateButton.x = 235;
			gamepirateButton.y = 430;
			gamepirateButton.addEventListener(MouseEvent.CLICK, GoToSponsorWebsite);
			addChild(gamepirateButton);
			
			loadingText.text = "Loading";
			loadingText.x = stage.stageWidth / 2;
			loadingText.y = stage.stageHeight;
			loadingText.x -= 55 ;
			loadingText.y -= 100;
			
			//addChild(text);
			text.x = 640 / 2;
			text.y = loadingText.y + 50;
			
			loadingTextFormat.font = font.fontName;
			loadingTextFormat.size = 24;
			loadingTextFormat.color = 0xFFFFFF;
			
			textFormat.font = font.fontName;
			textFormat.size = 16;
			textFormat.color = 0xFFFFFF;
			
			//addChild(sponsorLogo);
			//sponsorLogo.x = stage.stageWidth/2 - sponsorLogo.width/2;
			//sponsorLogo.y = stage.stageHeight - sponsorLogo.height - 10;
			
			text.autoSize = TextFieldAutoSize.CENTER;
			text.defaultTextFormat = textFormat;
			text.embedFonts = true;
			text.textColor = 0xFFFFFF;
			text.x = stage.stageWidth / 2 - 5;
			text.selectable = false;
			
			loadingText.autoSize = TextFieldAutoSize.CENTER;
			loadingText.defaultTextFormat = loadingTextFormat;
			loadingText.embedFonts = true;
			loadingText.textColor = 0xFFFFFF;
			loadingText.selectable = false;
			
			notLoaded = true;
			
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			
			IntializeTracking();
		}
		
		private function GoToSponsorWebsite(event:MouseEvent):void
		{
			var myURL:URLRequest = new URLRequest("http://www.gamepirate.com/");
			navigateToURL(myURL, "_blank");
		}
		
		private function IntializeTracking():void
		{
			if(loaderInfo.url.substring(0,4) != "file")
			{
				Security.allowDomain("*");
				Security.loadPolicyFile("http://track.g-bot.net/crossdomain.xml");

				var variables:URLVariables = new URLVariables();
				variables.id = "thepower"; // you game ID 
				variables.ui = loaderInfo.url;
				
				var request:URLRequest = new URLRequest("http://track.g-bot.net/track.php");
				request.method = "POST";
				request.data = variables;
				
				var loader:URLLoader = new URLLoader();
				loader.load(request);
			}
		}
		
		private function progress(e:ProgressEvent):void 
		{
			if (e.bytesTotal != 0)
			{
				totalBytes = Math.ceil(e.bytesTotal / 1024);
			}
			
			loadingText.textColor = 0xFFFFFF;
			text.textColor = 0xFFFFFF;
			loadedBytes = Math.ceil(e.bytesLoaded / 1024);
			loadingText.text = ((loadedBytes / totalBytes) * 100).toFixed(0) + "% Loaded";
			text.text = loadedBytes + " kb / " + totalBytes + " kb";
		}
		
		private function checkFrame(e:Event):void 
		{
			loadingText.textColor = 0xFFFFFF;
			text.textColor = 0xFFFFFF;
			
			if(loadedBytes < totalBytes)
			{
				loadingText.text = ((loadedBytes / totalBytes) * 100).toFixed(0) + "% Loaded";
				text.text = loadedBytes + " kb / " + totalBytes + " kb";
			}
			
			if (currentFrame == totalFrames) 
			{
				notLoaded = false;
				stage.addEventListener(KeyboardEvent.KEY_DOWN, PlayClicked);
				loadingText.text = "Press any key to continue";
				text.text = totalBytes + " kb / " + totalBytes + " kb";
			}
		}
		
		private function PlayClicked(eventObject: KeyboardEvent):void
		{
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, PlayClicked);
			
			//removeChild(text);
			removeChild(loadingText);
			removeChild(gamepirateButton);
			//removeChild(sponsorLogo);
			removeChild(background);
			
			startup();
		}
		
		private function startup():void 
		{
			//if (SiteLock())
			{
				var c:Class = getDefinitionByName("Splash") as Class;
				addChild(new c as DisplayObject);
			}
		}
		
		private function SiteLock():Boolean
		{
			var url:String=stage.loaderInfo.url;
			var urlStart:Number = url.indexOf("://")+3;
			var urlEnd:Number = url.indexOf("/", urlStart);
			var domain:String = url.substring(urlStart, urlEnd);
			var LastDot:Number = domain.lastIndexOf(".")-1;
			var domEnd:Number = domain.lastIndexOf(".", LastDot)+1;
			domain = domain.substring(domEnd, domain.length);
			if (domain != "flashgamelicense.com") 
			{
				return false;
			}
			
			return true;
		}
		
	}

}