/**
 * Created by russellmilburn on 18/08/15.
 */
package com.tro.chromecast.views.components.devicedisplay.videocontrols
{

	import com.tro.chromecast.views.components.buttons.ImageButton;

	import starling.display.Canvas;

	public class VolumeButton extends ImageButton
	{
		private var bg:Canvas;

		public function VolumeButton()
		{
			super();

			bg = new Canvas();
			bg.beginFill(0xFFFFFF, 0);
			bg.drawRectangle(0, 0, 50, 50);
			bg.endFill();

			addChildAt(bg, 0);
		}

		override protected function updateDisplay() : void
		{
			super.updateDisplay();

			_image.x = (this.width - _image.width) / 2 ;
			_image.y = (this.height - _image.height) / 2;
		}
	}
}
