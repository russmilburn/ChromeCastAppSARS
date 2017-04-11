/**
 * Created by russellmilburn on 28/07/15.
 */
package com.tro.chromecast.views.components
{


	import org.gestouch.events.GestureEvent;
	import org.gestouch.gestures.SwipeGesture;
	import org.gestouch.gestures.TapGesture;

	import starling.display.Canvas;
	import starling.display.Sprite;
	import starling.events.Event;

	public class SwipeControl extends Sprite
	{

		private var rect : Canvas;
		private var swipe : SwipeGesture;
		private var tap : TapGesture;
		private var _colour : uint;


		public function SwipeControl(colour:uint = 0xffffff)
		{
			super();

			_colour = colour;

			rect = new Canvas();
			rect.beginFill(_colour, 0);
			rect.drawRectangle(0, 0, 100, 100);
			addChild(rect);

			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

			//updateDisplay();

			swipe = new SwipeGesture(rect);
			tap = new TapGesture(rect);
			swipe.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onSwipeGesture);

		}
		
		public function enableTap() : void
		{
			tap.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onTapGesture);
		}

		public function disableTap() : void
		{
			tap.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onTapGesture);
		}

		private function onTapGesture(event:GestureEvent):void
		{
			dispatchEvent(new SwipeControlEvent(SwipeControlEvent.ON_TAP, true));
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



		public function setRectWidth(value:Number):void
		{
			rect.width = value;
		}

		public function setRectHeight(value:Number):void
		{
			rect.height = value;


		}
	}
}
