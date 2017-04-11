/**
 * Created by russellmilburn on 15/09/15.
 */
package com.tro.chromecast.views.mediators
{

	import com.greensock.TweenMax;
	import com.tro.chromecast.views.ViewEvent;
	import com.tro.chromecast.views.components.PopUpMagnifierEvent;
	import com.tro.chromecast.views.components.SwipeControlEvent;
	import com.tro.chromecast.views.connectsectionviews.AddExtensionView;

	public class AddExtensionViewMediator extends BaseMediator
	{
		[Inject]
		public var view : AddExtensionView;

		public function AddExtensionViewMediator()
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
		}

		private function onInitComplete(event:ViewEvent):void
		{
			view.popUp.enablePopUpButton();
			view.popUp.addEventListener(PopUpMagnifierEvent.ON_BUTTON_TAP, onButtonTap);
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

		
	}
}
