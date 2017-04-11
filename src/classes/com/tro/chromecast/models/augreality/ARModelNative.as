/**
 * Created by russellmilburn on 25/09/15.
 */
package com.tro.chromecast.models.augreality
{

	import com.in2ar.ane.IN2ARNative;

	import flash.utils.getTimer;

	public class ARModelNative extends ARModel implements IARModel
	{
		public function ARModelNative()
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


			_arLib = new IN2ARNative();

			start();

		}
	}
}
