/**
 * Created by russellmilburn on 02/09/15.
 */
package com.tro.chromecast.views
{

	import com.tro.chromecast.models.vos.NavigationBtnVo;
	import com.tro.chromecast.views.components.buttons.ContinueBtn;
	import com.tro.chromecast.views.components.TVDisplay;
	import com.tro.chromecast.views.components.buttons.ExitSectionBtn;
	import com.tro.chromecast.views.components.buttons.ImageButton;

	import starling.display.BlendMode;
	import starling.display.Canvas;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.utils.HAlign;

	public class ExitAppView extends View
	{
		private var _yesBtn : ImageButton;
		private var _noBtn : ImageButton;
		private var _titleField:TextField;
		private var _bodyCopy:TextField;

		private var _btnContainer : Sprite;
		private var logo :Sprite;

		public function ExitAppView()
		{
			super();
		}

		override protected function onViewInit():void
		{
			super.onViewInit();
		}

		override protected function initStageAssets():void
		{
			_btnContainer = new Sprite();
			removeChild(_viewBackground);

			_viewBackground = new Canvas();
			_viewBackground.beginFill(0xFFFFFF, 1);
			_viewBackground.drawRectangle(0,0, stage.stageWidth, stage.stageHeight);
			_viewBackground.touchable = false;
			_viewBackground.blendMode = BlendMode.NONE;

			

			_titleField = new TextField(1920 - 200, 0, "");
			_titleField.autoSize = TextFieldAutoSize.VERTICAL;
			_titleField.hAlign = HAlign.CENTER;
			_titleField.fontName = "Roboto";
			_titleField.fontSize = 60;
			_titleField.color = 0x656666;
			_titleField.touchable = false;
			_titleField.text ="Thanks for learning about Chromecast! \nAre you sure you want to exit?";
			_titleField.y = 150;

			_yesBtn = new ImageButton();
			_yesBtn.texture = getTexture("YES-button");

			_noBtn = new ImageButton();
			_noBtn.texture = getTexture("NO-button");
			_noBtn.y = _yesBtn.y;
			_noBtn.x = _yesBtn.x + _yesBtn.width + 20;

			_btnContainer.addChild(_yesBtn);
			_btnContainer.addChild(_noBtn);

			_btnContainer.y = _titleField.y + _titleField.height + 25;
			_btnContainer.x = (stage.stageWidth - _btnContainer.width) / 2;
			
			logo = getTexturesSprite("ChromeCastLogoLoginView");
			logo.x = (stage.stageWidth - logo.width) / 2;
			logo.y = _btnContainer.y + _btnContainer.height + 175;
			
			_bodyCopy = new TextField(1920 - 200, 0, "");
			_bodyCopy.autoSize = TextFieldAutoSize.VERTICAL;
			_bodyCopy.hAlign = HAlign.CENTER;
			_bodyCopy.fontName = "Roboto";
			_bodyCopy.fontSize = 60;
			_bodyCopy.color = 0x656666;
			_bodyCopy.touchable = false;
			_bodyCopy.text ="For support with your new chromecast,\nvisit chromecast.com/support ";
			_bodyCopy.y = logo.y + logo.height + 50;

			_bodyCopy.x = (stage.stageWidth - _bodyCopy.width) / 2;
			_titleField.x = (stage.stageWidth - _bodyCopy.width) / 2;

			

			addChildAt(_viewBackground, 0);
			addChild(_btnContainer);
			addChild(_titleField);
			addChild(_bodyCopy);
			addChild(logo);

			dispatchEvent(new ViewEvent(ViewEvent.ON_VIEW_INIT_COMPLETE));
		}


		public function get yesBtn():ImageButton
		{
			return _yesBtn;
		}

		public function set yesBtn(value:ImageButton):void
		{
			_yesBtn = value;
		}

		public function get noBtn():ImageButton
		{
			return _noBtn;
		}

		public function set noBtn(value:ImageButton):void
		{
			_noBtn = value;
		}
	}
}
