/**
 * Created by russellmilburn on 25/09/15.
 */
package com.tro.chromecast.models.augreality
{

	import com.in2ar.IN2AR;

	import flash.display.Loader;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.getTimer;

	public class ARModelSWC extends ARModel implements IARModel
	{
		private var arShell : IN2AR;

		public function ARModelSWC()
		{
			super();
		}

		public function initAugReality() : void
		{
			logger.info("Init AR" + getTimer());
			if (isARRunning)
			{
				return;
			}

			var ldr : Loader = new Loader();
			var loaderContext:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			loaderContext.allowCodeImport = true;

			arShell = new IN2AR(loaderContext);

			arShell.addEventListener(Event.INIT, onARShellInit);
		}

		private function onARShellInit(event:Event):void
		{
			logger.info("Init AR Lib Complete" + getTimer());

			arShell.removeEventListener(Event.INIT, onARShellInit);
			_arLib = arShell.lib;

			start();


		}
	}
}
