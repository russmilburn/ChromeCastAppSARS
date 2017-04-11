/**
 * Created by russellmilburn on 15/09/15.
 */
package com.tro.chromecast.views.mediators
{

	import com.greensock.TweenMax;
	import com.tro.chromecast.models.ApplicationModelEvent;
	import com.tro.chromecast.models.vos.DeviceTypeVo;
	import com.tro.chromecast.views.MirrorYourDeviceMobileView;
	import com.tro.chromecast.views.ViewEvent;
	import com.tro.chromecast.views.components.SwipeControlEvent;
	import com.tro.chromecast.views.connectsectionviews.ConnectToWifiView;

	public class MirrorYourDeviceMobileMediator extends BaseMediator
	{
		[Inject]
		public var view : MirrorYourDeviceMobileView;
		
		public function MirrorYourDeviceMobileMediator()
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
		}

		
		private function onInitComplete(event:ViewEvent):void
		{
			//view.deviceDisplay.changeDevice(DeviceTypeVo.MOBILE);
			//view.deviceDisplay.updateScreenOnCurrentDevice(view.getTexture("MirrorYourDeviceViewMOBILE"));
			//view.gradient.setText("Or mirror your Android mobile device\n(currently available on devices running Android 4.4.2 or higher)");
		}
		
		
	}
}
