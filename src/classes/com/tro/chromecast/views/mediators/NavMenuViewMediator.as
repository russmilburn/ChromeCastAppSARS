/**
 * Created by russellmilburn on 29/07/15.
 */
package com.tro.chromecast.views.mediators
{

	import com.greensock.TweenMax;
	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.models.ApplicationModel;
	import com.tro.chromecast.models.ApplicationModelEvent;
	import com.tro.chromecast.models.PinCodeModelEvent;
	import com.tro.chromecast.models.states.section.SectionList;
	import com.tro.chromecast.models.vos.NavigationBtnVo;
	import com.tro.chromecast.views.NavMenuView;
	import com.tro.chromecast.views.ViewEvent;
	import com.tro.chromecast.views.components.buttons.MenuBtn;
	import com.tro.chromecast.views.components.buttons.NavigationBtn;
	import com.tro.chromecast.views.components.buttons.NavigationBtn;
	import com.tro.chromecast.views.components.buttons.NavigationBtnEvent;
	import com.tro.chromecast.views.components.SwipeControl;
	import com.tro.chromecast.views.components.SwipeControlEvent;

	import starling.events.Event;

	public class NavMenuViewMediator extends BaseMediator
	{
		[Inject]
		public var view : NavMenuView;

		[Inject]
		public var appModel : ApplicationModel;

		private var openMenuBtn : MenuBtn;
		private var currentSelectionId :String;


		public function NavMenuViewMediator()
		{
			super();
		}


		override public function initialize():void
		{
			super.initialize();

			view.logger = super.logger;
			view.assetManager = assetStore.assetManager;

			addContextListener(ApplicationModelEvent.ON_SETUP_NAVIGATION, onSetUpNavigation);
			addContextListener(ApplicationModelEvent.ON_SECTION_SELECTED, onSectionSelected);

			addContextListener(ApplicationModelEvent.OPEN_MENU, onOpenMenu);
			addContextListener(ApplicationModelEvent.CLOSE_MENU, onCloseMenu);

			addContextListener(AppEvent.DISPLAY_NAV_MENU, onDisplayNavMenu);
			addContextListener(AppEvent.HIDE_NAV_MENU, onHideNavMenu);

			addContextListener(ApplicationModelEvent.ON_PREPARE_AUG_REALITY_VIEW, onARIncoming);
			addContextListener(ApplicationModelEvent.ON_DISPOSE_AUG_REALITY_VIEW, onAROutgoing);


			view.addEventListener(NavigationBtnEvent.SWIPE_RIGHT, onSwipeRightHandler);

			openMenuBtn = new MenuBtn();
			openMenuBtn.addEventListener(NavigationBtnEvent.OPEN_MENU, onOpenMenuTapHandler);

			openMenuBtn.x = view.stage.stageWidth - openMenuBtn.width;
			openMenuBtn.y = 50;


			view.addEventListener(NavigationBtnEvent.ON_TAP, onNavButtonTapHandler);
			view.addEventListener(NavigationBtnEvent.SWIPE_RIGHT, onSwipeRightHandler);


			view.addChild(openMenuBtn);

		}

		private function onARIncoming(event : ApplicationModelEvent):void
		{
			openMenuBtn.label.text = "Skip";
		}

		private function onAROutgoing(event : ApplicationModelEvent):void
		{
			openMenuBtn.label.text = "Menu";
		}

		private function onDisplayNavMenu(event : AppEvent):void
		{
			view.display()
		}

		private function onHideNavMenu(event : AppEvent):void
		{
			view.hide();
		}

		private function onCloseMenu(event : ApplicationModelEvent):void
		{
			if (appModel.isMenuOpen == true)
			{
				appModel.isMenuOpen = false;
				closeMenu();
			}

		}

		private function onOpenMenu(event : ApplicationModelEvent):void
		{
			if (appModel.isMenuOpen == false)
			{
				appModel.isMenuOpen = true;
				openMenu();
			}

		}

		private function onSectionSelected(event:ApplicationModelEvent):void
		{
			currentSelectionId = event.selectedSection;
			for (var i:int = 0; i < view.btns.length; i ++)
			{
				var btn : NavigationBtn = NavigationBtn(view.btns[i]);

				if (btn.data.sectionName == currentSelectionId)
				{
					btn.isSelected = true;
				}
				else
				{
					btn.isSelected = false;
				}
			}
		}

		private function onSwipeRightHandler(event:Event):void
		{
			event.stopPropagation();
			closeMenu();

			var evt : AppEvent = new AppEvent(AppEvent.SET_IS_MENU_OPEN);
			evt.isMenuOpen = false;
			dispatch(evt);
		}

		private function onOpenMenuTapHandler(event:Event):void
		{
			//logger.info("onOpenMenuTapHandler");
			event.stopPropagation();
			openMenu();

			var evt : AppEvent = new AppEvent(AppEvent.SET_IS_MENU_OPEN);
			evt.isMenuOpen = true;
			dispatch(evt);
		}

		private function openMenu():void
		{
			view.openMenu();
			openMenuBtn.disable();
		}

		private function closeMenu():void
		{
			view.closeMenu();
			openMenuBtn.enable();
		}

		private function onSetUpNavigation(event : ApplicationModelEvent):void
		{
			view.dataProvider = appModel.navigationBtnData;
		}

//		private function onDestroyAR(event:NavigationBtnEvent):void
//		{
//
//			var evt : AppEvent = new AppEvent(AppEvent.DESTROY_AUG_REALTY);
//			dispatch(evt);
//
//		}
//
//		private function onInitAR(event:NavigationBtnEvent):void
//		{
//			var evt : AppEvent = new AppEvent(AppEvent.INIT_AUG_REALTY);
//			dispatch(evt);
//		}

		private function onViewInit(event:ViewEvent):void
		{
			//logger.info("*************** onViewInit");
			//view.dataProvider = data;
		}

		private function onNavButtonTapHandler(event:NavigationBtnEvent):void
		{
			event.stopPropagation();
			//logger.info("onNavButtonTapHandler" + event.vo);

			var evt : AppEvent = new AppEvent(AppEvent.UPDATE_SECTION);
			evt.sectionName = event.vo.sectionName;
			dispatch(evt);

		}
	}
}
