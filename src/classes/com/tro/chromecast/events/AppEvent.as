/**
 * Created by russellmilburn on 22/07/15.
 */
package com.tro.chromecast.events
{

	import com.tro.chromecast.models.vos.CastAppsVo;
	import com.tro.chromecast.models.vos.TrackingVo;

	import flash.events.Event;

	public class AppEvent extends Event
	{
		public static const START_UP : String = "startUp";
		public static const CHECK_PIN_CODE : String = "checkPinCode";
		public static const ON_CLOSE_APP:String = "onCloseApp";
		public static const UPDATE_SECTION:String = "updateSection";
		
		public static const SWIPE_LEFT:String = "swipeLeft";
		public static const SWIPE_RIGHT:String = "swipeRight";
		public static const INIT_AUG_REALTY:String = "initAugReality";
		public static const DESTROY_AUG_REALTY:String = "destroyAugReality";
		
		public static const DISPLAY_USER_FEEDBACK_VIEW:String = "displayUserFeedbackView";
		public static const HIDE_USER_FEEDBACK_VIEW:String = "hideUserFeedbackView";
		
		public static const LOAD_ASSET_LIB:String = "loadFonts";
		public static const INIT_VIEWS:String = "initViews";
		public static const INIT_MAIN_MENU:String = "initMainMenu";
		public static const START_VIEW_INIT:String = "startInitViews";
		public static const START_UP_COMPLETE:String = "StartUpComplete";
		
		public static const SET_DEVICE_TYPE:String = "setDeviceType";
		public static const SET_CAST_APP_VO:String = "setCastAppVo";
		public static const SET_IS_MENU_OPEN:String = "setIsMenuOpen";
		public static const CAST_IN_AR:String = "castInAr";
		public static const DISPLAY_NAV_MENU:String = "displayNavMenu";
		public static const HIDE_NAV_MENU:String = "hideNavMenu";

		public static const OPEN_NAV_MENU:String = "openNavMenu";
		public static const CLOSE_NAV_MENU:String = "closeNavMenu";

		public static const SET_DEVICE_OS:String = "setDeviceOS";
		public static const INIT_FLOX:String = "initFlox";
		public static const INIT_FLOX_COMPLETE:String = "initFloxComplete";
		public static const INIT_DATABASE:String = "initDatabase";
		public static const INIT_DATABASE_COMPLETE:String = "initDatabaseComplete";



		
		public static const TRACK_INTERACTION:String = "trackInteraction";
		
		public var picCode : Number;
		public var sectionName : String;
		public var deviceType : String;
		public var castAppVo : CastAppsVo;
		public var isMenuOpen : Boolean;
		public var osType : String;
		public var trackingVo : TrackingVo;
		
		public function AppEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var evt : AppEvent  = new AppEvent(type, bubbles, cancelable);
			evt.picCode = this.picCode;
			evt.sectionName = this.sectionName;
			evt.deviceType = this.deviceType;
			evt.castAppVo = this.castAppVo;
			evt.isMenuOpen = this.isMenuOpen;
			evt.osType = this.osType;
			evt.trackingVo = this.trackingVo;
			return evt;
		}
	}
}
