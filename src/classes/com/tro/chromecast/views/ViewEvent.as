/**
 * Created by russellmilburn on 29/07/15.
 */
package com.tro.chromecast.views
{

	import starling.events.Event;

	public class ViewEvent extends Event
	{
		public static const ON_VIEW_INIT_COMPLETE : String = "onViewInitComplete";
		public static const ON_VIEW_IN_COMPLETE : String = "onViewInComplete";
		public static const ON_VIEW_OUT_COMPLETE : String = "onViewOutComplete";
		public static const ON_PREPARE_VIEW_IN : String = "onPrepareViewIn";

		public function ViewEvent(type:String, bubbles:Boolean = false, data:Object = null)
		{
			super(type, bubbles, data);
		}
	}
}
