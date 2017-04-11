package com.tro.chromecast.commands 
{

	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.models.ApplicationModel;
	import com.tro.chromecast.models.TrackingModel;
	import com.tro.chromecast.service.DatabaseService;
	import com.tro.chromecast.service.FloxService;

	/**
	 * ...
	 * @author Andrew Day
	 */
	public class TrackInteractionCommand extends BaseCommand
	{
		[Inject]
		public var appModel : ApplicationModel;
		
		[Inject]
		public var databaseService : DatabaseService;
		
		[Inject]
		public var floxService : FloxService;
		
		[Inject]
		public var appEvent : AppEvent;
		
		[Inject]
		public var trackingModel : TrackingModel;

		
		public function TrackInteractionCommand() 
		{
		
		}
		
		override public function execute():void 
		{
			super.execute();
			
			if (trackingModel.isConnected)
			{
				floxService.logEvent(appEvent.trackingVo);
				//logger.info("THROUGH FLOX");
			} else {
				//logger.info("THROUGH DATABASE");
					var date:Date = new Date();
					
					databaseService.insertData(DatabaseService.SESSION_TBL,
						[DatabaseService.TRACKING_CODE,
						DatabaseService.TRACKING_PARAMETER,
						DatabaseService.TRACKING_VALUE],
					
					[	appEvent.trackingVo.code,
						appEvent.trackingVo.parameter,
						appEvent.trackingVo.value]);
			}
		}
	}
}