/**
 * Created by russellmilburn on 23/07/15.
 */
package com.tro.chromecast.models
{

	import com.tro.chromecast.events.AppEvent;

	public class PinCodeModel extends AbstractModel
	{
		private static const pinCode : Number = 1234;

		public function PinCodeModel()
		{
			super();
		}


		public function checkPinCode(code : Number ) : void
		{
			if (code == pinCode)
			{
				//logger.info("ON_PIN_SUCCESS");
				dispatch(new PinCodeModelEvent(PinCodeModelEvent.ON_PIN_SUCCESS));
				dispatch(new AppEvent(AppEvent.DISPLAY_NAV_MENU));
			}
			else
			{
				//logger.info("ON_PIN_FAIL");
				dispatch(new PinCodeModelEvent(PinCodeModelEvent.ON_PIN_FAIL));
			}
		}
	}
}
