/**
 * Created by tro on 29/07/2015.
 */
package com.tro.chromecast.views
{

	import starling.events.Event;

	public class ARInstructionalViewEvent extends Event
	{
		public static const ON_ANIMATION_START:String = "onAnimationStart";
		public static const ON_ANIMATION_COMPLETE:String = "onAnimationComplete";

		public function ARInstructionalViewEvent(type:String, bubbles:Boolean = false, data:Object = null)
		{
			super(type, bubbles, data);
		}
	}
}
