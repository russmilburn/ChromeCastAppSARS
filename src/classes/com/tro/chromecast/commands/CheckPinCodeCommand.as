/**
 * Created by russellmilburn on 24/07/15.
 */
package com.tro.chromecast.commands
{

	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.models.PinCodeModel;

	public class CheckPinCodeCommand extends BaseCommand
	{
		[Inject]
		public var event : AppEvent;

		[Inject]
		public var pinCodeModel  : PinCodeModel;

		public function CheckPinCodeCommand()
		{
			super();
		}


		override public function execute():void
		{
			super.execute();

			pinCodeModel.checkPinCode(event.picCode);


		}
	}
}
