/**
 * Created by tro on 30/07/2015.
 */
package com.tro.chromecast.views.components.buttons
{

	import com.tro.chromecast.views.LoginViewEvent;

	import org.gestouch.events.GestureEvent;
	import org.gestouch.gestures.TapGesture;

	import starling.display.Image;

	import starling.display.Sprite;
	import starling.textures.Texture;

	public class PinCodeBackButton extends Sprite
	{
		private var tapGesture:TapGesture;
		private var _texture : Texture;



		public function PinCodeBackButton()
		{
			super();

			_init();
		}

		private function _init():void
		{
			tapGesture = new TapGesture(this);
			tapGesture.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onTouchHandler);
		}

		private function onTouchHandler(event:GestureEvent):void
		{
			var evt:LoginViewEvent = new LoginViewEvent(LoginViewEvent.BACK_BUTTON_PRESSED);
			dispatchEvent(evt);
		}

		public function get textureSprite():Texture
		{
			return _texture;
		}

		public function set textureSprite(value:Texture):void
		{
			_texture = value;

			var image : Image = new Image(_texture);
			addChild(image);


		}


	}
}
