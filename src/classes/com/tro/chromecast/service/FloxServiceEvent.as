package com.tro.chromecast.service
{

	import flash.events.Event;

	public class FloxServiceEvent extends Event
	{
			public static const ON_FLOX_SERVICE_INIT_COMPLETE : String = "onFloxServiceInitComplete";
			public static const ON_FLOX_SERVICE_INIT_FAIL : String = "onFloxServiceInitFail";

			public function FloxServiceEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
			{
				super(type, bubbles, cancelable);
			}
	}
}

