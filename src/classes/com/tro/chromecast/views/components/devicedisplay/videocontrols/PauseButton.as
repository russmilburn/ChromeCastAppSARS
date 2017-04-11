/**
 * Created by russellmilburn on 18/08/15.
 */
package com.tro.chromecast.views.components.devicedisplay.videocontrols
{

	import org.gestouch.gestures.TapGesture;

	import starling.display.Canvas;
	import starling.display.Sprite;

	public class PauseButton extends Sprite
	{
		private var bg:Canvas;
		private var pauseBarA:Canvas;
		private var pauseBarB:Canvas;

		private var _pauseButtonColor:uint = 0xFFFFFF;
		private var _pauseButtonAlpha:Number = 1;

		private var _pauseBarWidth:Number = 10;
		private var _pauseBarHeight:Number = 30;

		private var _iconContainer : Sprite;
		public var tap : TapGesture;


		public function PauseButton()
		{
			super();

			tap = new TapGesture(this);

			bg = new Canvas();
			bg.beginFill(0xFFFFFF, 0);
			bg.drawRectangle(0, 0, 50, 50);
			bg.endFill();

			_iconContainer = new Sprite();

			pauseBarA = new Canvas();
			pauseBarA.beginFill(_pauseButtonColor, _pauseButtonAlpha);
			pauseBarA.drawRectangle(0, 0, _pauseBarWidth, _pauseBarHeight);
			pauseBarA.endFill();

			pauseBarB = new Canvas();
			pauseBarB.beginFill(_pauseButtonColor, _pauseButtonAlpha);
			pauseBarB.drawRectangle(15, 0, _pauseBarWidth, _pauseBarHeight);
			pauseBarB.endFill();


			addChild(bg);
			_iconContainer.addChild(pauseBarA);
			_iconContainer.addChild(pauseBarB);
			addChild(_iconContainer);



			updateDisplay();
		}


		protected function updateDisplay() : void
		{

			_iconContainer.x = (this.width - _iconContainer.width) / 2 ;
			_iconContainer.y = (this.height - _iconContainer.height) / 2;
		}
	}
}
