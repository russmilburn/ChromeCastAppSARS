/**
 * Created by russellmilburn on 15/09/15.
 */
package com.tro.chromecast.views.connectsectionviews
{

	import com.tro.chromecast.models.vos.DeviceTypeVo;
	import com.tro.chromecast.views.*;
	import com.tro.chromecast.views.components.GradientText;
	import com.tro.chromecast.views.components.PopUpMagnifier;

	import com.tro.chromecast.views.components.SwipeControl;
	import com.tro.chromecast.views.components.devicedisplay.DeviceDisplayZoomed;

	import starling.display.Sprite;

	public class InstallChromeView extends View
	{
		private var swipeControl:SwipeControl;
		private var _gradient:GradientText;
		private var _tvZoomed:Sprite;
		private var deviceDisplay:DeviceDisplayZoomed;
		private var _popUp:PopUpMagnifier;

		public function InstallChromeView()
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

			_gradient.setGradientTexture(getTexture("gradient"));
			_gradient.y = stage.stageHeight - _gradient.height;
			_gradient.setText("Visit google.com/chrome to install the Chrome browser");
			_gradient.displaySwipeToContinue = true;
			
			_tvZoomed  = getTexturesSprite("TVZoomed");
			_tvZoomed.touchable = false;

			deviceDisplay = new DeviceDisplayZoomed();
			deviceDisplay.laptop.setBackgroundImage(getTexture(DeviceTypeVo.LAPTOP + "Zoomed"));
			deviceDisplay.touchable = false;

			_popUp = new PopUpMagnifier();
			_popUp.setBackgroundImage(getTexture("LaptopDownloadPopUp"));
			_popUp.alpha = 0;

			addChild(_tvZoomed);
			addChild(deviceDisplay);
			addChild(_popUp);
			addChild(_gradient);

			deviceDisplay.changeDevice(DeviceTypeVo.LAPTOP);
			_popUp.x = deviceDisplay.getPopUpPosition().x;
			_popUp.y = deviceDisplay.getPopUpPosition().y;

			deviceDisplay.laptop.updateScreen(getTexture("DownloadChromeLaptop"));

			dispatchEvent(new ViewEvent(ViewEvent.ON_VIEW_INIT_COMPLETE));
		}


		public function get popUp():PopUpMagnifier
		{
			return _popUp;
		}

		public function set popUp(value:PopUpMagnifier):void
		{
			_popUp = value;
		}
	}
}
