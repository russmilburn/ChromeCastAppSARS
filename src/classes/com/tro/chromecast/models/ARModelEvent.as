/**
 * Created by russellmilburn on 22/07/15.
 */
package com.tro.chromecast.models
{


	import com.in2ar.detect.IN2ARReference;

	import flash.events.Event;

	public class ARModelEvent extends Event
	{
		public static const ON_INIT_AUG_REALITY : String = "onInitAugReality";
		public static const ON_DESTROY_AUG_REALITY : String = "onDestroyAugReality";
		public static const ON_MARKER_DETECTED : String = "onMarkerDetected";
		public static const ON_MARKER_LOST : String = "onMarkerLost";
		public static const ON_MARKER_UPDATE : String = "onMarkerUpdate";

		public var refList:Vector.<IN2ARReference>;
		public var ref:IN2ARReference;
		public var refCount:int;

		public function ARModelEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}


		override public function clone():Event
		{
			var evt : ARModelEvent = new ARModelEvent(type, bubbles, cancelable);
			evt.ref = this.ref;
			evt.refList = this.refList;
			evt.refCount = this.refCount;
			return evt;
		}
	}
}
