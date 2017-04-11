package com.tro.chromecast.commands.startup 
{
	import com.tro.chromecast.commands.BaseCommand;
	import com.tro.chromecast.service.FloxService;
	/**
	 * ...
	 * @author Andrew Day
	 */
	public class FloxInitCommand extends BaseCommand
	{
		[Inject]
		public var floxInitialisation:FloxService;
		
		public function FloxInitCommand() 
		{
			
		}
		
		override public function execute():void 
		{
			super.execute();
			
			logger.info("[START UP 2]: INIT FLOX");
			
			floxInitialisation.init();
		}
		
	}

}