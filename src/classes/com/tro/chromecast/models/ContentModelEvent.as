/**
 * Created by russellmilburn on 20/08/15.
 */
package com.tro.chromecast.models
{

	import flash.events.Event;

	public class ContentModelEvent extends Event
	{
		public static const ON_UPDATE_CAST_APP_VO : String = "onUpdateCastAppVo";

		public function ContentModelEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
