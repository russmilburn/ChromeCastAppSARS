/**
 * Created by russellmilburn on 11/08/15.
 */
package com.tro.chromecast.views.components.devicedisplay
{

	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Laptop extends Device
	{
		public function Laptop()
		{
			screenSize = new Rectangle(141, 59, 700, 400);
			popUpPosition = new Point(1168, 259);
			super();
		}


	}
}
