/**
 * Created by tro on 14/08/2015.
 */
package com.tro.chromecast.views.components.devicedisplay.videocontrols
{


	import starling.display.Canvas;
	import starling.display.Sprite;

	public class HitArea extends Sprite
	{
		private var _scrubBarCanvas:Canvas;
		private var _scrubBarWidth:Number = 200;
		private var _scrubBarHeight:Number = 5;

		public function HitArea()
		{
			super();

			init();
		}
		private function init():void
		{
			updateDisplayList();
		}
		public function updateDisplayList():void
		{


			_scrubBarCanvas = new Canvas();
			_scrubBarCanvas.beginFill(0x000000, 1);
			_scrubBarCanvas.drawRectangle(0, 0, _scrubBarWidth, _scrubBarHeight);
			_scrubBarCanvas.endFill();

			addChild(_scrubBarCanvas);
		}

		public function set scrubBarWidth(value:Number):void
		{
			if(_scrubBarCanvas != null)
			{
				removeChild(_scrubBarCanvas);
			}
			_scrubBarWidth = value;

			updateDisplayList();
		}


		public function set scrubBarHeight(value:Number):void
		{
			_scrubBarHeight = value;
			updateDisplayList();
		}
	}
}
