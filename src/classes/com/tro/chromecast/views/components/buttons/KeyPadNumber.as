/**
 * Created by russellmilburn on 24/07/15.
 */
package com.tro.chromecast.views.components.buttons
{

	import com.tro.chromecast.views.LoginViewEvent;

	import org.gestouch.events.GestureEvent;
	import org.gestouch.gestures.TapGesture;

	import starling.display.Canvas;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;

	public class KeyPadNumber extends Sprite
	{
		private var label : TextField;
		private var bg : Canvas;
		private var tapGesture:TapGesture;

		public function KeyPadNumber()
		{
			super();

			_init();
		}

		private function _init():void
		{
			bg = new Canvas();

			label = new TextField(100, 100, "", "Roboto", 60, 0x8a8a8a, false );
			label.autoSize = TextFieldAutoSize.HORIZONTAL;

			bg.beginFill(0xFFFFFF, 1);
			bg.drawRectangle(0, 0, 100, 100);

			addChild(bg);
			addChild(label);

			tapGesture = new TapGesture(this);
			enable();
		}
		public function disable():void
		{
			tapGesture.removeEventListener(GestureEvent.GESTURE_RECOGNIZED, onTouchHandler);
		}
		public function enable():void
		{
			tapGesture.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onTouchHandler);
		}
		private function onTouchHandler(event:GestureEvent):void
		{
			 var evt:LoginViewEvent = new LoginViewEvent(LoginViewEvent.KEY_PRESSED);
			 evt.value = getLabelText();
			 dispatchEvent(evt);
		}
		public function setLabelText(value : String) : void
		{
			label.text = value;
			label.x = bg.width/2 - label.width/2;
			bg.clear();

			bg.beginFill(0xFFFFFFFF, 1);
			bg.drawRectangle(0, 0, 100, 100);
		}

		public function getLabelText():String
		{
			return label.text;
		}
	}
}
