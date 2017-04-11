/**
 * Created by russellmilburn on 15/09/15.
 */
package com.tro.chromecast.views.mediators
{

	import com.greensock.TweenMax;
	import com.tro.chromecast.models.ApplicationModelEvent;
	import com.tro.chromecast.models.vos.DeviceTypeVo;
	import com.tro.chromecast.views.ViewEvent;
	import com.tro.chromecast.views.components.SwipeControlEvent;
	import com.tro.chromecast.views.connectsectionviews.ConnectToWifiView;

	public class ConnectToWifiViewMediator extends BaseMediator
	{
		[Inject]
		public var view : ConnectToWifiView;
		
		private var screeXPos : Number;
		private var screeYPos : Number;
		private var selectedDevice : String;
		
		public function ConnectToWifiViewMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			view.logger = super.logger;
			view.assetManager = assetStore.assetManager;
			
			addContextListener(ApplicationModelEvent.ON_UPDATE_DEVICE, onUpdateDevice);
			
			view.addEventListener(SwipeControlEvent.SWIPE_LEFT, onSwipeLeft);
			view.addEventListener(SwipeControlEvent.SWIPE_RIGHT, onSwipeRight);
			
			view.addEventListener(ViewEvent.ON_VIEW_INIT_COMPLETE, onInitComplete);
			view.addEventListener(ViewEvent.ON_PREPARE_VIEW_IN, onPrepareViewIn);
			
			view.addEventListener(ViewEvent.ON_VIEW_IN_COMPLETE, onViewInComplete);
			view.addEventListener(ViewEvent.ON_VIEW_OUT_COMPLETE, onViewOutComplete);
		}
		
		private function onPrepareViewIn(event:ViewEvent):void
		{
			view.infoText.text = "Connect to Wi-Fi";
			view.infoText.alpha = 0;
			view.infoText.visible = false;
			view.castButton.alpha = 0;
			view.castButton.visible = false;
		}
		
		private function onViewInComplete(event:ViewEvent):void
		{
			view.infoText.height = 1;
			view.infoText.text = "Connect to Wi-Fi";
			view.castButton.visible = false;
			view.castButton.alpha = 0;
			view.gradient.setText("");
			view.swipeToContinue.visible = false;
			TweenMax.killTweensOf(view.infoText);
			TweenMax.to(view.infoText, .5, {delay: 0, autoAlpha: 1})
			TweenMax.to(view.castButton, 1, {delay: 3, autoAlpha: 0.5, onStart:onTweenStart})
			TweenMax.to(view.infoText, .5, {delay: 2.5, autoAlpha: 0})
		}
		private function onViewOutComplete(event:ViewEvent):void
		{
			view.infoText.height = 1;
			view.infoText.text = "Connect to Wi-Fi";
			view.castButton.visible = false;
			view.castButton.alpha = 0;
			view.gradient.setText("");
			view.swipeToContinue.visible = false;
			
			TweenMax.killTweensOf(view.castButton);
			
			view.infoText.y = screeYPos + ((view.deviceDisplay.currentDevice.screenSize.height - view.infoText.height) / 2);
		}
		private function onTweenStart():void
		{
			if (selectedDevice == DeviceTypeVo.MOBILE)
			{
				view.infoText.text = "Once the cast button \nappears, you’re \nready to cast";
			}
			else
			{
				view.infoText.text = "Once the cast button appears, \nyou’re ready to cast";
			}
			
			view.infoText.y = screeYPos + ((view.deviceDisplay.currentDevice.screenSize.height - view.infoText.height) / 2) + 30;
			
			view.swipeToContinue.visible = true;
			
			TweenMax.to(view.infoText, .5, {delay: 0, autoAlpha: 1})
		}
		
		private function onInitComplete(event:ViewEvent):void
		{
			view.infoText.text = "Connect to Wi-Fi";
			view.castButton.alpha = 0;
			view.castButton.visible = false;
		}
		
		private function onUpdateDevice(event : ApplicationModelEvent):void
		{
			selectedDevice = event.device;
			
			view.deviceDisplay.changeDevice(selectedDevice);
			
			screeXPos = view.deviceDisplay.currentDevice.x + view.deviceDisplay.currentDevice.screenSize.x;
			screeYPos = view.deviceDisplay.currentDevice.y + view.deviceDisplay.currentDevice.screenSize.y;
			
			view.infoText.width = view.deviceDisplay.currentDevice.screenSize.width;
			view.infoText.x = screeXPos;
			view.infoText.y = screeYPos + ((view.deviceDisplay.currentDevice.screenSize.height - view.infoText.height) / 2);
			view.castButton.x = screeXPos + view.deviceDisplay.currentDevice.screenSize.width - view.castButton.width - 15;
			view.castButton.y = screeYPos + 15;
		}
		
		
		
		
	}
}
