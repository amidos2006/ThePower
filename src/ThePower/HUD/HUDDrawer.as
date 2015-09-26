package ThePower.HUD 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import ThePower.GlobalGameData;
	import ThePower.LayerConstants;
	/**
	 * ...
	 * @author Amidos
	 */
	public class HUDDrawer extends Entity
	{
		[Embed(source = '../../../assets/Graphics/impact.ttf',embedAsCFF="false", fontFamily = 'GameFont')]private var gameFont:Class;
		[Embed(source = '../../../assets/Graphics/sprites/inventory/secondary_weapon_box.png')]private var secWeaponWindowGraphics:Class;
		[Embed(source = '../../../assets/Graphics/sprites/inventory/no_secondary_weapon.png')]private var noSecWeaponGraphics:Class;
		[Embed(source = '../../../assets/Graphics/sprites/inventory/life-missile_count.png')]private var lifeMissleCountGraphics:Class;
		[Embed(source = '../../../assets/Graphics/sprites/weapons/mine_strip2.png')]private var mineImage:Class;
		[Embed(source = '../../../assets/Graphics/sprites/weapons/missile_right.png')]private var missleImage:Class;
		[Embed(source = '../../../assets/Graphics/sprites/weapons/super_missile_right_strip10.png')]private var superMissleImage:Class;
		[Embed(source = '../../../assets/Graphics/sprites/weapons/hook.png')]private var hookGraphics:Class;
		
		private const shiftAmount:Number = 0;
		
		private var healthBar:Image = new Image(lifeMissleCountGraphics);
		private var missleBar:Image = new Image(lifeMissleCountGraphics);;
		private var secondaryWeaponWindow:Image = new Image(secWeaponWindowGraphics);
		private var noSecondaryWeaponImage:Image = new Image(noSecWeaponGraphics);
		private var normalMissle:Image = new Image(missleImage);
		private var superMissle:Image = new Image(superMissleImage, new Rectangle(0, 0, 16, 12));
		private var secondaryWeaponImages:Array = new Array(new Image(mineImage,new Rectangle(0,0,12,12)), normalMissle, new Image(hookGraphics));
		private var playerHealth:Text = new Text(GlobalGameData.playerEntity.playerHealth.toString() + " / " + GlobalGameData.maxHealthAmount.toString());
		private var playerMissles:Text = new Text("- / -");
		
		public function HUDDrawer() 
		{
			Text.font = "GameFont";
			Text.size = 11;
			
			playerHealth.font = "GameFont";
			playerMissles.font = "GameFont";
			playerHealth.size = 11;
			playerMissles.size = 11;
			playerHealth.color = 0xFF80FF;
			playerMissles.color = 0xFF80FF;
			
			layer = LayerConstants.HUDLayer;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (GlobalGameData.misslePower == 1)
			{
				secondaryWeaponImages[1] = normalMissle;
			}
			else if (GlobalGameData.misslePower == 2)
			{
				secondaryWeaponImages[1] = superMissle;
			}
			
			playerHealth.text = GlobalGameData.playerEntity.playerHealth.toString() + " / " + GlobalGameData.maxHealthAmount.toString();
			
			if (GlobalGameData.misslePower > 0)
			{
				playerMissles.text = GlobalGameData.playerEntity.amountOfMisslePlayerHad.toString() + " / " + GlobalGameData.maxMissleAmount.toString();
			}
		}
		
		override public function render():void 
		{
			super.render();
			
			secondaryWeaponWindow.render(FP.buffer, new Point(shiftAmount, shiftAmount), FP.camera);
			if (GlobalGameData.currentAmountOfWeapons == 0)
			{
				noSecondaryWeaponImage.render(FP.buffer, new Point(shiftAmount, shiftAmount), FP.camera);
			}
			else
			{
				secondaryWeaponImages[GlobalGameData.currentAssignedWeapon].centerOO();
				secondaryWeaponImages[GlobalGameData.currentAssignedWeapon].render(FP.buffer, new Point(shiftAmount + secondaryWeaponWindow.width/2, shiftAmount + secondaryWeaponWindow.height/2), FP.camera);
			}
			
			healthBar.render(FP.buffer, new Point(shiftAmount + secondaryWeaponWindow.width, shiftAmount), FP.camera);
			playerHealth.render(FP.buffer, new Point(shiftAmount + secondaryWeaponWindow.width + 1, shiftAmount), FP.camera);
			
			if (GlobalGameData.misslePower > 0)
			{
				missleBar.render(FP.buffer, new Point(shiftAmount + secondaryWeaponWindow.width, shiftAmount + healthBar.height), FP.camera);
				playerMissles.render(FP.buffer, new Point(shiftAmount + secondaryWeaponWindow.width + 1, shiftAmount + healthBar.height), FP.camera);
			}
		}
	}

}