/**
 * Created by tro on 28/07/2015.
 */
package com.tro.chromecast.views.mediators
{

	import com.tro.chromecast.views.ARInstructionalView;
	import com.tro.chromecast.views.ARInstructionalViewEvent;
	import com.tro.chromecast.views.ViewEvent;
	import com.tro.chromecast.views.components.SwipeControlEvent;

	public class ARInstructionalViewMediator extends BaseMediator
	{
		[Inject]
		public var view:ARInstructionalView;

		public function ARInstructionalViewMediator()
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
			view.addEventListener(ViewEvent.ON_PREPARE_VIEW_IN, onPrepareViewIn);
			view.addEventListener(ViewEvent.ON_VIEW_OUT_COMPLETE, onViewOutComplete);
		}


		private function onPrepareViewIn(event:ViewEvent):void
		{
			view.reset();
		}

		private function onViewInComplete(event:ViewEvent):void
		{
			view.animate();
		}

		private function onViewOutComplete(event:ViewEvent):void
		{
			view.reset();
		}

		override protected function onSwipeLeft(event:SwipeControlEvent):void
		{
			nextView();
		}

		override protected function onSwipeRight(event:SwipeControlEvent):void
		{
			prevView();
		}

	}
}
