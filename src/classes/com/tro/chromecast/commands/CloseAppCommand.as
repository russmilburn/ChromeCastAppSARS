/**
 * Created by russellmilburn on 27/07/15.
 */
package com.tro.chromecast.commands
{

	import flash.desktop.NativeApplication;

	public class CloseAppCommand extends BaseCommand
	{
		public function CloseAppCommand()
		{
			super();
		}


		override public function execute():void
		{
			super.execute();

			//NativeApplication.nativeApplication.exit();

			logger.error("AFTER EXIT");
		}
	}
}
