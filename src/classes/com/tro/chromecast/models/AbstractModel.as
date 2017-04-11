/**
 * Created by russellmilburn on 20/07/15.
 */
package com.tro.chromecast.models {

	import flash.events.Event;
	import flash.events.IEventDispatcher;

	import org.swiftsuspenders.Injector;

	import robotlegs.bender.framework.api.ILogger;

	public class AbstractModel
	{
		[Inject]
		public var logger : ILogger;

		[Inject]
		public var injector : Injector;

		[Inject]
		public var eventDispatcher:IEventDispatcher;

		public function AbstractModel()
		{

		}

		protected function dispatch(event:Event):void
		{
			if(eventDispatcher.hasEventListener(event.type))
				eventDispatcher.dispatchEvent(event);
		}
	}
}
