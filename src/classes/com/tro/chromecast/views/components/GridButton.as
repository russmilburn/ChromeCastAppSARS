/**
 * Created by russellmilburn on 22/09/15.
 */
package com.tro.chromecast.views.components
{

	import com.tro.chromecast.models.vos.DoMoreAppVo;
	import com.tro.chromecast.views.components.buttons.ImageButton;
	import org.gestouch.gestures.SwipeGesture;
	import starling.display.Canvas;

	import org.gestouch.events.GestureEvent;

	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.utils.HAlign;

	public class GridButton extends ImageButton
	{
		private var _data:DoMoreAppVo;
		private var _text : TextField;
		private var _icon : Image;
		private var rect:Canvas;
		private var swipe:SwipeGesture;

		public function GridButton()
		{
			super();

			_tap = null;

			_text = new TextField(100,1,"");
			_text.autoSize = TextFieldAutoSize.VERTICAL;
			_text.hAlign = HAlign.CENTER;
			_text.fontName = "Roboto";
			_text.fontSize = 26;
			_text.color = 0x656666;
			_text.touchable = false;

			touchable = true;
			
			
			this.addEventListener(TouchEvent.TOUCH, onTouchHandler);
			
			addSwipe();
		}
		
		private function addSwipe():void
		{
		
			swipe = new SwipeGesture(this);
			swipe.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onSwipeGesture);
		}
		
		private function onSwipeGesture(event : GestureEvent):void
		{

			if (swipe.offsetX > 10)
			{
				dispatchEvent(new SwipeControlEvent(SwipeControlEvent.SWIPE_RIGHT, true));
			}
			else if (swipe.offsetX < -10)
			{
				dispatchEvent(new SwipeControlEvent(SwipeControlEvent.SWIPE_LEFT, true));
			}
		}
		
		private function onTouchHandler(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(this, TouchPhase.ENDED);

			try
			{
				if (touch.getLocation(this) != null)
				{
					var evt : GridButtonEvent = new GridButtonEvent(GridButtonEvent.ON_APP_TAP, true);
					evt.vo = _data;
					evt.location = this.localToGlobal(touch.getLocation(this));
					dispatchEvent(evt);
				}
			}
				catch (error : Error)
			{
				
			}
		}

		
		
		private function onTapHandler(event:GestureEvent):void
		{

		}
		
		
		public function set data(value : DoMoreAppVo) : void
		{
			_data = value;

			updateDisplay();
		}
		
		override protected function updateDisplay():void
		{
			super.updateDisplay();

			if (_data != null)
			{
				_text.width = this.width;
				_text.text = _data.title;

				_icon = new Image(_data.iconTexture);
				_icon.x = (width - _icon.width) / 2;
				_icon.y = 45;

				addChild(_icon);
				addChild(_text);

				_text.y = this.height - _text.height - 35;
			}




		}
	}
}
