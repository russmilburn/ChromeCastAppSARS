package com.tro.chromecast.views
{

	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.views.components.SwipeToContinue;

	import starling.display.Image;
	import starling.text.TextField;
	import starling.text.BitmapFont;
	import starling.text.TextFieldAutoSize;
	import starling.utils.HAlign;
	import starling.display.BlendMode;
	
	import com.tro.chromecast.views.components.SwipeControl;
	import com.tro.chromecast.views.components.GradientText;
	
	/**
	 * ...
	 * @author David Armstrong
	 */
	
	public class IntroView extends View
	{
		private var _swipeControl:SwipeControl;
		
		private var _screenPhone:Image;
		
		private var _headingText:TextField;
		private var _infoText:TextField;	
		
		private var _gradientText:GradientText;
		
		private var _swipeToContinue:SwipeToContinue;
		
		public function IntroView()
		{
			super();
		}
		
		override protected function onViewInit():void
		{
			_swipeControl = new SwipeControl(0xff0000);
			addChild(_swipeControl);
			
			_swipeControl.setRectWidth(this.stage.stageWidth);
			_swipeControl.setRectHeight(this.stage.stageHeight);			
			
			super.onViewInit();
		}
		
		override protected function initStageAssets():void
		{
			_screenPhone = new Image(getTexture("introScreenPhone"));
			_screenPhone.touchable = false;
			
			addChild(_screenPhone);
			
			_headingText = new TextField(1720, 0, "Introducing Chromecast", "Roboto", 60, 0x4788f4, false);
			_headingText.autoSize = TextFieldAutoSize.VERTICAL;
			_headingText.hAlign = HAlign.CENTER;
			_headingText.touchable = false;
			_headingText.x = (stage.stageWidth - _headingText.width) / 2 - (375 / 2);
			_headingText.y = 50;

			addChild(_headingText);
			
			_infoText = new TextField(1720, 0, "Cast your favourite entertainment from your \nphone or tablet straight to the TV", "Roboto", 50, 0x878786, false);
			_infoText.autoSize = TextFieldAutoSize.VERTICAL;
			_infoText.hAlign = HAlign.CENTER;
			_infoText.touchable = false;
			_infoText.x = (stage.stageWidth - _infoText.width) / 2 - (375 / 2);
			_infoText.y = 150;

			addChild(_infoText);
			
			_gradientText = new GradientText();			
			_gradientText.setGradientTexture(getTexture("gradient"));
			_gradientText.y = stage.stageHeight - _gradientText.height;
			
			_gradientText.touchable = false;
			_gradientText.setText("Discover how easy casting is in just 30 seconds.");
			_gradientText.instructionsText.x = (stage.stageWidth - _infoText.width) / 2 - (375 / 2);
			_gradientText.instructionsText.y = _gradientText.instructionsText.y - (_gradientText.instructionsText.height);
			
			addChild(_gradientText);
			
			_swipeToContinue = new SwipeToContinue();
			_swipeToContinue.titleField.color = 0xFFFFFF;
			_swipeToContinue.y = stage.stageHeight - _swipeToContinue.height - 35;
			_swipeToContinue.x = (stage.stageWidth - _swipeToContinue.width) / 2 - (375 / 2);;
			
			addChild(_swipeToContinue);
			
			dispatchEvent(new ViewEvent(ViewEvent.ON_VIEW_INIT_COMPLETE));
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