/**
 * Created by russellmilburn on 25/09/15.
 */
package com.tro.chromecast.commands
{

	import com.tro.chromecast.models.ApplicationModel;

	public class OpenMenuCommand extends BaseCommand
	{
		[Inject]
		public var appModel : ApplicationModel;

		public function OpenMenuCommand()
		{
			super();
		}


		override public function execute():void
		{
			super.execute();

			appModel.openMenu();
		}
	}
}
