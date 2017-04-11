/**
 * Created by russellmilburn on 23/09/15.
 */
package com.tro.chromecast.views.components.tabs
{

	import com.tro.chromecast.views.components.SwipeControlEvent;
	import org.gestouch.events.GestureEvent;
	import org.gestouch.gestures.SwipeGesture;
	import org.gestouch.gestures.TapGesture;

	import starling.display.Canvas;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.utils.HAlign;

	public class TabMenuToggleButton extends Sprite
	{
		private var _label : TextField;
		private var _background : Canvas;
		private var _highlight : Canvas;
		private var _isSelected : Boolean;
		private var tap:TapGesture;
		private var swipe:SwipeGesture;

		public function TabMenuToggleButton()
		{
			super();

			_background = new Canvas();
			_background.beginFill(0xffffff, 1);
			_background.drawRectangle(0,0, 537, 77);
			_background.endFill();
			_background.x = 2;
			//_background.touchable = false;

			_label = new TextField(300, 1, "");
			_label.touchable = false;
			_label.autoSize = TextFieldAutoSize.VERTICAL;
			_label.hAlign = HAlign.CENTER;
			_label.fontName = "Roboto";
			_label.fontSize = 50;
			_label.color = 0x898989;

			_highlight = new Canvas();
			_highlight.beginFill(0x3369e8, 1);
			_highlight.drawRectangle(0, 0, 537, 8);
			_highlight.endFill();
			//_highlight.touchable = false;

			tap = new TapGesture(this);
			tap.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onTapHandler);
			
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
		
		private function onTapHandler(event:GestureEvent):void
		{
			var evt : TabMenuEvent = new TabMenuEvent(TabMenuEvent.ON_TAB_MENU_TAP, true);
			evt.id = _label.text;
			dispatchEvent(evt);
		}

		public function setLabelText(value : String) : void
		{
			_label.text = value;
			updateDisplayList();
		}


		public function get isSelected():Boolean
		{
			return _isSelected;
		}

		public function set isSelected(value:Boolean):void
		{
			_isSelected = value;

			updateDisplayList();
		}

		protected function updateDisplayList() : void
		{
			if (_background != null)
			{
				removeChild(_background);
			}

			addChild(_background);

			if (_highlight != null)
			{
				removeChild(_highlight);
			}
			addChild(_highlight);

			if (isSelected)
			{
				_highlight.visible = true;
			}
			else
			{
				_highlight.visible = false;
			}

			_label.x = (width - _label.width) / 2;
			_label.y = (height - _label.height) / 2;

			if (_label != null)
			{
				removeChild(_label);
			}
			addChild(_label);

			_highlight.x = 0;
			_highlight.y = 75 - _highlight.height;
		}
	}
}
