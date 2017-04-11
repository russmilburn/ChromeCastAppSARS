/**
 * Created by russellmilburn on 31/07/15.
 */
package com.tro.chromecast.views
{

	import com.tro.chromecast.views.components.SwipeControl;
	import com.tro.chromecast.views.components.SwipeToContinue;
	import com.tro.chromecast.views.components.TVDisplay;
	import com.tro.chromecast.views.components.TVDisplayVo;
	import com.tro.chromecast.views.components.imagemenu.ImageMenu;
	import com.tro.chromecast.views.components.imagemenu.ImageMenuEvent;

	import starling.display.Image;

	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class ChooseDeviceView extends View
	{
		private var swipeControl:SwipeControl;

		private var _deviceMenu : ImageMenu;
		private var _gradient:Sprite;
		private var _tvDisplay:TVDisplay;

		private var appleIcon : Sprite;
		private var androidIcon : Sprite;

		private var _titleField : TextField;
		private var _bodyCopyField : TextField;
		private var _iconContainer:Sprite;
		
		private var _swipeToContinue:SwipeToContinue;

		public function ChooseDeviceView()
		{
			super();
		}


		override protected function onViewInit():void
		{

			swipeControl = new SwipeControl();
			addChild(swipeControl);

			swipeControl.width = this.stage.stageWidth;
			swipeControl.height = this.stage.stageHeight;

			super.onViewInit();

		}

		override protected function initStageAssets():void
		{
			appleIcon = getTexturesSprite("AppleIcon");
			androidIcon = getTexturesSprite("AndroidIcon");
			
			appleIcon.x = androidIcon.x + androidIcon.width + 20;
			
			
			_gradient = getTexturesSprite("gradient");
			_gradient.y = stage.stageHeight - _gradient.height;
			_gradient.touchable = false;
			
			_tvDisplay  = new TVDisplay();
			_tvDisplay.tvDisplayVo = getContentVo();
			_tvDisplay.touchable = false;
			_tvDisplay.x = (stage.stageWidth - _tvDisplay.width) / 2 ;
			_tvDisplay.y = 50;
			
			_deviceMenu = new ImageMenu();
			_deviceMenu.padding = 100;
			_deviceMenu.addEventListener(ImageMenuEvent.ON_UPDATE, onUpdateHandler);
			
			
			_titleField = new TextField(_tvDisplay.screenArea.width - 50, 0, "");
			_titleField.autoSize = TextFieldAutoSize.VERTICAL;
			_titleField.hAlign = HAlign.CENTER;
			_titleField.fontName = "Roboto";
			_titleField.fontSize = 60;
			_titleField.color = 0x656666;
			_titleField.touchable = false;
			
			_bodyCopyField = new TextField(_tvDisplay.screenArea.width - 150, 0, "");
			_bodyCopyField.fontName = "Roboto";
			_bodyCopyField.autoSize = TextFieldAutoSize.VERTICAL;
			_bodyCopyField.hAlign = HAlign.CENTER;
			_bodyCopyField.vAlign = VAlign.CENTER;
			_bodyCopyField.fontSize = 50;
			_bodyCopyField.color = 0x656666;
			_bodyCopyField.touchable = false;
			
			_iconContainer = new Sprite();
			_iconContainer.addChild(androidIcon);
			_iconContainer.addChild(appleIcon);
			
			_swipeToContinue = new SwipeToContinue();
			_swipeToContinue.visible = false;
			
			addChild(_tvDisplay);
			addChild(_titleField);
			addChild(_bodyCopyField);
			addChild(_iconContainer);
			addChild(_gradient);
			addChild(_deviceMenu);
			addChild(_swipeToContinue);
			
			_titleField.y = _tvDisplay.y + _tvDisplay.screenArea.y + 25;
			_iconContainer.x = (stage.stageWidth - _iconContainer.width) / 2;
			_titleField.x = (stage.stageWidth - _titleField.width) / 2;
			_bodyCopyField.x = (stage.stageWidth - _bodyCopyField.width) / 2;
			
			dispatchEvent(new ViewEvent(ViewEvent.ON_VIEW_INIT_COMPLETE));
		}

		override protected function getContentVo() : TVDisplayVo
		{
			var vo : TVDisplayVo = super.getContentVo();
			vo.title = "First, choose your device";
			vo.bodyCopy = "\nChromecast works with devices you already own.";
			return vo;
		}


		override public function prepareViewIn(direction:String):void
		{
			super.prepareViewIn(direction);
			_swipeToContinue.visible = false;
			_bodyCopyField.visible = false;
			_titleField.visible = false;
			_iconContainer.visible = false;
			
		}
		
		override protected function onViewTweenOutComplete():void
		{
			super.onViewTweenOutComplete();
			
			_tvDisplay.titleText = "First, choose your device";
			_tvDisplay.bodyCopyText = "\nChromecast works with devices you already own.";
			
			_bodyCopyField.visible = false;
			_titleField.visible = false;
			_iconContainer.visible = false;
		}

		private function onUpdateHandler(event : ImageMenuEvent):void
		{
			_deviceMenu.x = (stage.stageWidth - _deviceMenu.width) / 2;
			_deviceMenu.y = stage.stageHeight - _deviceMenu.height - 50;
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

		public function get tvDisplay():TVDisplay
		{
			return _tvDisplay;
		}

		public function set tvDisplay(value:TVDisplay):void
		{
			_tvDisplay = value;
		}

		public function get deviceMenu():ImageMenu
		{
			return _deviceMenu;
		}

		public function set deviceMenu(value:ImageMenu):void
		{
			_deviceMenu = value;
		}

		public function get iconContainer():Sprite
		{
			return _iconContainer;
		}

		public function set iconContainer(value:Sprite):void
		{
			_iconContainer = value;
		}
		
		public function get swipeToContinue():SwipeToContinue 
		{
			return _swipeToContinue;
		}
		
		public function set swipeToContinue(value:SwipeToContinue):void 
		{
			_swipeToContinue = value;
		}
	}
}
