/**
 * Created by tro on 30/07/2015.
 */
package com.tro.chromecast.views.components
{


	import starling.display.Image;
	import starling.text.TextField;

	import starling.display.Sprite;
	import starling.text.BitmapFont;
	import starling.textures.Texture;

	public class PinCodeInput extends Sprite
	{
		private var _spriteTexture:Texture;
		private var spriteImage:Image;
		public var string:String = "";
		private var tf:TextField;


		public function PinCodeInput()
		{
			super();

			init();
		}

		private function init():void
		{
			tf = new TextField(159, 159, "", "Roboto", 60, 0x878786, false);
			addChildAt(tf, numChildren);
		}

		public function update(string:String):void
		{
			this.string = string;
			tf.text = this.string;
		}

		public function get spriteTexture():Texture
		{
			return _spriteTexture;
		}

		public function set spriteTexture(value:Texture):void
		{
			_spriteTexture = value;
			spriteImage = new Image(_spriteTexture);

			this.addChildAt(spriteImage, 0);
		}
	}
}
