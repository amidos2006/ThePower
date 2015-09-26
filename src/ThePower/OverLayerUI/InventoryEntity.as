package ThePower.OverLayerUI 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import ThePower.GlobalGameData;
	import ThePower.LayerConstants;
	/**
	 * ...
	 * @author Amidos
	 */
	public class InventoryEntity extends Entity
	{
		[Embed(source = "../../../assets/Graphics/impact.ttf", embedAsCFF="false", fontFamily = 'GameFont')]private var gameFont:Class;
		
		[Embed(source = "../../../assets/Graphics/sprites/inventory/inventory_window.png")]private var inventoryClass:Class;
		[Embed(source = "../../../assets/Graphics/sprites/weapons/normal_shot_strip3.png")]private var beamClass:Class;
		[Embed(source = "../../../assets/Graphics/sprites/weapons/upgraded_shot_strip3.png")]private var upgradeBeamClass:Class;
		[Embed(source = "../../../assets/Graphics/sprites/weapons/mine_strip2.png")]private var mineClass:Class;
		[Embed(source = "../../../assets/Graphics/sprites/weapons/missile_right.png")]private var missleClass:Class;
		[Embed(source = "../../../assets/Graphics/sprites/weapons/hook.png")]private var hookClass:Class;
		[Embed(source = "../../../assets/Graphics/sprites/weapons/super_missile_right_strip10.png")]private var superMissleClass:Class;
		[Embed(source = "../../../assets/Graphics/sprites/pick ups/suit1_pickup_strip10.png")]private var suit1Class:Class;
		[Embed(source = "../../../assets/Graphics/sprites/pick ups/suit2_pickup_strip10.png")]private var suit2Class:Class;
		[Embed(source = "../../../assets/Graphics/sprites/pick ups/life_pickup_strip10.png")]private var healthClass:Class;
		[Embed(source = "../../../assets/Graphics/sprites/pick ups/extra_missiles_pickup_strip10.png")]private var extraMissleClass:Class;
		
		private var image:Image = new Image(inventoryClass);
		private var beamImage:Image = new Image(beamClass, new Rectangle(0, 0, 6, 4));
		private var upgradeBeamImage:Image = new Image(upgradeBeamClass, new Rectangle(0, 0, 8, 6));
		private var mineImage:Image = new Image(mineClass, new Rectangle(12, 0, 12, 12));
		private var missleImage:Image = new Image(missleClass);
		private var hookImage:Image = new Image(hookClass);
		private var superMissleImage:Image = new Image(superMissleClass, new Rectangle(0, 0, 16, 12));
		private var suit1Image:Image = new Image(suit1Class, new Rectangle(0, 0, 32, 32));
		private var suit2Image:Image = new Image(suit2Class, new Rectangle(0, 0, 32, 32));
		private var healthImage:Image = new Image(healthClass, new Rectangle(0, 0, 32, 32));
		private var extraMissleImage:Image = new Image(extraMissleClass, new Rectangle(0, 0, 32, 32));
		
		private var beamText:Text;
		private var upgradeBeamText:Text;
		private var mineText:Text;
		private var missleText:Text;
		private var hookText:Text;
		private var superMissleText:Text;
		private var suit1Text:Text;
		private var suit2Text:Text;
		private var healthText:Text;
		private var extraMissleText:Text;
		private var hintText:Text;
		
		public function InventoryEntity() 
		{
			GlobalGameData.pauseGame = true;
			GlobalGameData.playerEntity.StopPlayerMoving();
			
			x = FP.screen.width / 2 - image.width / 2;
			y = FP.screen.height / 2 - image.height / 2;
			
			Text.size = 12;
			Text.font = "GameFont";
			
			beamImage.centerOO();
			mineImage.centerOO();
			missleImage.centerOO();
			hookImage.centerOO();
			upgradeBeamImage.centerOO();
			suit1Image.centerOO();
			suit2Image.centerOO();
			superMissleImage.centerOO();
			healthImage.centerOO();
			extraMissleImage.centerOO();
			
			suit1Image.scale = 0.5;
			suit2Image.scale = 0.5;
			superMissleImage.scale = 0.9;
			
			beamText = new Text("Beam - Is better than nothing - X");
			mineText = new Text("Mines - Destroy cracked stones - Z");
			missleText = new Text("Missiles - A powerful weapon - Z");
			hookText = new Text("Hook - To reach high places - Z");
			upgradeBeamText = new Text("Beam Upgrade - Adds power and speed");
			suit1Text = new Text("Suit Upgrade 1 - Resist extreme conditions");
			suit2Text = new Text("Suit Upgrade 2 - Move normally under water");
			superMissleText = new Text("Missiles Upgrade - A devastating weapon");
			healthText = new Text(GlobalGameData.numberOfHealthPicks + " / 20");
			extraMissleText = new Text(GlobalGameData.numberOfMisslePicks + " / 24");
			hintText = new Text("Press Space to close");
			
			beamText.color = 0xFF80FF;
			mineText.color = 0xFF80FF;
			missleText.color = 0xFF80FF;
			hookText.color = 0xFF80FF;
			upgradeBeamText.color = 0xFF80FF;
			suit1Text.color = 0xFF80FF;
			suit2Text.color = 0xFF80FF;
			superMissleText.color = 0xFF80FF;
			healthText.color = 0xFF80FF;
			extraMissleText.color = 0xFF80FF;
			hintText.color = 0xFF80FF;
			
			hintText.centerOO();
			
			graphic = image;
			layer = LayerConstants.HUDLayer;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.pressed(Key.SPACE))
			{
				GlobalGameData.pauseGame = false;
				FP.world.remove(this);
				Input.clear();
				GlobalGameData.PauseGameWorld();
			}
		}
		
		override public function render():void 
		{
			super.render();
			
			beamImage.render(FP.buffer, new Point(x + 12, y + 15), FP.camera);
			beamText.render(FP.buffer, new Point(x + 20, y + 5), FP.camera);
			
			if (GlobalGameData.currentAmountOfWeapons >= 1)
			{
				mineImage.render(FP.buffer, new Point(x + 12, y + 33), FP.camera);
				mineText.render(FP.buffer, new Point(x + 20, y + 25), FP.camera);
			}
			
			if (GlobalGameData.currentAmountOfWeapons >= 2)
			{
				missleImage.render(FP.buffer, new Point(x + 12, y + 55), FP.camera);
				missleText.render(FP.buffer, new Point(x + 20, y + 45), FP.camera);
			}
			
			if (GlobalGameData.currentAmountOfWeapons >= 3)
			{
				hookImage.render(FP.buffer, new Point(x + 12, y + 75), FP.camera);
				hookText.render(FP.buffer, new Point(x + 20, y + 65), FP.camera);
			}
			
			if (GlobalGameData.shotPower >= 2)
			{
				upgradeBeamImage.render(FP.buffer, new Point(x + 12, y + 95), FP.camera);
				upgradeBeamText.render(FP.buffer, new Point(x + 20, y + 85), FP.camera);
			}
			
			if (GlobalGameData.suitPower >= 1)
			{
				suit1Image.render(FP.buffer, new Point(x + 12, y + 115), FP.camera);
				suit1Text.render(FP.buffer, new Point(x + 20, y + 105), FP.camera);
			}
			
			if (GlobalGameData.suitPower >= 2)
			{
				suit2Image.render(FP.buffer, new Point(x + 12, y + 135), FP.camera);
				suit2Text.render(FP.buffer, new Point(x + 20, y + 125), FP.camera);
			}
			
			if (GlobalGameData.misslePower >= 2)
			{
				superMissleImage.render(FP.buffer, new Point(x + 12, y + 155), FP.camera);
				superMissleText.render(FP.buffer, new Point(x + 20, y + 145), FP.camera);
			}
			
			if (GlobalGameData.numberOfHealthPicks > 0)
			{
				healthImage.render(FP.buffer, new Point(x + 60, y + 180), FP.camera);
				healthText.render(FP.buffer, new Point(x + 75, y + 170), FP.camera);
			}
			
			if (GlobalGameData.numberOfMisslePicks > 0)
			{
				extraMissleImage.render(FP.buffer, new Point(x + 155, y + 180), FP.camera);
				extraMissleText.render(FP.buffer, new Point(x + 170, y + 170), FP.camera);
			}
			
			hintText.render(FP.buffer, new Point(x + image.width / 2, y + 210), FP.camera);
		}
		
	}

}