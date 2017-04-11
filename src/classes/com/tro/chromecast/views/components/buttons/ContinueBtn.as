/**
 * Created by russellmilburn on 02/09/15.
 */
package com.tro.chromecast.views.components.buttons
{

	import org.gestouch.events.GestureEvent;
	import org.gestouch.gestures.TapGesture;

	public class ContinueBtn extends NavigationBtn
	{
		public function ContinueBtn()
		{
			super();
			labelColour = VISITED_TEXT_COLOUR;
		}

		override protected function updateDisplayList():void
		{
			super.updateDisplayList();

			label.x = 0;
			label.height = 60;
			label.fontSize = 50;
			background.height = 120;

			background.width = label.width;

		}

		override public function enable() : void
		{
			tap = new TapGesture(this);
			tap.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onTapHandler);
		}

	}
}
