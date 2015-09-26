package ThePower.GameObjects.CutScene 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import ThePower.GameObjects.PickUps.HookPickUpEntity;
	import ThePower.GameObjects.Player.PlayerStatus;
	import ThePower.GameWorlds.BadEndingWorld;
	import ThePower.GameWorlds.GoodEnding1World;
	import ThePower.GlobalGameData;
	import ThePower.LayerConstants;
	import ThePower.MusicPlayer;
	import ThePower.OverLayerUI.TextBoxEntity;
	/**
	 * ...
	 * @author Amidos
	 */
	public class TheFinalKingEntity extends Entity
	{
		[Embed(source = "../../../../assets/Graphics/sprites/enemies/TheKing/The king.png")]private var theKingClass:Class;
		
		private var conversationText:int = 0;
		private var deserveThePower:Boolean = false
		private var thePower:ThePowerEntity = new ThePowerEntity(304, 384);
		
		public function TheFinalKingEntity(x:int, y:int, layerConstant:int) 
		{
			this.x = x;
			this.y = y;
			this.layer = layerConstant;
			
			this.deserveThePower = GlobalGameData.DeserveThePower();
			
			graphic = new Image(theKingClass);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (!GlobalGameData.pauseGame && GlobalGameData.playerEntity.x < 420)
			{
				if (deserveThePower)
				{
					DoDeserveThePowerConversation();
				}
				else
				{
					DoNotDeserveThePowerConversation();
				}
			}
		}
		
		private function DoNotDeserveThePowerConversation():void
		{
			switch(conversationText)
			{
				case 0:
					GlobalGameData.disabelKeyboard = true;
					GlobalGameData.playerEntity.playerStatus = PlayerStatus.PlayerStanding;
					MusicPlayer.Play(MusicPlayer.Bad_Ending_Music);
					break;
				case 1:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("You finally made it to my throne room, stranger.");
					break;
				case 2:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("But I am also very disappointed.");
					break;
				case 3:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("I thought that I finally found someone worthy of \"The Power\".");
					break;
				case 4:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("But I see now that you are not dedicated enough.");
					break;
				case 5:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("How do you expect me to entrust  you with something as great as \"The Power\"...");
					break;
				case 6:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("...when you didn't even care enough to get all of your  \"stuff\" back?");
					break;
				case 7:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("Leave now, stranger. You disappointed me.");
					break;
				case 8:
					GlobalGameData.disabelKeyboard = false;
					FP.world = new BadEndingWorld();
					break;
			}
			
			conversationText += 1;
		}
		
		private function DoDeserveThePowerConversation():void
		{
			switch(conversationText)
			{
				case 0:
					GlobalGameData.disabelKeyboard = true;
					GlobalGameData.playerEntity.playerStatus = PlayerStatus.PlayerStanding;
					MusicPlayer.Play(MusicPlayer.Good_Ending_Music);
					break;
				case 1:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("Stranger, you finally made it to my throne room.");
					break;
				case 2:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("This is great day indeed. A happy and joyful day.");
					break;
				case 3:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("Allow me to introduce myself again.");
					break;
				case 4:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("I am \"The King\", creator and ruler of this planet.");
					break;
				case 5:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("Yes stranger, I created this planet and everything on it.");
					break;
				case 6:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("How? With \"The Power\" , that is how.");
					break;
				case 7:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("Do you understand now why I have it so heavily guarded?");
					break;
				case 8:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("\"The Power\" is not something for anyone to have.");
					break;
				case 9:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("But is also not something for anyone to keep. It must be shared.");
					break;
				case 10:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("And it should only be in the hands of someone worthy.");
					break;
				case 11:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("Today stranger, you have proven yourself worthy of \"The Power\".");
					break;
				case 12:
					FP.world.add(thePower);
					thePower.Appear();
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("Allow me to show it to you.");
					break;
				case 13:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("Behold \"The Power\"!");
					break;
				case 14:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("The power to bring the imagination to life.");
					break;
				case 15:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("This, stranger, is the greatest of all treasures.");
					break;
				case 16:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("With this, your search for a place to settle down has ended.");
					break;
				case 17:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("From now on you will no longer be known as a Treasure Hunter.");
					break;
				case 18:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("From now on you will be known as a  \"King\".");
					break;
				case 19:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("Stranger, you must now study and discover the greatness within \"The Power\".");
					break;
				case 20:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("Use it to your hearts content.");
					break;
				case 21:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("Just don't forget that  \"The Power\" is not yours to keep.");
					break;
				case 22:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("But you must only share it with someone who is worthy.");
					break;
				case 23:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("Stranger, I will now give  \"The Power\" to you.");
					break;
				case 24:
					thePower.RemoveParticles();
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("But I must keep the essence emanating from it.");
					break;
				case 25:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("This essence will allow me to keep this planet alive.");
					break;
				case 26:
					TextBoxEntity.ShowTextBoxWithDisableKeyboardOnly("Take \"The Power\" with you now, stranger, use it well.");
					thePower.EndGeneration();
					break;
				case 27:
					GlobalGameData.disabelKeyboard = false;
					FP.world = new GoodEnding1World();
					break;
			}
			
			conversationText += 1;
		}
		
	}

}