package ThePower.GameObjects.CutScene 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import ThePower.GameObjects.PickUps.HookPickUpEntity;
	import ThePower.GameObjects.Player.PlayerStatus;
	import ThePower.GlobalGameData;
	import ThePower.LayerConstants;
	import ThePower.OverLayerUI.TextBoxEntity;
	/**
	 * ...
	 * @author Amidos
	 */
	public class TheKingEntity extends Entity
	{
		[Embed(source = "../../../../assets/Graphics/sprites/enemies/TheKing/The king.png")]private var theKingClass:Class;
		[Embed(source = "../../../../assets/Graphics/sprites/enemies/TheKing/empty throne.png")]private var theKingEmptyClass:Class;
		
		private var isEmpty:Boolean = false;
		private var conversationText:int = 0;
		
		public function TheKingEntity(x:int, y:int, layerConstant:int) 
		{
			this.x = x;
			this.y = y;
			this.layer = layerConstant;
			
			this.isEmpty = GlobalGameData.currentAmountOfWeapons >= 3;
			
			if (this.isEmpty)
			{
				graphic = new Image(theKingEmptyClass);
			}
			else
			{
				graphic = new Image(theKingClass);
			}
		}
		
		override public function update():void 
		{
			super.update();
			
			if (!GlobalGameData.pauseGame && !isEmpty && GlobalGameData.playerEntity.x < 420)
			{
				DoConversation();
			}
		}
		
		private function DoConversation():void
		{
			switch(conversationText)
			{
				case 0:
					GlobalGameData.disabelKeyboard = true;
					GlobalGameData.playerEntity.playerStatus = PlayerStatus.PlayerStanding;
					break;
				case 1:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("So I finally get to meet you, stranger. I must say that I am impressed on how far you have come.");
					break;
				case 2:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("Me? I am \"The King\", ruler of this planet.");
					break;
				case 3:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("There is something I must ask: why are you here?");
					break;
				case 4:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("To get your \"stuff\" back, you say? That is a lie, stranger. You already had your \"stuff\" before you came here.");
					break;
				case 5:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("It is \"The Power\", isn't it? You have wanted it ever since you heard about it.");
					break;
				case 6:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("You want to know about \"The Power\"?");
					break;
				case 7:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("Well, I found \"The Power\" many years ago, on a very distant planet.");
					break;
				case 8:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("At first I didn't understand it, but I continued to study it and experiment with it until I \"discovered\" it.");
					break;
				case 9:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("I know now that \"The Power\" can be great in the right hands. But what if it fell into the wrong ones? # That's why I have it so heavily guarded.");
					break;
				case 10:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("Where is it? Why would I tell you that? You are not worthy of it.");
					break;
				case 11:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("Well, stranger, I really can't stay here and talk any more. I have a planet to attend.");
					break;
				case 12:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("You can stay if you like. Try to get all your \"stuff\" back. # I think I found some of it myself. Here, this is certainly not mine.");
					break;
				case 13:
					FP.world.add(new HookPickUpEntity(400, 320, LayerConstants.ObjectLayer));
					break;
				case 14:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("I have to go back to my throne room now. # This room? This is where I started my biggest experiment with \"The Power\". # I like to come here from time to time.");
					break;
				case 15:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("You too must go now, stranger.");
					break;
				case 16:
					isEmpty = true;
					GlobalGameData.disabelKeyboard = false;
					break;
			}
			
			conversationText += 1;
		}
		
	}

}