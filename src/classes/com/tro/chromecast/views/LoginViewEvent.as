/**
 * Created by tro on 29/07/2015.
 */
package com.tro.chromecast.views
{

	import starling.events.Event;


	public class LoginViewEvent extends Event
	{
		public static const KEY_PRESSED : String = "keyPressed";
		public static const BACK_BUTTON_PRESSED:String = "onBackButton";

		public var value : String;

		public function LoginViewEvent(type:String, bubbles:Boolean = true,  data:Object = null)
		{
			super(type, bubbles, data);
		}
	}
}
