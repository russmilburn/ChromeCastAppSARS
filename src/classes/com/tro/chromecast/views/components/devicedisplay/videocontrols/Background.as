/**
 * Created by tro on 14/08/2015.
 */
package com.tro.chromecast.views.components.devicedisplay.videocontrols
{

	import starling.display.Canvas;
	import starling.display.Sprite;

	public class Background extends Sprite
	{
		private var _backgroundCanvas:Canvas;
		private var _backgroundWidth:Number = 1;
		private var _backgroundHeight:Number = 50;
		private var _backgroundColor:uint = 0xFFFFFF;
		private var _backgroundAlpha:Number = 0.5;

		public function Background()
		{
			super();

			init();
		}

		private function init():void
		{
			updateDisplayList();
		}
		private function updateDisplayList():void
		{
			if(_backgroundCanvas != null)
			{
				removeChild(_backgroundCanvas);
			}

			_backgroundCanvas = new Canvas();
			_backgroundCanvas.beginFill(_backgroundColor, _backgroundAlpha);
			_backgroundCanvas.drawRectangle(0, 0, _backgroundWidth, _backgroundHeight);
			_backgroundCanvas.endFill();
			addChild(_backgroundCanvas);
		}


		public function set backgroundWidth(value:Number):void
		{
			_backgroundWidth = value;
			updateDisplayList();
		}

	}
}
