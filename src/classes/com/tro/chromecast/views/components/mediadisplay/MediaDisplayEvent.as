/**
 * Created by russellmilburn on 19/08/15.
 */
package com.tro.chromecast.views.components.mediadisplay
{

	import starling.events.Event;

	public class MediaDisplayEvent extends Event
	{
		public static const ON_VIDEO_PLAYER_INIT : String = "onVideoPlayerInit";
		public static const ON_VIDEO_PLAYHEAD_TIME_CHANGE : String = "onVideoPlaying";
		public static const ON_VIDEO_START : String = "onVideoStart";
		public static const ON_VIDEO_COMPLETE : String = "onVideoComplete";
		public static const ON_BUFFER_EMPTY : String = "onBufferEmpty";
		public static const ON_PLAY : String = "onPlay";
		public static const ON_PAUSE : String = "onPause";

		public var totalTime: Number;
		public var playheadTime : Number;

		public function MediaDisplayEvent(type:String, bubbles:Boolean = false, data:Object = null)
		{
			super(type, bubbles, data);
		}
	}
}
