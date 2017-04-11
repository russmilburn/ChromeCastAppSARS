/**
 * Created by russellmilburn on 21/09/15.
 */
package com.tro.chromecast.views.components
{

	import com.tro.chromecast.models.vos.DoMoreAppVo;

	import org.gestouch.events.GestureEvent;

	import org.gestouch.gestures.TapGesture;

	import starling.display.Canvas;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.textures.Texture;
	import starling.utils.HAlign;

	public class ContentBox extends Sprite
	{
		private var titleText : TextField;
		private var bodyText : TextField;
		private var background : Canvas;
		private var padding : Number = 10;
		private var _closeTexture : Texture;
		private var closeBtn : Image;
		private var tap : TapGesture;

		private var _data : DoMoreAppVo;


		public function ContentBox()
		{
			super();

			titleText = new TextField(1,1,"");
			titleText.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			titleText.hAlign = HAlign.LEFT;
			titleText.fontName = "Roboto";
			titleText.fontSize = 40;
			titleText.color = 0xFFFFFF;
			titleText.touchable = false;

			bodyText = new TextField(360,1,"");
			bodyText.autoSize = TextFieldAutoSize.VERTICAL;
			bodyText.hAlign = HAlign.LEFT;
			bodyText.fontName = "Roboto";
			bodyText.fontSize = 29;
			bodyText.color = 0xFFFFFF;
			bodyText.touchable = false;

			background = new Canvas();

		}

		public function set data(value : DoMoreAppVo) : void
		{
			_data = value;

			updateDisplayList();
		}

		private function updateDisplayList():void
		{
			if (closeBtn != null)
			{
				removeChild(closeBtn);
			}

			titleText.text = _data.title;
			bodyText.text = _data.desc;
			titleText.x = padding;
			titleText.y = padding;

			bodyText.x = padding;
			bodyText.y = titleText.y + titleText.height + padding;

			if (background != null)
			{
				removeChild(background);
			}

			var boxWidth : Number = bodyText.width + (padding * 2);
			var boxHeight : Number = titleText.height + bodyText.height + (padding * 3);

			background = new Canvas();
			background.beginFill(0x3369e8, 1);
			background.drawRectangle(0,0, 380, boxHeight);
			background.endFill();

			closeBtn.x = background.width - closeBtn.width - 5;
			closeBtn.y = background.y + 5;

			addChild(background);
			addChild(titleText);
			addChild(bodyText);

			addChild(closeBtn);


		}


		public function get closeTexture():Texture
		{
			return _closeTexture;
		}

		public function set closeTexture(value:Texture):void
		{
			_closeTexture = value;

			closeBtn = new Image(_closeTexture);

			tap = new TapGesture(this);
			tap.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onTapGestureHandler);
		}

		private function onTapGestureHandler(event:GestureEvent):void
		{
			this.visible = false;
		}
	}
}
