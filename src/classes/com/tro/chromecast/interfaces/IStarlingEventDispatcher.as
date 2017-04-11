/**
 * Created by russellmilburn on 31/07/15.
 */
package com.tro.chromecast.interfaces
{

	import starling.events.Event;

	public interface IStarlingEventDispatcher
	{
		function addEventListener(type:String,listener:Function):void;
		function removeEventListener(type:String,listener:Function):void;
		function dispatchEvent(event:Event):void;
	}
}
