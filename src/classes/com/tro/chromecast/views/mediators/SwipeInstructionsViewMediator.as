/**
 * Created by russellmilburn on 29/07/15.
 */
package com.tro.chromecast.views.mediators
{

	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.models.AssetStorage;
	import com.tro.chromecast.views.SwipeInstructionsView;
	import com.tro.chromecast.views.ViewEvent;
	import com.tro.chromecast.views.components.SwipeControlEvent;

	public class SwipeInstructionsViewMediator extends BaseMediator
	{
		[Inject]
		public var view : SwipeInstructionsView;



		public function SwipeInstructionsViewMediator()
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

			view.addEventListener(ViewEvent.ON_VIEW_IN_COMPLETE, onViewInComplete);
			view.addEventListener(ViewEvent.ON_VIEW_OUT_COMPLETE, onViewOutComplete);

		}



		//Welcome to Chromecast. Just swipe left or right to navigate.

		private function onViewOutComplete(event:ViewEvent):void
		{
			//TODO: stop and rest view animation
			view.reset();

		}

		private function onViewInComplete(event:ViewEvent):void
		{
			view.animate();
		}

		
	}
}
