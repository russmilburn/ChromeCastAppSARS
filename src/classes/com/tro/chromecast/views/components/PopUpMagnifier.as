/**
 * Created by russellmilburn on 12/08/15.
 */
package com.tro.chromecast.views.components
{

	import com.tro.chromecast.views.components.buttons.ImageButton;
	import org.gestouch.gestures.SwipeGesture;

	import org.gestouch.events.GestureEvent;
	import org.gestouch.gestures.TapGesture;

	import starling.display.Canvas;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class PopUpMagnifier extends Sprite
	{
		private var container : Sprite;
		private var background : Image;
		private var imageButton : ImageButton;
		private var maskCanvas : Canvas;
		private var _tap:TapGesture;
		private var swipe:SwipeGesture;


		public function PopUpMagnifier()
		{
			super();

			container = new Sprite();
			addChild(container);

			maskCanvas = new Canvas();
			maskCanvas.beginFill(0xfff000);
			maskCanvas.drawCircle(200, 200, 200);
			container.mask = maskCanvas;


			imageButton = new ImageButton();
			imageButton.x = 140;
			imageButton.y = 140;
			imageButton.tap.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onTapHandler);
			
			container.addChild(imageButton);
			
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
		
		public function enablePopUpButton() : void
		{
			_tap = new TapGesture(this);
			_tap.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onTapHandler);
		}

		public function disablePopUpButton() : void
		{
			_tap.removeEventListener(GestureEvent.GESTURE_RECOGNIZED, onTapHandler);
		}

		private function onTapHandler(event:GestureEvent):void
		{
			dispatchEvent(new PopUpMagnifierEvent(PopUpMagnifierEvent.ON_BUTTON_TAP));
		}


		public function setBackgroundImage(texture : Texture) : void
		{
			if (background != null)
			{
				removeChild(background)
			}
			background = new Image(texture);
			background.alpha = 1;
			addChildAt(background, 0);
		}

		public function setImageButtonTexture(texture : Texture) : void
		{
			imageButton.texture = texture;
		}


	}
}
