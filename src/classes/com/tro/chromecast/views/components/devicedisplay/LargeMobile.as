/**
 * Created by russellmilburn on 16/09/15.
 */
package com.tro.chromecast.views.components.devicedisplay
{

	public class LargeMobile extends Device
	{
		import flash.geom.Point;
		import flash.geom.Rectangle;

		public function LargeMobile()
		{
			screenSize = new Rectangle(221, 38, 956, 600);
			popUpPosition = new Point(1224, 196);
			super();
		}
	}
}
