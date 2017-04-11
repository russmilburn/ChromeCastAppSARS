/**
 * Created by russellmilburn on 14/09/15.
 */
package com.tro.chromecast.views.components
{


	import starling.display.Image;

	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class GradientText extends Sprite
	{
		private var _instructionsText:TextField;
		private var _gradient:Sprite;
		private var _image : Image;
		private var _text : String;
		private var _swipeToContinue:SwipeToContinue;
		private var _displaySwipeToContinue:Boolean;

		public function GradientText()
		{
			super();

			touchable = false;

			_instructionsText = new TextField(1720, 50, "");
			_instructionsText.touchable = false;
			_instructionsText.autoSize = TextFieldAutoSize.VERTICAL;
			_instructionsText.hAlign = HAlign.CENTER;
			_instructionsText.vAlign = VAlign.CENTER;
			_instructionsText.fontName = "Roboto";
			_instructionsText.fontSize = 50;
			_instructionsText.color = 0xFFFFFF;

			_swipeToContinue = new SwipeToContinue();
			_swipeToContinue.titleField.color = 0xFFFFFF;
			_swipeToContinue.visible = false;
			
			_gradient = new Sprite();
			_gradient.touchable = false;

			addChild(_gradient);
			addChild(_swipeToContinue);
			addChild(_instructionsText);
		}


		public function updateDisplayList() : void
		{
			if (_displaySwipeToContinue)
			{
				_instructionsText.y = (_image.height - _instructionsText.height ) - 100;
				_swipeToContinue.y = (_instructionsText.y + _instructionsText.height + 10);
				_swipeToContinue.x = (this.width - _swipeToContinue.width) / 2; 
				_swipeToContinue.visible = true;
			} else {
				_instructionsText.x = (this.width - _instructionsText.width) / 2;
				_instructionsText.y = (_image.height - _instructionsText.height ) - 50;
				_swipeToContinue.visible = false;
			}
		}

		public function setText(text : String) : void
		{
			_instructionsText.text = text;
			updateDisplayList();
		}

		public function setGradientTexture(texture : Texture) : void
		{
			if (_image != null)
			{
				_gradient.removeChild(_image);
			}
			_image = new Image(texture);

			_gradient.addChild(_image);
		}

		public function turnOnSwipeToContinue():void
		{
			
		}
		
		public function get instructionsText():TextField
		{
			return _instructionsText;
		}

		public function set instructionsText(value:TextField):void
		{
			_instructionsText = value;
		}
		
		public function get displaySwipeToContinue():Boolean 
		{
			return _displaySwipeToContinue;
		}
		
		public function set displaySwipeToContinue(value:Boolean):void 
		{
			_displaySwipeToContinue = value;
			updateDisplayList();
		}
	}
}
