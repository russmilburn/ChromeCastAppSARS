/**
 * Created by russellmilburn on 02/09/15.
 */
package com.tro.chromecast.views.mediators
{

	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.models.states.section.SectionList;
	import com.tro.chromecast.views.ExitAppView;
	import com.tro.chromecast.views.ViewEvent;
	import com.tro.chromecast.views.components.buttons.NavigationBtnEvent;

	import org.gestouch.events.GestureEvent;

	public class ExitAppViewMediator extends BaseMediator
	{
		[Inject]
		public var view : ExitAppView;

		public function ExitAppViewMediator()
		{
			super();

		}


		override public function initialize():void
		{
			super.initialize();

			view.logger = super.logger;
			view.assetManager = assetStore.assetManager;

			view.addEventListener(ViewEvent.ON_VIEW_INIT_COMPLETE, onViewInitComplete)


		}

		private function onViewInitComplete(event:ViewEvent):void
		{
			view.yesBtn.tap.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onYesTapHandler);
			view.noBtn.tap.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onNoTapHandler);
		}

		private function onYesTapHandler(event:GestureEvent):void
		{
			var evt : AppEvent = new AppEvent(AppEvent.UPDATE_SECTION);
			evt.sectionName = SectionList.INTRO_SECTION;
			dispatch(evt);

		}

		private function onNoTapHandler(event:GestureEvent):void
		{
			var evt : AppEvent = new AppEvent(AppEvent.SWIPE_RIGHT);
			dispatch(evt);
		}
	}
}
