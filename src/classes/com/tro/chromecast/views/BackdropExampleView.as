/**
 * Created by russellmilburn on 28/09/15.
 */
package com.tro.chromecast.views
{

	import com.tro.chromecast.models.vos.DeviceTypeVo;
	import com.tro.chromecast.views.components.GradientText;
	import com.tro.chromecast.views.components.SwipeControl;
	import com.tro.chromecast.views.components.TVDisplay;
	import com.tro.chromecast.views.components.devicedisplay.DeviceDisplay;

	public class BackdropExampleView extends View
	{
		private var swipeControl:SwipeControl;
		private var _gradient : GradientText;
		private var _tvDisplay:TVDisplay;
		private var _deviceDisplay:DeviceDisplay;

		public function BackdropExampleView()
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
			_tvDisplay  = new TVDisplay();
			_tvDisplay.tvDisplayVo = getContentVo();
			_tvDisplay.titleText = "Backdrop for your Chromecast";
			_tvDisplay.titleField.color = 0xFFFFFF;
			_tvDisplay.layout = TVDisplay.ALIGN_TOP;
			_tvDisplay.touchable = false;
			_tvDisplay.x = (stage.stageWidth - _tvDisplay.width) / 2 ;
			_tvDisplay.y = 50;
			_tvDisplay.updateScreenImage(getTexture("Backdrop"));
			_tvDisplay.touchable = false;


			_deviceDisplay = new DeviceDisplay();
			_deviceDisplay.laptop.setBackgroundImage(getTexture("Device" + DeviceTypeVo.LAPTOP));
			_deviceDisplay.mobile.setBackgroundImage(getTexture("Device" + DeviceTypeVo.MOBILE));
			_deviceDisplay.tablet.setBackgroundImage(getTexture("Device" + DeviceTypeVo.TABLET));
			_deviceDisplay.touchable = false;
			//_deviceDisplay.changeDevice(DeviceTypeVo.MOBILE);



			_gradient = new GradientText();
			_gradient.setGradientTexture(getTexture("gradient"));
			_gradient.y = stage.stageHeight - _gradient.height;
			_gradient.setText("Turn your TV screen into a beautiful backdrop filled with\n your photos, satellite imagery, art and more.");
			_gradient.touchable = false;
			_gradient.displaySwipeToContinue = true;

			addChild(_tvDisplay);
			addChild(_deviceDisplay);
			addChild(_gradient);

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
	}
}
