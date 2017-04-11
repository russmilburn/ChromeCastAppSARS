package com.tro.chromecast.views.mediators 
{

	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.views.components.SwipeControlEvent;
	import com.tro.chromecast.views.IntroView;
	import com.tro.chromecast.views.ViewEvent;
	
	/**
	 * ...
	 * @author David Armstrong
	 */
	public class IntroViewMediator extends BaseMediator 
	{
		[Inject]
		public var view:IntroView;
		
		public function IntroViewMediator() 
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
			
			//view.addEventListener(ViewEvent.ON_VIEW_INIT_COMPLETE, onViewInitComplete);
			view.addEventListener(ViewEvent.ON_VIEW_IN_COMPLETE, onViewInComplete);
			//view.addEventListener(ViewEvent.ON_VIEW_OUT_COMPLETE, onViewOutComplete);
			
		}

		private function onViewInComplete(event:ViewEvent):void
		{
			logger.info("onViewInComplete");
			dispatch(new AppEvent(AppEvent.OPEN_NAV_MENU));
		}
		
		
		
	}

}