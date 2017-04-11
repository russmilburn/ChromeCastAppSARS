/**
 * Created by russellmilburn on 30/07/15.
 */
package com.tro.chromecast.commands
{

	import com.tro.chromecast.models.ApplicationModel;

	public class PrevViewCommand extends BaseCommand
	{
		[Inject]
		public var appModel : ApplicationModel;


		public function PrevViewCommand()
		{
			super();
		}


		override public function execute():void
		{
			super.execute();

			appModel.prevView();
		}
	}
}
