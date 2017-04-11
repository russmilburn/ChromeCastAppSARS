package com.tro.chromecast.models
{
	import air.net.URLMonitor;
	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.models.ApplicationModel;
	import com.tro.chromecast.models.vos.TrackingVo;
	import com.tro.chromecast.service.DatabaseService;
	import com.tro.chromecast.service.DatabaseServiceEvent;
	import flash.data.SQLResult;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.IOErrorEvent;
	import flash.system.Capabilities;
	
	/**
	 * ...
	 * @author Andrew Day
	 */
		
	public class TrackingModel extends AbstractModel
	{
		[Inject]
		public var databaseService:DatabaseService;
		
		private var monitor:URLMonitor;
		
		private var urlRequest:URLRequest;

		private var _isConnected:Boolean;
		private var isInit:Boolean = true;
		
		public function TrackingModel()
		{
			
		}
		
		public function init():void
		{
			urlRequest = new URLRequest("http://www.google.com");
			urlRequest.method = "HEAD";
			
			monitor = new URLMonitor(urlRequest);
			monitor.pollInterval = 1000;
			monitor.addEventListener(StatusEvent.STATUS, checkHTTP);
			monitor.start();
		}
		
		private function checkHTTP(event:StatusEvent):void
		{
			if (monitor.available) 
			{
				isConnected = true;
			} 
			else 
			{
				isConnected = false;
			}
			
			if (isInit)
			{
				var trackingVo : TrackingVo = new TrackingVo();
				trackingVo.code = "OPERATING_SYSTEM";
				trackingVo.parameter = "Device";
				trackingVo.value = Capabilities.os;
				
				var evt:AppEvent = new AppEvent(AppEvent.TRACK_INTERACTION);
				evt.trackingVo = trackingVo;
				dispatch(evt);
				
				isInit = false;
			}
		}
		
		public function get isConnected():Boolean 
		{
			return _isConnected;
		}
		
		public function set isConnected(value:Boolean):void 
		{
			_isConnected = value;
			//logger.info("isConnected" + isConnected);
			if (_isConnected == true && databaseService.isConnected)
			{
				
				//call function get data out db
				getDataFromDB();
				
			}
		}
		
		private function getDataFromDB() : void
		{
			databaseService.eventDispatcher.addEventListener(DatabaseServiceEvent.ON_DATABASE_RESULT, onDatabaseResult);
			
			databaseService.readData(DatabaseService.SESSION_TBL, 
					[DatabaseService.TRACKING_CODE, 
					DatabaseService.TRACKING_PARAMETER, 
					DatabaseService.TRACKING_VALUE]);
		}
		
		private function onDatabaseResult(event:DatabaseServiceEvent):void 
		{
			//logger.info("onDatabaseResult" + event.data);
			
			databaseService.eventDispatcher.removeEventListener(DatabaseServiceEvent.ON_DATABASE_RESULT, onDatabaseResult);
			
			var trackingVo : TrackingVo;
			
			var result:SQLResult = event.data;
			
			
			if (result.data == null)
			{
				return;
			}
			
			var numResults:int = result.data.length; 
			
			for (var i:int = 0; i < numResults; i++) 
			{ 
				var row:Object = result.data[i]; 
				
				trackingVo = new TrackingVo();
				trackingVo.code = row.TrackingCode;
				trackingVo.parameter = row.TrackingParameter;
				trackingVo.value = row.TrackingValue;
			
				logEvent(trackingVo);
			} 
			
		/*	, [ { code:	DatabaseService.SESSION_DATE_FLD, parameter:"Log", value: row.SessionDate},
																									{ code: DatabaseService.SESSION_END_TIME_FLD, parameter: "Log", value: row.SessionEndTime},
																									{ code: DatabaseService.SESSION_START_TIME_FLD, parameter: "Log", value: row.SessionStartTime},
																									{ code: "Session Duration", parameter:"Log", value: row.SessionDuration}]*/
			
			databaseService.deleteData(DatabaseService.SESSION_TBL);
		}
		private function logEvent(vo:TrackingVo):void
		{
			var evt:AppEvent = new AppEvent(AppEvent.TRACK_INTERACTION);
			evt.trackingVo = vo;
			dispatch(evt);
		}
	}
}