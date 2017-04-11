/**
 * Created by russellmilburn on 22/07/15.
 */
package com.tro.chromecast.models.states.section
{

	import com.tro.chromecast.events.*;

	import flash.events.Event;

	public class SectionEvent extends Event
	{
		public static const INIT : String = "init";
		public static const COMPLETE : String = "complete";
		public static const SECTION_END : String = "onSectionEnd";
		public static const SECTION_CONTINUE : String = "onSectionContinue";

		public function SectionEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}


	}
}
