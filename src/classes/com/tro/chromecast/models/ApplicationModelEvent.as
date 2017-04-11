/**
 * Created by russellmilburn on 30/07/15.
 */
package com.tro.chromecast.models
{

	import flash.events.Event;

	public class ApplicationModelEvent extends Event
	{
		public static const ON_PREPARE_INCOMING_VIEW : String = "onPrepareIncomingView";
		public static const ON_PREPARE_OUTGOING_VIEW : String = "onPrepareOutgoingView";
		public static const ON_PREPARE_AUG_REALITY_VIEW : String = "onPrepareAugRealityView";
		public static const ON_DISPOSE_AUG_REALITY_VIEW : String = "onDisposeAugRealityView";

		public static const ON_SETUP_NAVIGATION : String = "onSetupNavigation";
		public static const ON_SETUP_DO_MORE_MENU : String = "onSetupDoMoreMenu";
		public static const ON_UPDATE_DEVICE : String = "onUpdateDevice";
		public static const ON_SECTION_SELECTED : String = "onSectionSelected";
		public static const ON_UPDATE_SECTION : String = "onUpdateSecion";

		public static const OPEN_MENU : String = "openMenu";
		public static const CLOSE_MENU : String = "closeMenu";

		public var viewName : String;
		public var direction : String;
		public var device : String;
		public var selectedSection : String;

		public function ApplicationModelEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}


		override public function clone():Event
		{
			var evt : ApplicationModelEvent = new ApplicationModelEvent(type, bubbles, cancelable);
			evt.viewName = this.viewName;
			evt.direction = this.direction;
			evt.device = this.device;
			evt.selectedSection = this.selectedSection;
			return evt;
		}
	}
}
