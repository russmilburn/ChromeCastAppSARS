/**
 * Created by russellmilburn on 28/09/15.
 */
package com.tro.chromecast.views.mediators
{

	import com.tro.chromecast.models.vos.DeviceTypeVo;
	import com.tro.chromecast.views.BackdropExampleView;
	import com.tro.chromecast.views.ViewEvent;
	import com.tro.chromecast.views.components.SwipeControlEvent;

	public class BackdropExampleViewMediator extends BaseMediator
	{
		[Inject]
		public var view : BackdropExampleView;
		
		public function BackdropExampleViewMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			view.logger = super.logger;
			
			view.assetManager = assetStore.assetManager;
			
			view.addEventListener(ViewEvent.ON_VIEW_INIT_COMPLETE, onViewInitComplete);
			
			view.addEventListener(SwipeControlEvent.SWIPE_LEFT, onSwipeLeft);
			view.addEventListener(SwipeControlEvent.SWIPE_RIGHT, onSwipeRight);
		}
		
		private function onViewInitComplete(event:ViewEvent):void
		{
			view.deviceDisplay.changeDevice(DeviceTypeVo.MOBILE);
			view.deviceDisplay.updateScreenOnCurrentDevice(view.getTexture("BackdropPhone"));
		}		
	}
}
