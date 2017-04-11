/**
 * Created by russellmilburn on 15/09/15.
 */
package com.tro.chromecast.views.mediators
{

	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.models.ApplicationModel;
	import com.tro.chromecast.models.vos.DeviceTypeVo;
	import com.tro.chromecast.models.vos.TrackingVo;
	import com.tro.chromecast.views.ViewEvent;
	import com.tro.chromecast.views.components.SwipeControlEvent;
	import com.tro.chromecast.views.connectsectionviews.ChooseDeviceOsView;
	import com.tro.chromecast.views.connectsectionviews.InstallChromeView;

	import org.gestouch.events.GestureEvent;
	
	import com.gamua.flox.Flox;

	public class ChooseDeviceOsViewMediator extends BaseMediator
	{
		[Inject]
		public var view : ChooseDeviceOsView;
		
		[Inject]
		public var appModel : ApplicationModel;;
		
		

		public function ChooseDeviceOsViewMediator()
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

			view.addEventListener(ViewEvent.ON_VIEW_INIT_COMPLETE, onViewInitComplete);
		}

		private function onViewInitComplete(event:ViewEvent):void
		{
			view.androidIcon.tap.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onAndroidTapHandler);
			view.appleIcon.tap.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onAppleTapHandler);
		}

		private function onAppleTapHandler(event:GestureEvent):void
		{
			//logger.debug("onAppleTapHandler");

			var evt : AppEvent = new AppEvent(AppEvent.SET_DEVICE_OS);
			evt.osType = DeviceTypeVo.IOS;
			dispatch(evt);

			nextView();
			
			var trackingVo : TrackingVo = new TrackingVo();
			trackingVo.code = appModel.currentSection.sectionHighlightName + "_SELECT_OS";
			trackingVo.parameter = "OperatingSystem";
			trackingVo.value = DeviceTypeVo.IOS;
			
			var floxEvt : AppEvent = new AppEvent(AppEvent.TRACK_INTERACTION);
			floxEvt.trackingVo = trackingVo;
			dispatch(floxEvt);
		}

		private function onAndroidTapHandler(event:GestureEvent):void
		{
			//logger.debug("onAndroidTapHandler");
			
			var evt : AppEvent = new AppEvent(AppEvent.SET_DEVICE_OS);
			evt.osType = DeviceTypeVo.ANDROID;
			dispatch(evt);
			
			nextView();
			
			var trackingVo : TrackingVo = new TrackingVo();
			trackingVo.code = appModel.currentSection.sectionHighlightName + "_SELECT_OS";
			trackingVo.parameter = "OperatingSystem";
			trackingVo.value = DeviceTypeVo.ANDROID;
			
			var floxEvt : AppEvent = new AppEvent(AppEvent.TRACK_INTERACTION);
			floxEvt.trackingVo = trackingVo;
			dispatch(floxEvt);
		}

	}
}
