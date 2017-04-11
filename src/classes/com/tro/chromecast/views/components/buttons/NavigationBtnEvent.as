/**
 * Created by russellmilburn on 29/07/15.
 */
package com.tro.chromecast.views.components.buttons
{

	import com.tro.chromecast.models.vos.NavigationBtnVo;

	import starling.events.Event;

	public class NavigationBtnEvent extends Event
	{
		public static const ON_TAP : String = "onTap";
		public static const SWIPE_RIGHT : String = "SWIPE_RIGHT";
		public static const OPEN_MENU : String = "OPEN_MENU";

		public var vo : NavigationBtnVo;

		public function NavigationBtnEvent(type:String, bubbles:Boolean = false, data:Object = null)
		{
			super(type, bubbles, data);
		}
	}
}
