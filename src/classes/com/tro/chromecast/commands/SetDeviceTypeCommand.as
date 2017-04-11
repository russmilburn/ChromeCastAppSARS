/**
 * Created by russellmilburn on 11/08/15.
 */
package com.tro.chromecast.commands
{

	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.models.ApplicationModel;

	public class SetDeviceTypeCommand extends BaseCommand
	{
		[Inject]
		public var appModel : ApplicationModel;


		[Inject]
		public var event : AppEvent;

		public function SetDeviceTypeCommand()
		{
			super();
		}


		override public function execute():void
		{
			super.execute();

			appModel.selectedDevice = event.deviceType;
		}
	}
}
