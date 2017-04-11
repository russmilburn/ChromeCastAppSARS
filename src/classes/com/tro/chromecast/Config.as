/**
 * Created by russellmilburn on 22/07/15.
 */
package com.tro.chromecast
{

	import com.tro.chromecast.commands.ChangeSectionCommand;
	import com.tro.chromecast.commands.CheckPinCodeCommand;
	import com.tro.chromecast.commands.CloseAppCommand;
	import com.tro.chromecast.commands.DestroyAugRealityCommand;
	import com.tro.chromecast.commands.InitAugRealityCommand;
	import com.tro.chromecast.commands.InitMainMenuCommand;
	import com.tro.chromecast.commands.NextViewCommand;
	import com.tro.chromecast.commands.OpenMenuCommand;
	import com.tro.chromecast.commands.PrevViewCommand;
	import com.tro.chromecast.commands.SetCastAppVoCommand;
	import com.tro.chromecast.commands.SetDeviceTypeCommand;
	import com.tro.chromecast.commands.SetIsMenuOpenCommand;
	import com.tro.chromecast.commands.TrackInteractionCommand;
	import com.tro.chromecast.commands.UpdateStageSizeCommand;
	import com.tro.chromecast.commands.startup.FloxInitCommand;
	import com.tro.chromecast.commands.startup.InitDatabaseCommand;
	import com.tro.chromecast.commands.startup.InitViewsCommand;
	import com.tro.chromecast.commands.startup.Load3dModelsCommand;
	import com.tro.chromecast.commands.startup.LoadAssetLibraryCommand;
	import com.tro.chromecast.commands.startup.StartUpCommand;
	import com.tro.chromecast.commands.startup.StartUpCompleteCommand;
	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.models.ApplicationModel;
	import com.tro.chromecast.models.AssetStorage;
	import com.tro.chromecast.models.ContentModel;
	import com.tro.chromecast.models.PinCodeModel;
	import com.tro.chromecast.models.StageModel;
	import com.tro.chromecast.models.StageModelEvent;
	import com.tro.chromecast.models.TrackingModel;
	import com.tro.chromecast.models.augreality.ARModelNative;
	import com.tro.chromecast.models.augreality.IARModel;
	import com.tro.chromecast.models.away3d.EntireScene;
	import com.tro.chromecast.models.states.section.AugRealitySection;
	import com.tro.chromecast.models.states.section.BackdropSection;
	import com.tro.chromecast.models.states.section.CastContentSection;
	import com.tro.chromecast.models.states.section.ConnectDeviceSection;
	import com.tro.chromecast.models.states.section.ConnectLaptopSection;
	import com.tro.chromecast.models.states.section.ConnectSection;
	import com.tro.chromecast.models.states.section.DiscoverMoreSection;
	import com.tro.chromecast.models.states.section.DoMoreSection;
	import com.tro.chromecast.models.states.section.EnjoySection;
	import com.tro.chromecast.models.states.section.ExitSection;
	import com.tro.chromecast.models.states.section.GuestModeSection;
	import com.tro.chromecast.models.states.section.InstructionSection;
	import com.tro.chromecast.models.states.section.IntroSection;
	import com.tro.chromecast.models.states.section.MirrorDeviceSection;
	import com.tro.chromecast.models.states.section.PlugInSection;
	import com.tro.chromecast.service.DatabaseService;
	import com.tro.chromecast.service.FloxService;
	import com.tro.chromecast.views.ARInstructionalView;
	import com.tro.chromecast.views.ARView;
	import com.tro.chromecast.views.AugRealityUiView;
	import com.tro.chromecast.views.BackdropExampleView;
	import com.tro.chromecast.views.BackdropSlideShowView;
	import com.tro.chromecast.views.BackgroundStarlingView;
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
	import com.tro.chromecast.views.ViewLoader;
	import com.tro.chromecast.views.connectsectionviews.AddExtensionView;
	import com.tro.chromecast.views.connectsectionviews.ChooseDeviceOsView;
	import com.tro.chromecast.views.connectsectionviews.ConnectToWifiView;
	import com.tro.chromecast.views.connectsectionviews.DownloadView;
	import com.tro.chromecast.views.connectsectionviews.InstallChromeView;
	import com.tro.chromecast.views.mediators.ARInstructionalViewMediator;
	import com.tro.chromecast.views.mediators.ARViewMediator;
	import com.tro.chromecast.views.mediators.AddExtensionViewMediator;
	import com.tro.chromecast.views.mediators.AugRealityUiViewMediator;
	import com.tro.chromecast.views.mediators.BackdropExampleViewMediator;
	import com.tro.chromecast.views.mediators.BackdropSlideShowViewMediator;
	import com.tro.chromecast.views.mediators.BackgroundStarlingViewMediator;
	import com.tro.chromecast.views.mediators.BackgroundTasksViewMediator;
	import com.tro.chromecast.views.mediators.CastAppsViewMediator;
	import com.tro.chromecast.views.mediators.CastYourOwnContentMediator;
	import com.tro.chromecast.views.mediators.ChooseDeviceOsViewMediator;
	import com.tro.chromecast.views.mediators.ChooseYourDeviceMediator;
	import com.tro.chromecast.views.mediators.ConnectToWifiViewMediator;
	import com.tro.chromecast.views.mediators.DiscoverMoreAppViewMediator;
	import com.tro.chromecast.views.mediators.DoMoreMenuViewMediator;
	import com.tro.chromecast.views.mediators.DownloadViewMediator;
	import com.tro.chromecast.views.mediators.ExitAppViewMediator;
	import com.tro.chromecast.views.mediators.GuestModeViewMediator;
	import com.tro.chromecast.views.mediators.HowToCastViewMediator;
	import com.tro.chromecast.views.mediators.InstallChromeViewMediator;
	import com.tro.chromecast.views.mediators.IntroViewMediator;
	import com.tro.chromecast.views.mediators.LoginViewMediator;
	import com.tro.chromecast.views.mediators.MirrorYourDeviceLaptopMediator;
	import com.tro.chromecast.views.mediators.MirrorYourDeviceMobileMediator;
	import com.tro.chromecast.views.mediators.NavMenuViewMediator;
	import com.tro.chromecast.views.mediators.PluginDragViewMediator;
	import com.tro.chromecast.views.mediators.RepeatSectionViewMediator;
	import com.tro.chromecast.views.mediators.SectionChooseDeviceViewMediator;
	import com.tro.chromecast.views.mediators.StarlingViewContainerMediator;
	import com.tro.chromecast.views.mediators.SwipeInstructionsViewMediator;
	import com.tro.chromecast.views.mediators.UserFeedbackViewMediator;
	import com.tro.chromecast.views.mediators.ViewLoaderMediator;

	import flash.events.IEventDispatcher;

	import org.swiftsuspenders.Injector;

	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.ILogger;

	public class Config
	{
		[Inject]
		public var logger :ILogger;

		[Inject]
		public var context : IContext;

		[Inject]
		public var mediatorMap : IMediatorMap;

		[Inject]
		public var commandMap : IEventCommandMap;

		[Inject]
		public var eventDispatcher : IEventDispatcher;

		[Inject]
		public var injector : Injector;


		public function Config()
		{
		}


		[PostConstruct]
		public function init():void
		{
			logger.debug("Init()" );


			injector.map(IntroSection);
			injector.map(AugRealitySection);
			injector.map(InstructionSection);
			injector.map(EnjoySection);
			injector.map(ExitSection);
			injector.map(DoMoreSection);
			injector.map(PlugInSection);
			injector.map(ConnectSection);
			injector.map(ConnectDeviceSection);
			injector.map(ConnectLaptopSection);
			injector.map(BackdropSection);
			injector.map(DiscoverMoreSection);
			injector.map(MirrorDeviceSection);
			injector.map(GuestModeSection);
			injector.map(CastContentSection);

			//injector.map(LoungeScene);
			//injector.map(ChromeCast);
			injector.map(EntireScene);


			injector.map(StageModel).asSingleton();
			injector.map(ApplicationModel).asSingleton();
			injector.map(IARModel).toSingleton(ARModelNative);
			//injector.map(IARModel).toSingleton(ARModelSWC);
			injector.map(AssetStorage).asSingleton();
			injector.map(DatabaseService).asSingleton();
			injector.map(ContentModel).asSingleton();
			injector.map(PinCodeModel).asSingleton();
			injector.map(FloxService).asSingleton();
			injector.map(TrackingModel).asSingleton();

			commandMap.map(AppEvent.START_UP, AppEvent).toCommand(StartUpCommand);
			commandMap.map(AppEvent.ON_CLOSE_APP, AppEvent).toCommand(CloseAppCommand);
			commandMap.map(AppEvent.UPDATE_SECTION, AppEvent).toCommand(ChangeSectionCommand);
			commandMap.map(AppEvent.SWIPE_LEFT, AppEvent).toCommand(NextViewCommand);
			commandMap.map(AppEvent.SWIPE_RIGHT, AppEvent).toCommand(PrevViewCommand);
			commandMap.map(AppEvent.INIT_AUG_REALTY, AppEvent).toCommand(InitAugRealityCommand);
			commandMap.map(AppEvent.DESTROY_AUG_REALTY, AppEvent).toCommand(DestroyAugRealityCommand);
			commandMap.map(AppEvent.CHECK_PIN_CODE, AppEvent).toCommand(CheckPinCodeCommand);
			commandMap.map(AppEvent.INIT_MAIN_MENU, AppEvent).toCommand(InitMainMenuCommand);
			commandMap.map(AppEvent.LOAD_ASSET_LIB, AppEvent).toCommand(LoadAssetLibraryCommand);
			commandMap.map(AppEvent.INIT_VIEWS, AppEvent).toCommand(InitViewsCommand);
			commandMap.map(AppEvent.START_UP_COMPLETE, AppEvent).toCommand(StartUpCompleteCommand);
			commandMap.map(AppEvent.SET_DEVICE_TYPE, AppEvent).toCommand(SetDeviceTypeCommand);
			commandMap.map(AppEvent.SET_CAST_APP_VO, AppEvent).toCommand(SetCastAppVoCommand);
			commandMap.map(AppEvent.SET_IS_MENU_OPEN, AppEvent).toCommand(SetIsMenuOpenCommand);
			commandMap.map(AppEvent.INIT_DATABASE, AppEvent).toCommand(InitDatabaseCommand);
			commandMap.map(AppEvent.INIT_DATABASE_COMPLETE, AppEvent).toCommand(FloxInitCommand);
			commandMap.map(AppEvent.INIT_FLOX_COMPLETE, AppEvent).toCommand(Load3dModelsCommand);
			commandMap.map(AppEvent.TRACK_INTERACTION, AppEvent).toCommand(TrackInteractionCommand);
			commandMap.map(AppEvent.OPEN_NAV_MENU, AppEvent).toCommand(OpenMenuCommand);
			commandMap.map(AppEvent.CLOSE_NAV_MENU, AppEvent).toCommand(TrackInteractionCommand);

			commandMap.map(StageModelEvent.ON_UPDATE_STAGE_SIZE, StageModelEvent).toCommand(UpdateStageSizeCommand);

			mediatorMap.map(BackgroundStarlingView).toMediator(BackgroundStarlingViewMediator);
			mediatorMap.map(StarlingViewContainer).toMediator(StarlingViewContainerMediator);
			mediatorMap.map(ARView).toMediator(ARViewMediator);
			mediatorMap.map(LoginView).toMediator(LoginViewMediator);
			mediatorMap.map(NavMenuView).toMediator(NavMenuViewMediator);
			mediatorMap.map(SwipeInstructionsView).toMediator(SwipeInstructionsViewMediator);
			mediatorMap.map(ARInstructionalView).toMediator(ARInstructionalViewMediator);
			mediatorMap.map(SectionChooseDeviceView).toMediator(SectionChooseDeviceViewMediator);
			mediatorMap.map(ChooseDeviceView).toMediator(ChooseYourDeviceMediator);
			mediatorMap.map(UserFeedbackView).toMediator(UserFeedbackViewMediator);
			mediatorMap.map(CastAppsView).toMediator(CastAppsViewMediator);
			mediatorMap.map(HowToCastView).toMediator(HowToCastViewMediator);
			mediatorMap.map(BackgroundTasksView).toMediator(BackgroundTasksViewMediator);
			mediatorMap.map(AugRealityUiView).toMediator(AugRealityUiViewMediator);
			mediatorMap.map(RepeatSectionView).toMediator(RepeatSectionViewMediator);
			mediatorMap.map(ExitAppView).toMediator(ExitAppViewMediator);
			mediatorMap.map(DoMoreMenuView).toMediator(DoMoreMenuViewMediator);
			mediatorMap.map(InstallChromeView).toMediator(InstallChromeViewMediator);
			mediatorMap.map(ChooseDeviceOsView).toMediator(ChooseDeviceOsViewMediator);
			mediatorMap.map(DownloadView).toMediator(DownloadViewMediator);
			mediatorMap.map(ConnectToWifiView).toMediator(ConnectToWifiViewMediator);
			mediatorMap.map(AddExtensionView).toMediator(AddExtensionViewMediator);
			mediatorMap.map(PluginDragView).toMediator(PluginDragViewMediator);
			mediatorMap.map(IntroView).toMediator(IntroViewMediator);
			mediatorMap.map(DiscoverMoreAppView).toMediator(DiscoverMoreAppViewMediator);
			mediatorMap.map(BackdropExampleView).toMediator(BackdropExampleViewMediator);
			mediatorMap.map(BackdropSlideShowView).toMediator(BackdropSlideShowViewMediator);
			mediatorMap.map(MirrorYourDeviceLaptopView).toMediator(MirrorYourDeviceLaptopMediator);
			mediatorMap.map(MirrorYourDeviceMobileView).toMediator(MirrorYourDeviceMobileMediator);
			mediatorMap.map(CastYourOwnContentView).toMediator(CastYourOwnContentMediator);
			mediatorMap.map(GuestModeView).toMediator(GuestModeViewMediator);

			mediatorMap.map(ViewLoader).toMediator(ViewLoaderMediator);


			context.afterInitializing(initialize);
		}

		public function initialize() : void
		{

			eventDispatcher.dispatchEvent(new AppEvent(AppEvent.START_UP));

			//contextView.view.addChild(new ViewContainer());
		}


	}
}
