/**
 * Created by russellmilburn on 27/07/15.
 */
package com.tro.chromecast.models
{

	import flash.events.Event;
	import flash.sampler.StackFrame;

	public class StageModelEvent extends Event
	{
		public static const ON_UPDATE_STAGE_SIZE : String = "onUpdateStageSize";
		public static const ON_UPDATE_STAGE_WIDTH : String = "onUpdateStageWidth";
		public static const ON_UPDATE_STAGE_HEIGHT : String = "onUpdateStageHeight";

		public var stageWidth : Number;
		public var stageHeight : Number;


		public function StageModelEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}


		override public function clone():Event
		{
			var evt : StageModelEvent = new StageModelEvent(type, bubbles, cancelable);
			evt.stageWidth = this.stageWidth;
			evt.stageHeight = this.stageHeight;
			return evt;
		}
	}
}
