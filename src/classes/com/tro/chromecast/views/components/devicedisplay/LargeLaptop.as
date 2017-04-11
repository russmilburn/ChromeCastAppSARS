/**
 * Created by russellmilburn on 16/09/15.
 */
package com.tro.chromecast.views.components.devicedisplay
{

	import flash.geom.Point;
	import flash.geom.Rectangle;


	public class LargeLaptop extends Device
	{
		public function LargeLaptop()
		{
			screenSize = new Rectangle(191, 80, 956, 544);
			popUpPosition = new Point(1232, 196);
			super();
		}
	}
}
