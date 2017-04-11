/**
 * Created by russellmilburn on 22/07/15.
 */
package com.tro.chromecast.views.mediators
{


	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.models.AssetStorage;
	import com.tro.chromecast.views.components.SwipeControlEvent;

	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.ILogger;

	import starling.display.DisplayObject;

	public class BaseMediator extends Mediator
	{
		[Inject]
		public var logger : ILogger;

		[Inject]
		public var mediatorMap : IMediatorMap;

		[Inject]
		public var assetStore:AssetStorage;




		public function BaseMediator()
		{
			super();
		}

		public function nextView() : void
		{
			dispatch(new AppEvent(AppEvent.SWIPE_LEFT));
		}

		public function prevView() : void
		{
			dispatch(new AppEvent(AppEvent.SWIPE_RIGHT));
		}

		protected function onSwipeLeft(event:SwipeControlEvent):void
		{
			//logger.info("onSwipeLeft");
			event.stopPropagation();
			
			nextView();
		}

		protected function onSwipeRight(event:SwipeControlEvent):void
		{
			//logger.info("onSwipeRight");
			event.stopPropagation();
			
			prevView();
		}



	}
}
