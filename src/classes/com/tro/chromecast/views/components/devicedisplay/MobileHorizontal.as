/**
 * Created by russellmilburn on 11/08/15.
 */
package com.tro.chromecast.views.components.devicedisplay
{

	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class MobileHorizontal extends Device
	{
		public function MobileHorizontal()
		{
			screenSize = new Rectangle(96, 17, 419, 262);
			popUpPosition = new Point(943, 309);
			super();
		}
	}
}
