/**
 * Created by russellmilburn on 15/09/15.
 */
package com.tro.chromecast.views.mediators
{

	import com.greensock.TweenMax;
	import com.tro.chromecast.models.ApplicationModelEvent;
	import com.tro.chromecast.models.vos.DeviceTypeVo;
	import com.tro.chromecast.views.MirrorYourDeviceLaptopView;
	import com.tro.chromecast.views.ViewEvent;
	import com.tro.chromecast.views.components.SwipeControlEvent;
	import com.tro.chromecast.views.connectsectionviews.ConnectToWifiView;

	public class MirrorYourDeviceLaptopMediator extends BaseMediator
	{
		[Inject]
		public var view : MirrorYourDeviceLaptopView;
		
		public function MirrorYourDeviceLaptopMediator()
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
		}

		
		
	}
}
