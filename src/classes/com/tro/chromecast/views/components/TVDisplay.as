/**
 * Created by russellmilburn on 21/08/15.
 */
package com.tro.chromecast.views.components
{

	import flash.geom.Rectangle;

	import starling.display.Canvas;

	import starling.display.Image;

	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class TVDisplay extends Sprite
	{
		public static const ALIGN_TOP : String = "AlignTop";
		public static const ALIGN_MIDDLE : String = "AlignMiddle";

		private var _data : TVDisplayVo;
		private var _cabinet : Sprite;
		private var _tv :Sprite;
		private var _screenArea : Rectangle;
		private var _titleField : TextField;
		private var _bodyCopyField : TextField;
		private var _textContainer : Sprite;
		private var _screenImageContainer : Sprite;
		private var _screenImage : Sprite;

		private var _titleText : String;
		private var _bodyCopyText : String;

		private var _layout : String;


		public function TVDisplay()
		{
			super();

			_layout = ALIGN_MIDDLE;

			_screenArea = new Rectangle(20, 21, 1365, 775);
			_screenImageContainer = new Sprite();
			_screenImageContainer.x = 20;
			_screenImageContainer.y = 21;

			initTextField();
		}

		private function initTextField() : void
		{
			_textContainer = new Sprite();

			_titleField = new TextField(_screenArea.width - 50, 0, "");
			_titleField.autoSize = TextFieldAutoSize.VERTICAL;
			_titleField.hAlign = HAlign.CENTER;
			_titleField.fontName = "Roboto";
			_titleField.fontSize = 60;
			_titleField.color = 0x656666;
			_titleField.touchable = false;

			_bodyCopyField = new TextField(_screenArea.width - 150, 0, "");
			_bodyCopyField.fontName = "Roboto";
			_bodyCopyField.autoSize = TextFieldAutoSize.VERTICAL;
			_bodyCopyField.hAlign = HAlign.CENTER;
			_bodyCopyField.vAlign = VAlign.CENTER;
			_bodyCopyField.fontSize = 50;
			_bodyCopyField.color = 0x656666;
			_bodyCopyField.touchable = false;

			_titleField.x = 25;
			_bodyCopyField.x = 75;

			_textContainer.addChild(_titleField);
			_textContainer.addChild(_bodyCopyField);
		}

		private function updateTextLayout() : void
		{
			_bodyCopyField.y = _titleField.height;
			_textContainer.x = _screenArea.x;
			if (_layout == ALIGN_TOP)
			{
				_textContainer.y = 100;
			}
			else
			{
				_textContainer.y = (_screenArea.y + _screenArea.height - _textContainer.height) / 2;
			}
		}

		public function set tvDisplayVo(value : TVDisplayVo) : void
		{
			_data = value;
			updateDisplayList();
		}

		private function updateDisplayList():void
		{
			_tv = getTexturedSprite(_data.tvBackground);
			_cabinet = getTexturedSprite(_data.cabinetTexture);
			_cabinet.x = (_tv.width - _cabinet.width) / 2;
			_cabinet.y = _tv.height - 100;
			
			titleText = _data.title;
			bodyCopyText = _data.bodyCopy;

			addChild(_cabinet);
			addChild(_tv);
			addChild(_screenImageContainer);
			addChild(_textContainer);
		}


		protected function getTexturedSprite(texture : Texture ) : Sprite
		{
			var image : Image = new Image(texture);
			image.name = "image";
			var sprite : Sprite = new Sprite();
			sprite.addChild(image);
			return sprite;
		}

		public function set titleText(value : String) : void
		{
			_titleText = value;
			_titleField.text = _titleText;
			updateTextLayout();

		}

		public function set bodyCopyText(value : String) : void
		{
			_bodyCopyText = value;
			_bodyCopyField.text = _bodyCopyText;
			updateTextLayout();
		}

		public function updateScreenImage(texture : Texture ) : void
		{
			removeScreenImage();
			_screenImage = getTexturedSprite(texture);
			_screenImageContainer.addChild(_screenImage);

		}


		public function get cabinet():Sprite
		{
			return _cabinet;
		}

		public function set cabinet(value:Sprite):void
		{
			_cabinet = value;
		}

		public function get tv():Sprite
		{
			return _tv;
		}

		public function set tv(value:Sprite):void
		{
			_tv = value;
		}

		public function get screenImageContainer():Sprite
		{
			return _screenImageContainer;
		}

		public function set screenImageContainer(value:Sprite):void
		{
			_screenImageContainer = value;
		}


		public function get layout():String
		{
			return _layout;
		}

		public function set layout(value:String):void
		{
			_layout = value;

			updateTextLayout();
		}


		public function get titleField():TextField
		{
			return _titleField;
		}

		public function set titleField(value:TextField):void
		{
			_titleField = value;
		}

		public function get bodyCopyField():TextField
		{
			return _bodyCopyField;
		}

		public function set bodyCopyField(value:TextField):void
		{
			_bodyCopyField = value;
		}


		public function get screenArea():Rectangle
		{
			return _screenArea;
		}

		public function set screenArea(value:Rectangle):void
		{
			_screenArea = value;
		}

		public function removeScreenImage() : void
		{
			if (_screenImage != null)
			{
				_screenImageContainer.removeChild(_screenImage);
				_screenImage.dispose();
				_screenImage = null;
			}
		}


	}
}
