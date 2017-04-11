/**
 * Created by russellmilburn on 22/07/15.
 */
package com.tro.chromecast.views.mediators
{

	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.interfaces.IView;
	import com.tro.chromecast.models.ApplicationModelEvent;
	import com.tro.chromecast.models.StageModel;
	import com.tro.chromecast.views.ARInstructionalView;
	import com.tro.chromecast.views.BackdropExampleView;
	import com.tro.chromecast.views.BackdropSlideShowView;
	import com.tro.chromecast.views.BackgroundTasksView;
	import com.tro.chromecast.views.CastAppsView;
	import com.tro.chromecast.views.CastYourOwnContentView;
	import com.tro.chromecast.views.ChooseDeviceView;
	import com.tro.chromecast.views.DiscoverMoreAppView;
	import com.tro.chromecast.views.DoMoreMenuView;
	import com.tro.chromecast.views.ExitAppView;
	import com.tro.chromecast.views.GuestModeView;
	import com.tro.chromecast.views.HowToCastView;
	import com.tro.chromecast.views.IntroView;
	import com.tro.chromecast.views.LoginView;
	import com.tro.chromecast.views.MirrorYourDeviceLaptopView;
	import com.tro.chromecast.views.MirrorYourDeviceMobileView;
	import com.tro.chromecast.views.NavMenuView;
	import com.tro.chromecast.views.PluginDragView;
	import com.tro.chromecast.views.RepeatSectionView;
	import com.tro.chromecast.views.SectionChooseDeviceView;
	import com.tro.chromecast.views.StarlingViewContainer;
	import com.tro.chromecast.views.SwipeInstructionsView;
	import com.tro.chromecast.views.UserFeedbackView;
	import com.tro.chromecast.views.ViewEvent;
	import com.tro.chromecast.views.ViewList;
	import com.tro.chromecast.views.ViewLoader;
	import com.tro.chromecast.views.connectsectionviews.AddExtensionView;
	import com.tro.chromecast.views.connectsectionviews.ChooseDeviceOsView;
	import com.tro.chromecast.views.connectsectionviews.ConnectToWifiView;
	import com.tro.chromecast.views.connectsectionviews.DownloadView;
	import com.tro.chromecast.views.connectsectionviews.InstallChromeView;

	import flash.utils.Dictionary;

	import org.gestouch.gestures.TapGesture;

	import starling.display.Canvas;

	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;

	public class StarlingViewContainerMediator extends BaseMediator
	{


		[Inject]
		public var view : StarlingViewContainer;

		[Inject(name="ui")]
		public var starlingUi : DisplayObjectContainer;

		[Inject]
		public var model : StageModel;
		private var viewContainer : Sprite;


		private var viewDictionary : Dictionary;

		private var incoming : IView;
		private var outgoing : IView;
		private var noOfViews : int;
		private var noOfViewsInitialized : int;

		private var interactionBlocker : Canvas;

		private var loadingView:ViewLoader;


		public function StarlingViewContainerMediator()
		{
			super();
		}


		override public function initialize():void
		{
			super.initialize();

			viewDictionary = new Dictionary();

			logger.info("init");

			loadingView =  new ViewLoader();
			viewContainer = new Sprite();

			view.addChild(viewContainer);
			view.addChild(loadingView);



			addContextListener(AppEvent.START_VIEW_INIT, startViewInit);

			addContextListener(ApplicationModelEvent.ON_PREPARE_INCOMING_VIEW, onPrepareViewIn);
			addContextListener(ApplicationModelEvent.ON_PREPARE_OUTGOING_VIEW, onPrepareViewOut);

		}

		private function startViewInit(event : AppEvent):void
		{
			logger.info("[START UP 9]: Start to init Views");
			createChildren();
		}



		private function createChildren() : void
		{
			noOfViewsInitialized = 0;

			var loginView : LoginView = new LoginView();
			var swipe: SwipeInstructionsView = new SwipeInstructionsView();
			var augRealityInstructions: ARInstructionalView = new ARInstructionalView();
			var choose: SectionChooseDeviceView = new SectionChooseDeviceView();
			var chooseA: ChooseDeviceView = new ChooseDeviceView();
			var chooseB: ChooseDeviceView = new ChooseDeviceView();
			var chooseC: ChooseDeviceView = new ChooseDeviceView();
			var castApps: CastAppsView = new CastAppsView();
			var howToCast: HowToCastView = new HowToCastView();
			var menuView: NavMenuView = new NavMenuView();
			var feedback: UserFeedbackView = new UserFeedbackView();
			var backgroundTasks: BackgroundTasksView = new BackgroundTasksView();
			var repeatSection: RepeatSectionView = new RepeatSectionView();
			var exitApp: ExitAppView = new ExitAppView();
			var doMoreMenu: DoMoreMenuView = new DoMoreMenuView();
			var addExtension: AddExtensionView = new AddExtensionView();
			var connectToWifi: ConnectToWifiView = new ConnectToWifiView();
			var downloadView: DownloadView = new DownloadView();
			var installChrome: InstallChromeView = new InstallChromeView();
			var chooseOSView: ChooseDeviceOsView = new ChooseDeviceOsView();
			var plugInView: PluginDragView = new PluginDragView();
			var introView: IntroView = new IntroView();
			var discoverMoreApps: DiscoverMoreAppView = new DiscoverMoreAppView();
			var backdropExample: BackdropExampleView = new BackdropExampleView();
			var backdropSlideShow: BackdropSlideShowView = new BackdropSlideShowView();
			var mirrorYourDeviceLaptopView: MirrorYourDeviceLaptopView = new MirrorYourDeviceLaptopView();
			var mirrorYourDeviceMobileView: MirrorYourDeviceMobileView = new MirrorYourDeviceMobileView();
			var castYourOwnContentView: CastYourOwnContentView = new CastYourOwnContentView();
			var guestMode: GuestModeView = new GuestModeView();


			viewDictionary[ViewList.LOG_IN_VIEW] = loginView;
			viewDictionary[ViewList.NAV_MENU_VIEW] = menuView;
			viewDictionary[ViewList.SWIPE_INSTRUCTIONS_VIEW] = swipe;
			viewDictionary[ViewList.AUG_REALITY_INSTRUCTIONS_VIEW] = augRealityInstructions;
			viewDictionary[ViewList.SECTION_CHOOSE_DEVICE_VIEW] = choose;
			viewDictionary[ViewList.CAST_APPS_VIEW] = castApps;
			viewDictionary[ViewList.HOW_TO_CAST_VIEW] = howToCast;
			viewDictionary[ViewList.USER_FEEDBACK_VIEW] = feedback;
			viewDictionary[ViewList.BACKGROUND_TASKS_VIEW] = backgroundTasks;
			viewDictionary[ViewList.REPEAT_SECTION_VIEW] = repeatSection;
			viewDictionary[ViewList.CHOOSE_DEVICE_VIEW_A] = chooseA;
			viewDictionary[ViewList.CHOOSE_DEVICE_VIEW_B] = chooseB;
			viewDictionary[ViewList.CHOOSE_DEVICE_VIEW_C] = chooseC;
			viewDictionary[ViewList.DO_MORE_MENU_VIEW] = doMoreMenu;
			viewDictionary[ViewList.EXIT_APP_VIEW] = exitApp;
			viewDictionary[ViewList.ADD_EXTENSION_VIEW] = addExtension;
			viewDictionary[ViewList.CONNECT_TO_WIFI_VIEW] = connectToWifi;
			viewDictionary[ViewList.DOWNLOAD_VIEW] = downloadView;
			viewDictionary[ViewList.INSTALL_CHROME_VIEW] = installChrome;
			viewDictionary[ViewList.CHOOSE_DEVICE_OS_VIEW] = chooseOSView;
			viewDictionary[ViewList.PLUGIN_DRAG_VIEW] = plugInView;
			viewDictionary[ViewList.EXIT_APP_VIEW] = exitApp;
			viewDictionary[ViewList.INTRO_VIEW] = introView;
			viewDictionary[ViewList.DISCOVER_MORE_APPS_VIEW] = discoverMoreApps;
			viewDictionary[ViewList.BACKDROP_EXAMPLE_VIEW] = backdropExample;
			viewDictionary[ViewList.BACKDROP_SLIDESHOW_VIEW] = backdropSlideShow;
			viewDictionary[ViewList.MIRROR_YOUR_DEVICE_LAPTOP_VIEW] = mirrorYourDeviceLaptopView;
			viewDictionary[ViewList.MIRROR_YOUR_DEVICE_MOBILE_VIEW] = mirrorYourDeviceMobileView;
			viewDictionary[ViewList.CAST_YOUR_OWN_CONTENT_VIEW] = castYourOwnContentView;
			viewDictionary[ViewList.GUEST_MODE_VIEW] = guestMode;




			for each (var iView:IView in viewDictionary)
			{
				noOfViews ++;
				iView.addEventListener(ViewEvent.ON_VIEW_INIT_COMPLETE, onCreateViewComplete);
				iView.hide();
			}

			viewContainer.addChild(loginView);
			viewContainer.addChild(swipe);
			viewContainer.addChild(augRealityInstructions);
			viewContainer.addChild(choose);
			viewContainer.addChild(chooseA);
			viewContainer.addChild(chooseB);
			viewContainer.addChild(chooseC);
			viewContainer.addChild(castApps);
			viewContainer.addChild(howToCast);
			viewContainer.addChild(backgroundTasks);
			viewContainer.addChild(repeatSection);
			viewContainer.addChild(doMoreMenu);
			viewContainer.addChild(addExtension);
			viewContainer.addChild(connectToWifi);
			viewContainer.addChild(downloadView);
			viewContainer.addChild(installChrome);
			viewContainer.addChild(chooseOSView);
			viewContainer.addChild(plugInView);
			viewContainer.addChild(exitApp);
			viewContainer.addChild(introView);
			viewContainer.addChild(discoverMoreApps);
			viewContainer.addChild(backdropExample);
			viewContainer.addChild(backdropSlideShow);
			viewContainer.addChild(mirrorYourDeviceLaptopView);
			viewContainer.addChild(mirrorYourDeviceMobileView);
			viewContainer.addChild(castYourOwnContentView);
			viewContainer.addChild(guestMode);



			// menu view is persistent should be displayed as the second highest item
			// in the display list.
			viewContainer.addChild(menuView);
			// feedback is the top most object to be added
			// as it will act to block event happening when the application is processing
			// or performing actions.
			viewContainer.addChild(feedback);

			interactionBlocker = new Canvas();
			interactionBlocker.beginFill(0x00ff00, 0);
			interactionBlocker.drawRectangle(0,0, view.stage.stageWidth, view.stage.stageHeight);
			interactionBlocker.endFill();

			view.addChild(interactionBlocker);
		}

		private function onCreateViewComplete(event : ViewEvent) : void
		{
			noOfViewsInitialized++;
			logger.info("[START UP 10]: ViewInit: " + noOfViewsInitialized+ " out of " + noOfViews + " ViewName " + event.currentTarget);

			if (event.currentTarget == viewDictionary[ViewList.NAV_MENU_VIEW])
			{
				dispatch(new AppEvent(AppEvent.INIT_MAIN_MENU))
			}

			if (noOfViewsInitialized == noOfViews)
			{

				for each (var iView:IView in viewDictionary)
				{
					iView.removeEventListener(ViewEvent.ON_VIEW_INIT_COMPLETE, onCreateViewComplete);

				}
				logger.info("[START UP 11]: View Setup Complete");
				dispatch(new AppEvent(AppEvent.START_UP_COMPLETE));
			}
		}


		private function onViewsInitComplete(event : ViewEvent):void
		{
			logger.info("onViewsInitComplete");
			viewDictionary[ViewList.LOG_IN_VIEW].removeEventListener(ViewEvent.ON_VIEW_INIT_COMPLETE, onViewsInitComplete);

		}

		private function onPrepareViewIn(event : ApplicationModelEvent):void
		{
			//logger.info("[INCOMING 5]: onPrepareViewIn: " + event.viewName);
			if (interactionBlocker != null)
			{
				interactionBlocker.visible = true;
				interactionBlocker.touchable = true;
			}

			if (event.viewName == ViewList.AR_VIEW)
			{
				return;
			}

			prepareViewIn(getView(event.viewName), event.direction);
		}

		private function onPrepareViewOut(event : ApplicationModelEvent):void
		{
			//logger.info("[OUTGOING 5]: onPrepareViewOut: " + event.viewName);

			if (event.viewName == ViewList.AR_VIEW)
			{
				return;
			}

			prepareViewOut(getView(event.viewName), event.direction);
		}



		protected function getView(viewId : String ) : IView
		{
			return IView(viewDictionary[viewId]);
		}



		public function prepareViewIn(view : IView, direction : String) : void
		{
			incoming = view;

			//logger.info("[INCOMING 6]: prepareViewIn, incoming: " + incoming);

			incoming.addEventListener(ViewEvent.ON_VIEW_IN_COMPLETE, onViewInComplete);


			incoming.prepareViewIn(direction);
			incoming.display();
			startIncoming();
		}

		public function startIncoming() : void
		{
			//logger.info("[INCOMING 7]: startIncoming: "+ incoming);
			incoming.startViewIn();
		}

		private function onViewInComplete(event:ViewEvent):void
		{
			//logger.info("[INCOMING 8]: onViewInComplete: " + incoming);
			incoming.removeEventListener(ViewEvent.ON_VIEW_IN_COMPLETE, onViewInComplete);
			incoming = null;
			interactionBlocker.visible = false;
			interactionBlocker.touchable = false;
		}

		public function prepareViewOut(view : IView, direction:String) : void
		{
			outgoing = view;
			//logger.info("[OUTGOING 6]: prepareViewIn, outgoing: " + outgoing);

			outgoing.addEventListener(ViewEvent.ON_VIEW_OUT_COMPLETE, onViewOutComplete);
			outgoing.prepareViewOut(direction);
			startOutgoing();
		}

		public function startOutgoing() : void
		{
			//logger.info("[OUTGOING 7]: startOutgoing: "+ outgoing);
			outgoing.startViewOut();
		}

		private function onViewOutComplete(event:ViewEvent):void
		{
			//logger.info("[OUTGOING 8]: onViewOutComplete: " + outgoing);
			outgoing.removeEventListener(ViewEvent.ON_VIEW_OUT_COMPLETE, onViewOutComplete);
			outgoing.hide();
			outgoing = null;

			interactionBlocker.visible = false;
			interactionBlocker.touchable = false;
		}
	}
}
