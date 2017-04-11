/**
 * Created by russellmilburn on 28/07/15.
 */
package com.tro.chromecast.views.components
{

	import starling.events.Event;


	public class SwipeControlEvent extends Event
	{
		public static const SWIPE_RIGHT : String = "SWIPE_RIGHT";
		public static const SWIPE_LEFT : String = "SWIPE_LEFT";
		public static const ON_TAP : String = "ON_TAP";

		public function SwipeControlEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
