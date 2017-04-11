/**
 * Created by russellmilburn on 04/08/15.
 */
package com.tro.chromecast.commands
{

	import com.tro.chromecast.models.ApplicationModel;

	public class InitMainMenuCommand extends BaseCommand
	{
		[Inject]
		public var appModel : ApplicationModel;

		public function InitMainMenuCommand()
		{
			super();
		}


		override public function execute():void
		{
			super.execute();

			appModel.setupMenu();
		}
	}
}
