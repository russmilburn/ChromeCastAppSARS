/**
 * Created by russellmilburn on 23/09/15.
 */
package com.tro.chromecast.views.components
{

	import com.tro.chromecast.models.vos.DoMoreAppVo;

	import flash.geom.Point;

	import starling.events.Event;

	public class GridButtonEvent extends Event
	{
		public static const ON_APP_TAP : String = "onAppTap";

		public var vo : DoMoreAppVo;
		public var location : Point;

		public function GridButtonEvent(type:String, bubbles:Boolean = false, data:Object = null)
		{
			super(type, bubbles, data);
		}
	}
}
