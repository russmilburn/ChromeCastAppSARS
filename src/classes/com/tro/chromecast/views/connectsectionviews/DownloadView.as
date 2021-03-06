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

	public class DownloadView extends View
	{
		private var swipeControl:SwipeControl;
		private var _gradient:GradientText;
		private var _tvZoomed:Sprite;
		private var _deviceDisplay : DeviceDisplayZoomed;
		private var _popUp : PopUpMagnifier;

		public function DownloadView()
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
			_gradient.touchable = false;
			//_gradient.setText("First, download the Chromecast app from the Google Play Store");


			_tvZoomed  = getTexturesSprite("TVZoomed");
			_tvZoomed.touchable = false;


			_deviceDisplay = new DeviceDisplayZoomed();
			_deviceDisplay.laptop.setBackgroundImage(getTexture(DeviceTypeVo.LAPTOP + "Zoomed"));
			_deviceDisplay.tablet.setBackgroundImage(getTexture(DeviceTypeVo.TABLET + "Zoomed"));
			_deviceDisplay.mobile.setBackgroundImage(getTexture(DeviceTypeVo.MOBILE + "Zoomed"));
			_deviceDisplay.touchable = false;

			_popUp = new PopUpMagnifier();
			//_popUpMagnifier.enablePopUpButton();
			_popUp.alpha = 0;


			addChild(_tvZoomed);
			addChild(_deviceDisplay);
			addChild(_popUp);
			addChild(_gradient);
			dispatchEvent(new ViewEvent(ViewEvent.ON_VIEW_INIT_COMPLETE));
		}


		public function get deviceDisplay():DeviceDisplayZoomed
		{
			return _deviceDisplay;
		}

		public function set deviceDisplay(value:DeviceDisplayZoomed):void
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
