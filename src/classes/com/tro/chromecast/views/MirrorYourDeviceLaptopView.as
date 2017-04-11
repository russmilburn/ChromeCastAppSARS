/**
 * Created by russellmilburn on 15/09/15.
 */
package com.tro.chromecast.views
{

	import com.tro.chromecast.models.vos.DeviceTypeVo;
	import com.tro.chromecast.views.components.GradientText;
	import com.tro.chromecast.views.components.SwipeControl;
	import com.tro.chromecast.views.components.devicedisplay.DeviceDisplay;

	import starling.display.Sprite;

	public class MirrorYourDeviceLaptopView extends View
	{
		private var swipeControl:SwipeControl;
		private var _gradient:GradientText;
		private var _tvZoomed:Sprite;
		private var _deviceDisplay : DeviceDisplay;
		
		public function MirrorYourDeviceLaptopView()
		{
			super();
		}
		
		override protected function onViewInit():void
		{
			swipeControl = new SwipeControl();
			addChild(swipeControl);
			
			swipeControl.width = this.stage.stageWidth;
			swipeControl.height = this.stage.stageHeight;
			
			super.onViewInit();
		}
		
		override protected function initStageAssets():void
		{
			_gradient = new GradientText();
			_gradient.setGradientTexture(getTexture("gradient_short"));
			_gradient.y = stage.stageHeight - _gradient.height;
			_gradient.touchable = false;
			_gradient.setText("You can cast any tab from your Chrome browser.");
			_gradient.displaySwipeToContinue = true;
			//_gradient.setText("First, download the Chromecast app from the Google Play Store");
			
			_tvZoomed  = getTexturesSprite("MirrorDeviceBackground");
			_tvZoomed.touchable = false;
			
			_deviceDisplay = new DeviceDisplay();
			_deviceDisplay.laptop.setBackgroundImage(getTexture("Device" + DeviceTypeVo.LAPTOP));


			_deviceDisplay.touchable = false;
			
			addChild(_tvZoomed);
			addChild(_deviceDisplay);
			addChild(_gradient);
			
		
			_deviceDisplay.changeDevice(DeviceTypeVo.LAPTOP);
			_deviceDisplay.updateScreenOnCurrentDevice(getTexture("MirrorScreenImageLaptop"));
			
			dispatchEvent(new ViewEvent(ViewEvent.ON_VIEW_INIT_COMPLETE));
		}
	
		
		public function get deviceDisplay():DeviceDisplay
		{
			return _deviceDisplay;
		}

		public function set deviceDisplay(value:DeviceDisplay):void
		{
			_deviceDisplay = value;
		}

		public function get gradient():GradientText
		{
			return _gradient;
		}

		public function set gradient(value:GradientText):void
		{
			_gradient = value;
		}
		
	}
}
