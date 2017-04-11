/**
 * Created by russellmilburn on 12/08/15.
 */
package com.tro.chromecast.views.components
{

	import starling.events.Event;

	public class PopUpMagnifierEvent extends Event
	{
		public static const ON_BUTTON_TAP : String =  "onButtonTap";

		public function PopUpMagnifierEvent(type:String, bubbles:Boolean = false, data:Object = null)
		{
			super(type, bubbles, data);
		}
	}
}
