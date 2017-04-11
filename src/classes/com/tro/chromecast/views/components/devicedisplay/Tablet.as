/**
 * Created by russellmilburn on 11/08/15.
 */
package com.tro.chromecast.views.components.devicedisplay
{

	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Tablet extends Device
	{
		public function Tablet()
		{
			screenSize = new Rectangle(44, 50, 648, 383);
			popUpPosition = new Point(1134, 259);
			super();
		}
	}
}
