/**
 * Created by russellmilburn on 02/09/15.
 */
package com.tro.chromecast.views.mediators
{

	import com.tro.chromecast.views.CastYourOwnContentView;;
	import com.tro.chromecast.views.ViewEvent;
	import com.tro.chromecast.views.components.SwipeControlEvent;

	import org.gestouch.gestures.TapGesture;

	public class CastYourOwnContentMediator extends BaseMediator
	{
		
		[Inject]
		public var view : CastYourOwnContentView;
		
		private var currentSectionId: String;
		
		
		public function CastYourOwnContentMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			view.logger = super.logger;
			view.assetManager = assetStore.assetManager;
			
			view.addEventListener(ViewEvent.ON_VIEW_INIT_COMPLETE, onViewInitComplete);
			view.addEventListener(ViewEvent.ON_VIEW_IN_COMPLETE, onViewInComplete);
			
			view.addEventListener(SwipeControlEvent.SWIPE_LEFT, onSwipeLeft);
			view.addEventListener(SwipeControlEvent.SWIPE_RIGHT, onSwipeRight);
		}
		
		private function onViewInComplete(event:ViewEvent):void
		{
			
		}
		
		private function onViewInitComplete(event:ViewEvent):void
		{
			
		}
		
		
	}
}
