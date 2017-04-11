/**
 * Created by russellmilburn on 15/09/15.
 */
package com.tro.chromecast.views.mediators
{

	import com.greensock.TweenMax;
	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.models.ApplicationModelEvent;
	import com.tro.chromecast.models.vos.DeviceTypeVo;
	import com.tro.chromecast.views.ViewEvent;
	import com.tro.chromecast.views.components.PopUpMagnifier;
	import com.tro.chromecast.views.components.PopUpMagnifierEvent;
	import com.tro.chromecast.views.components.SwipeControlEvent;
	import com.tro.chromecast.views.connectsectionviews.DownloadView;

	public class DownloadViewMediator extends BaseMediator
	{
		[Inject]
		public var view : DownloadView;

		private var osType : String;
		private var selectedDevice : String;


		public function DownloadViewMediator()
		{
			super();
		}


		override public function initialize():void
		{
			super.initialize();

			view.logger = super.logger;
			view.assetManager = assetStore.assetManager;

			view.addEventListener(SwipeControlEvent.SWIPE_LEFT, onSwipeLeft);
			view.addEventListener(SwipeControlEvent.SWIPE_RIGHT, onSwipeRight);

			view.addEventListener(ViewEvent.ON_VIEW_INIT_COMPLETE, onInitComplete);
			view.addEventListener(ViewEvent.ON_VIEW_IN_COMPLETE, onViewInComplete);
			view.addEventListener(ViewEvent.ON_VIEW_OUT_COMPLETE, onViewOutComplete);

			addContextListener(AppEvent.SET_DEVICE_OS, onSetDeviceOsHandler);
			addContextListener(ApplicationModelEvent.ON_UPDATE_DEVICE, onUpdateDevice);

			osType = DeviceTypeVo.ANDROID;

		}



		private function onInitComplete(event:ViewEvent):void
		{
			view.popUp.enablePopUpButton();
			view.popUp.addEventListener(PopUpMagnifierEvent.ON_BUTTON_TAP, onButtonTap);

			view.deviceDisplay.tablet.updateScreen(view.getTexture("Tablet" + osType + "Setup"));
			view.deviceDisplay.mobile.updateScreen(view.getTexture("Mobile" + osType + "Setup"));
			view.popUp.setBackgroundImage(view.getTexture(osType + "DownloadPopUp"));
		}

		private function onViewOutComplete(event:ViewEvent):void
		{
			view.popUp.alpha = 0;
		}

		private function onViewInComplete(event:ViewEvent):void
		{
			TweenMax.to(view.popUp, 1, {autoAlpha: 1})
		}

		private function onButtonTap(event:PopUpMagnifierEvent):void
		{
			event.stopPropagation();
			nextView();
		}

		private function onUpdateDevice(event : ApplicationModelEvent):void
		{
			selectedDevice = event.device;
			view.deviceDisplay.changeDevice(selectedDevice);

			view.popUp.x = view.deviceDisplay.getPopUpPosition().x;
			view.popUp.y = view.deviceDisplay.getPopUpPosition().y;
		}

		private function onSetDeviceOsHandler(event : AppEvent):void
		{
			//logger.info("onSetDeviceOsHandler: " + event.osType);
			osType = event.osType;

			if (event.osType == DeviceTypeVo.IOS)
			{
				view.gradient.setText("First, download the Chromecast app from the App Store");
				view.gradient.displaySwipeToContinue = true;
				mobileOrientation();
			}
			else
			{
				view.gradient.setText("First, download the Chromecast app from the Google Play Store");
				view.gradient.displaySwipeToContinue = true;
				mobileOrientation();
			}


			//logger.debug(selectedDevice + osType + "Download");
			view.deviceDisplay.currentDevice.updateScreen(view.getTexture(selectedDevice + osType + "Setup"));
			view.popUp.setBackgroundImage(view.getTexture(osType + "DownloadPopUp"));
			//IOSDownloadPopUp.png

		}

		private function mobileOrientation() : void
		{
			if (selectedDevice == DeviceTypeVo.MOBILE && osType == DeviceTypeVo.IOS)
			{
				view.deviceDisplay.currentDevice.rotation = -1.5708;
				view.deviceDisplay.y = 1400;
				view.deviceDisplay.x = ((view.stage.stageWidth - view.deviceDisplay.currentDevice.height)/ 2) + 150;
			}
			else
			{
				view.deviceDisplay.currentDevice.rotation = 0;
				view.deviceDisplay.x = 0;
				view.deviceDisplay.y = 0;
			}
		}

		
	}
}
