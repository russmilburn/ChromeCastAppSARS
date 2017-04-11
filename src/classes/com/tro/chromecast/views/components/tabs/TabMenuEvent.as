/**
 * Created by russellmilburn on 23/09/15.
 */
package com.tro.chromecast.views.components.tabs
{

	import starling.events.Event;

	public class TabMenuEvent extends Event
	{
		public static const ON_TAB_MENU_TAP : String = "onTabMenuTap";

		public var id : String;

		public function TabMenuEvent(type:String, bubbles:Boolean = false, data:Object = null)
		{
			super(type, bubbles, data);
		}
	}
}
