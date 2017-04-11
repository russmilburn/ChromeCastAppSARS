package com.tro.chromecast.commands.startup 
{
	import com.tro.chromecast.commands.BaseCommand;
	import com.tro.chromecast.service.DatabaseService;
	
	/**
	 * ...
	 * @author Andrew Day
	 */
	public class InitDatabaseCommand extends BaseCommand 
	{
		[Inject]
		public var databaseService : DatabaseService;
		
		public function InitDatabaseCommand() 
		{
			super();
			
		}
		
		override public function execute():void
		{
			super.execute();
			
			logger.info("[START UP 1]: init Database service");
			
			databaseService.connect();
		}
		
	}

}