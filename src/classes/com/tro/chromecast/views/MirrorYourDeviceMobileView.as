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

	public class MirrorYourDeviceMobileView extends View
	{
		private var swipeControl:SwipeControl;
		private var _gradient:GradientText;
		private var _tvZoomed:Sprite;
		private var _deviceDisplay : DeviceDisplay;

		public function MirrorYourDeviceMobileView()
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
			
			_tvZoomed  = getTexturesSprite("MirrorDeviceBackground");
			_tvZoomed.touchable = false;
			
			_deviceDisplay = new DeviceDisplay();
			_deviceDisplay.mobile.setBackgroundImage(getTexture("Device" + DeviceTypeVo.MOBILE));

			_deviceDisplay.touchable = false;
			
			addChild(_tvZoomed);
			addChild(_deviceDisplay);
			addChild(_gradient);


			deviceDisplay.changeDevice(DeviceTypeVo.MOBILE);
			deviceDisplay.updateScreenOnCurrentDevice(getTexture("MirrorScreenImageMobile"));
			_gradient.setText("Or mirror your Android mobile device\n(currently available on devices running Android 4.4.2 or higher)");
			_gradient.displaySwipeToContinue = true;
			//_gradient.instructionsText.y -= 50; 
			
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
