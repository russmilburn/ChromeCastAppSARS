/**
 * Created by russellmilburn on 21/08/15.
 */
package com.tro.chromecast.commands
{

	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.models.ApplicationModel;

	public class SetIsMenuOpenCommand extends BaseCommand
	{
		[Inject]
		public var event : AppEvent;


		[Inject]
		public var appModel : ApplicationModel;

		public function SetIsMenuOpenCommand()
		{
			super();
		}


		override public function execute():void
		{
			super.execute();

			appModel.isMenuOpen = event.isMenuOpen;
		}
	}
}
