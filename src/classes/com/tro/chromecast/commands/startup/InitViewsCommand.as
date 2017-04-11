/**
 * Created by russellmilburn on 06/08/15.
 */
package com.tro.chromecast.commands.startup
{

	import com.tro.chromecast.commands.BaseCommand;
	import com.tro.chromecast.events.AppEvent;

	public class InitViewsCommand extends BaseCommand
	{
		public function InitViewsCommand()
		{
			super();
		}


		override public function execute():void
		{
			super.execute();

			logger.info("[START UP 8]: INIT Views");
			dispatch(new AppEvent(AppEvent.START_VIEW_INIT));
		}
	}
}
