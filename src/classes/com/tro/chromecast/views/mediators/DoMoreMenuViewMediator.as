/**
 * Created by russellmilburn on 15/09/15.
 */
package com.tro.chromecast.views.mediators
{

	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.models.ApplicationModel;
	import com.tro.chromecast.models.ApplicationModelEvent;
	import com.tro.chromecast.models.ContentModel;
	import com.tro.chromecast.views.DoMoreMenuView;
	import com.tro.chromecast.views.ViewEvent;
	import com.tro.chromecast.views.components.SwipeControlEvent;
	import com.tro.chromecast.views.components.buttons.NavigationBtnEvent;

	public class DoMoreMenuViewMediator extends BaseMediator
	{
		[Inject]
		public var view : DoMoreMenuView;

		[Inject]
		public var appModel : ApplicationModel;

		private var dataProvider : Array;


		public function DoMoreMenuViewMediator()
		{
			super();
		}


		override public function initialize():void
		{
			super.initialize();

			view.logger = super.logger;
			view.assetManager = assetStore.assetManager;

			addContextListener(ApplicationModelEvent.ON_SETUP_DO_MORE_MENU, onSetupDoMoreMenu);

			view.addEventListener(SwipeControlEvent.SWIPE_LEFT, onSwipeLeft);
			view.addEventListener(SwipeControlEvent.SWIPE_RIGHT, onSwipeRight);

			view.addEventListener(ViewEvent.ON_VIEW_INIT_COMPLETE, onViewInitComplete);
			view.addEventListener(ViewEvent.ON_VIEW_INIT_COMPLETE, onViewInitComplete);

			view.addEventListener(NavigationBtnEvent.ON_TAP, onTapMenuButtonHandler);



		}

		private function onTapMenuButtonHandler(event:NavigationBtnEvent):void
		{
			var evt : AppEvent = new AppEvent(AppEvent.UPDATE_SECTION);
			evt.sectionName = event.vo.sectionName;
			dispatch(evt);
		}

		private function onViewInitComplete(event:ViewEvent):void
		{

		}

		private function onSetupDoMoreMenu(event : ApplicationModelEvent):void
		{
			dataProvider = appModel.doMoreData;
			view.dataProvider = dataProvider;
		}

		
	}
}
