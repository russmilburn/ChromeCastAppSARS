/**
 * Created by russellmilburn on 01/09/15.
 */
package com.tro.chromecast.views.components.buttons
{

	import com.tro.chromecast.views.components.*;


	import org.gestouch.events.GestureEvent;
	import org.gestouch.gestures.TapGesture;

	import starling.display.Canvas;

	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;

	public class MenuBtn extends Sprite
	{
		public var background:Canvas;
		public var label : TextField;

		private var tap : TapGesture;


		public function MenuBtn()
		{
			super();

			updateDisplayList();
		}

		private function updateDisplayList():void
		{
			if (label != null)
			{
				removeChild(label);
			}

			label = new TextField(100, 50, "MENU");
			label.x = 48;
			label.fontName = "Roboto";
			label.fontSize = 36;
			label.autoSize = TextFieldAutoSize.HORIZONTAL;
			label.color = 0x656666;

			if (background != null)
			{
				removeChild(background);
			}

			background = new Canvas();
			background.beginFill(0xffffff, 0);
			background.drawRectangle(0, 0, 275, 138);

			label.y = (background.height - label.height) / 2;

			addChild(background);
			addChild(label);
		}


		public function enable() : void
		{
			tap = new TapGesture(this);
			tap.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onTapHandler);

		}

		public function disable() : void
		{
			tap.removeEventListener(GestureEvent.GESTURE_RECOGNIZED, onTapHandler);
			tap = null;
		}

		private function onTapHandler(event:GestureEvent):void
		{
			var evt : NavigationBtnEvent = new NavigationBtnEvent(NavigationBtnEvent.OPEN_MENU, true);
			dispatchEvent(evt);
		}

	}
}
