/**
 * Created by russellmilburn on 31/08/15.
 */
package com.tro.chromecast.views.components.devicedisplay
{

	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class MobileVertical extends Device
	{
		public function MobileVertical()
		{
			screenSize = new Rectangle(17, 96, 262, 419);
			popUpPosition = new Point(993, 259);
			super();
		}
	}
}
