/**
 * Created by russellmilburn on 16/09/15.
 */
package com.tro.chromecast.views.components.devicedisplay
{

	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class LargeTablet extends Device
	{
		public function LargeTablet()
		{
			screenSize = new Rectangle(65, 74, 956, 565);
			popUpPosition = new Point(1224, 196);
			super();
		}
	}
}
