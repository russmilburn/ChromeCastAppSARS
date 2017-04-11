/**
 * Created by russellmilburn on 16/09/15.
 */
package com.tro.chromecast.views.components.devicedisplay
{

	public class DeviceDisplayZoomed extends DeviceDisplay
	{
		public function DeviceDisplayZoomed()
		{


			laptop = new LargeLaptop();
			laptop.x = 509;
			laptop.y = 119;


			mobile = new LargeMobile();
			mobile.x = 509;
			mobile.y = 101;


			tablet = new LargeTablet();
			tablet.x = 593;
			tablet.y = 101;

			laptop.visible = false;
			mobile.visible = false;
			tablet.visible = false;
		}
	}
}
