/**
 * Created by tro on 10/08/2015.
 */
package com.tro.chromecast.views.components.devicedisplay.videocontrols
{

	import starling.events.Event;

	public class VideoControlPanelEvent extends Event
	{
		public static const ON_PLAY_BTN_TAP : String = "onPlayBtnTap";
		public static const ON_PAUSE_BTN_TAP : String = "onPauseBtnTap";

		public static const ON_SCRUB_START : String = "onScrubStart";
		public static const ON_SCRUB : String = "onScrub";
		public static const ON_SCRUB_END : String = "onScrubEnd";

		public static const ON_VOLUME_UP : String = "onVolumeUp";
		public static const ON_VOLUME_DOWN : String = "onVolumeDown";

		public var scrubPos:Number;
		public var volumeLevel : Number;

		public function VideoControlPanelEvent(type:String, bubbles:Boolean = false, data:Object = null)
		{
			super(type, bubbles, data);
		}


	}
}
