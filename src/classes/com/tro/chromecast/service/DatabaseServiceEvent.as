/**
 * Created by mhazelman on 23/07/15.
 */
package com.tro.chromecast.service
{

	import flash.data.SQLResult;
	import flash.events.Event;

public class DatabaseServiceEvent extends Event
{
		public static const ON_CONNECT : String = "onConnect";
		public static const ON_DISCONNECT : String = "onDisconnect";
		public static const ON_DATABASE_RESULT : String = "onDatabaseResult";

		public var isConnected : Boolean;
		public var data : SQLResult;

		public function DatabaseServiceEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}

		override public function clone():Event
		{
			var evt : DatabaseServiceEvent = new DatabaseServiceEvent(type, bubbles, cancelable);
			evt.isConnected  = this.isConnected;
			evt.data  = this.data;
			return evt;
		}
	}
}
