/**
 * Created by russellmilburn on 29/07/15.
 */
package com.tro.chromecast.views.components.buttons
{

	import com.tro.chromecast.views.components.*;

	import com.tro.chromecast.models.vos.NavigationBtnVo;

	import org.gestouch.events.GestureEvent;
	import org.gestouch.gestures.SwipeGesture;

	import org.gestouch.gestures.TapGesture;

	import starling.display.Canvas;

	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.filters.BlurFilter;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;

	public class NavigationBtn extends Sprite
	{

		protected static const VISITED_TEXT_COLOUR : uint = 0x3369E8;
		protected static const SELECTED_TEXT_COLOUR : uint = 0xFFFFFF;
		protected static const DEFAULT_TEXT_COLOUR : uint = 0x656666;

		protected static const BG_SELECTED_COLOUR : uint = 0x3369E8;
		protected static const BG_DEFAULT_COLOUR : uint = 0xFFFFFF;

		private var _data: NavigationBtnVo;

		public var background:Canvas;
		public var label : TextField;

		protected var tap : TapGesture;
		private var swipe : SwipeGesture;
		private var bgColour : uint;
		protected var labelColour : uint;
		private var _isSelected:Boolean;
		private var _hasVisited:Boolean;

		public function NavigationBtn()
		{
			super();

			labelColour = DEFAULT_TEXT_COLOUR;
			bgColour = BG_DEFAULT_COLOUR;
		}

		public function get data():NavigationBtnVo
		{
			return _data;
		}

		public function set data(value:NavigationBtnVo):void
		{
			_data = value;

			updateDisplayList();
		}

		public function enable() : void
		{
			tap = new TapGesture(this);
			tap.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onTapHandler);

			swipe = new SwipeGesture(this);
			swipe.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onSwipeHandler);
		}



		protected function onTapHandler(event:GestureEvent):void
		{
			var evt : NavigationBtnEvent = new NavigationBtnEvent(NavigationBtnEvent.ON_TAP, true);
			evt.vo = this.data;
			dispatchEvent(evt);
		}


		private function onSwipeHandler(event:GestureEvent):void
		{
			if (swipe.offsetX > 10)
			{
				dispatchEvent(new NavigationBtnEvent(NavigationBtnEvent.SWIPE_RIGHT, true));
			}
		}


		public function disable() : void
		{
			tap.removeEventListener(GestureEvent.GESTURE_RECOGNIZED, onTapHandler);
			tap = null;
		}

		protected function updateDisplayList():void
		{
			if (label != null)
			{
				removeChild(label);
			}

			label = new TextField(100, 50, data.label);
			label.x = 48;
			label.fontName = "Roboto";
			label.fontSize = 36;
			label.autoSize = TextFieldAutoSize.HORIZONTAL;
			label.color = labelColour;

			if (background != null)
			{
				removeChild(background);
			}

			background = new Canvas();
			background.beginFill(bgColour, 1);
			background.drawRectangle(0, 0, 375, 100);

			if (isSelected)
			{
				background.filter = BlurFilter.createDropShadow(4, 0.90, 0x000000, 0.4, 0.5, 0.5);
			}

			label.y = (background.height - label.height) / 2;

			addChild(background);
			addChild(label);
		}

		public function set isSelected(value : Boolean) : void
		{
			_isSelected = value;
			updateColours();
		}

		public function get isSelected() : Boolean
		{
			return _isSelected;
		}

		public function set hasVisited(value : Boolean) : void
		{
			//_hasVisited = value;
			_hasVisited = false;
			updateColours();
		}

		public function get hasVisited() : Boolean
		{
			return _isSelected;
		}

		private function updateColours() : void
		{
			if (isSelected)
			{
				bgColour = BG_SELECTED_COLOUR;
				labelColour = SELECTED_TEXT_COLOUR;


			}
			else
			{
				bgColour = BG_DEFAULT_COLOUR;

				if (hasVisited)
				{
					labelColour = VISITED_TEXT_COLOUR;
				}
				else
				{
					labelColour = DEFAULT_TEXT_COLOUR;
				}
			}
			updateDisplayList();
		}


	}
}
