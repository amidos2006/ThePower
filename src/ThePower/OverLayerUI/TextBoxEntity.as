package ThePower.OverLayerUI 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import ThePower.GameObjects.CutScene.TheFinalKingEntity;
	import ThePower.GameObjects.CutScene.TheKingEntity;
	import ThePower.GameObjects.Player.PlayerStatus;
	import ThePower.GlobalGameData;
	import ThePower.LayerConstants;
	/**
	 * ...
	 * @author Amidos
	 */
	public class TextBoxEntity extends Entity
	{
		[Embed(source = '../../../assets/Graphics/sprites/inventory/text_box.png')]private var textBoxGraphics:Class;
		[Embed(source = '../../../assets/Graphics/impact.ttf',embedAsCFF="false", fontFamily = 'GameFont')]private var gameFont:Class;
		
		private const pressAnyKeyToContinue:String = "pressAnyKeyToContinue";
		private const pressAnyKeyWord:String = "Press space to continue";
		private const characterHeight:Number = 12;
		private const characterWidth:Number = 40;
		private const newLineCharacter:String = "#";
		
		private var textVector:Vector.<Text> = new Vector.<Text>();
		private var imageDisplay:Image = new Image(textBoxGraphics);
		private var timeAlarm:Alarm = null;
		
		public static function ShowTextBox(inputText:String, timer:Number = 0):void
		{
			FP.world.add(new TextBoxEntity(inputText, timer));
			GlobalGameData.pauseGame = true;
		}
		
		public static function ShowTextBoxWithDisableKeyboardOnly(inputText:String, timer:Number = 0):void
		{
			FP.world.add(new TextBoxEntity(inputText, timer));
			GlobalGameData.disabelKeyboard = true;
		}
		
		public function TextBoxEntity(inputText:String, timer:Number) 
		{
			x = FP.width / 2;
			y = FP.height / 2;
			
			if (FP.world.classCount(TheKingEntity) > 0 || FP.world.classCount(TheFinalKingEntity) < 0)
			{
				y -= 50;
			}
			
			layer = LayerConstants.HUDLayer;
			imageDisplay.centerOO();
			graphic = imageDisplay;
			
			DivideInput(inputText);
			
			if (timer > 0)
			{
				timeAlarm = new Alarm(timer, Finished, Tween.ONESHOT);
				addTween(timeAlarm, true);
				textVector.pop();
			}
			
			Input.define(pressAnyKeyToContinue, Key.SPACE);
		}
		
		private function Finished():void
		{
			GlobalGameData.pauseGame = false;
			FP.world.remove(this);
		}
		
		private function DivideInput(text:String):void
		{
			Text.size = characterHeight;
			Text.font = "GameFont";
			
			var tempLines:Array = text.split(newLineCharacter);
			var tempWords:Array;
			var tempNewLine:String = "";
			
			for (var i:Number = 0; i < tempLines.length; i += 1)
			{
				if ((tempLines[i] as String).length < characterWidth)
				{
					textVector.push(new Text(tempLines[i]));
					textVector[textVector.length - 1].size = characterHeight;
					textVector[textVector.length - 1].color = 0xFF80FF;
					textVector[textVector.length - 1].font = "GameFont";
					textVector[textVector.length - 1].centerOO();
				}
				else
				{
					tempWords = (tempLines[i] as String).split(" ");
					
					for (var j:Number = 0; j < tempWords.length; j += 1)
					{
						if (tempNewLine.length + (tempWords[j] as String).length >= characterWidth)
						{
							textVector.push(new Text(tempNewLine));
							textVector[textVector.length - 1].size = characterHeight;
							textVector[textVector.length - 1].color = 0xFF80FF;
							textVector[textVector.length - 1].font = "GameFont";
							textVector[textVector.length - 1].centerOO();
							tempNewLine = tempWords[j] + " ";
						}
						else
						{
							tempNewLine += tempWords[j] + " ";
						}
					}
					
					if (tempNewLine != "")
					{
						textVector.push(new Text(tempNewLine));
						textVector[textVector.length - 1].size = characterHeight;
						textVector[textVector.length - 1].color = 0xFF80FF;
						textVector[textVector.length - 1].font = "GameFont";
						textVector[textVector.length - 1].centerOO();
						tempNewLine = "";
					}
				}
			}
			
			textVector.push(new Text(pressAnyKeyWord));
			textVector[textVector.length - 1].size = characterHeight;
			textVector[textVector.length - 1].color = 0xFF80FF;
			textVector[textVector.length - 1].font = "GameFont";
			textVector[textVector.length - 1].centerOO();
		}
		
		override public function added():void 
		{
			super.added();
			GlobalGameData.playerEntity.StopPlayerMoving();
			GlobalGameData.pauseGame = true;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.pressed(pressAnyKeyToContinue) && !timeAlarm)
			{
				GlobalGameData.pauseGame = false;
				FP.world.remove(this);
				Input.clear();
			}
		}
		
		override public function render():void 
		{
			super.render();
			
			var length:Number;
			
			if (timeAlarm == null)
			{
				length = textVector.length - 1;
				textVector[textVector.length - 1].render(FP.buffer, new Point(x, y + imageDisplay.height / 2 - characterHeight / 2 - 5), FP.camera);
			}
			else
			{
				length = textVector.length;
			}
			
			for (var i:Number = 0; i < length; i += 1)
			{
				textVector[i].render(FP.buffer, new Point(x, y + (i - (textVector.length) / 2) * characterHeight), FP.camera);
			}
		}
		
	}

}