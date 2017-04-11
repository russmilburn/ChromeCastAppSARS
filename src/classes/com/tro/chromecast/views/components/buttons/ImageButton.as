/**
 * Created by tro on 3/08/2015.
 */
package com.tro.chromecast.views.components.buttons
{

	import org.gestouch.gestures.TapGesture;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class ImageButton extends Sprite
	{
		protected var _texture : Texture;
		protected var _image : Image;
		protected var _tap : TapGesture;

		public function ImageButton()
		{
			_tap = new TapGesture(this);
		}


		public function get texture():Texture
		{
			return _texture;
		}

		public function set texture(value:Texture):void
		{
			_texture = value;

			updateDisplay();
		}

		protected function updateDisplay() : void
		{
			if (_image != null)
			{
				removeChild(_image);
			}
			_image = new Image(_texture);

			addChild(_image);
		}


		public function get tap():TapGesture
		{
			return _tap;
		}

		public function set tap(value:TapGesture):void
		{
			_tap = value;
		}
	}
}
