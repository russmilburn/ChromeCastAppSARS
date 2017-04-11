/**
 * Created by russellmilburn on 24/07/15.
 */
package com.tro.chromecast.models
{

	import flash.events.Event;

	public class PinCodeModelEvent extends Event
	{
		public static const ON_PIN_SUCCESS : String = "onPinSuccess";
		public static const ON_PIN_FAIL : String = "onPinFail";

		public function PinCodeModelEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}


		override public function clone():Event
		{
			var evt : PinCodeModelEvent = new PinCodeModelEvent(type, bubbles, cancelable);
			return evt;
		}
	}
}
