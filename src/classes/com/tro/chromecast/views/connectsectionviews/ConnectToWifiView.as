/**
 * Created by russellmilburn on 15/09/15.
 */
package com.tro.chromecast.views.connectsectionviews
{

	import com.tro.chromecast.models.vos.DeviceTypeVo;
	import com.tro.chromecast.views.*;
	import com.tro.chromecast.views.components.GradientText;
	import com.tro.chromecast.views.components.SwipeControl;
	import com.tro.chromecast.views.components.SwipeToContinue;
	import com.tro.chromecast.views.components.TVDisplay;
	import com.tro.chromecast.views.components.buttons.ImageButton;
	import com.tro.chromecast.views.components.devicedisplay.DeviceDisplay;

	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class ConnectToWifiView extends View
	{
		private var swipeControl:SwipeControl;
		private var _tvDisplay:TVDisplay;
		private var _gradient:GradientText;
		private var _deviceDisplay:DeviceDisplay;
		private var _infoText : TextField;
		private var _castButton : ImageButton;
		private var _swipeToContinue:SwipeToContinue;
		

		public function ConnectToWifiView()
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
			_gradient = new GradientText();
			_gradient.setGradientTexture(getTexture("gradient"));
			_gradient.y = stage.stageHeight - _gradient.height;
			_gradient.touchable = false;

			_tvDisplay  = new TVDisplay();
			_tvDisplay.tvDisplayVo = getContentVo();
			_tvDisplay.updateScreenImage(getTexture("TVReadyToCast"));

			_tvDisplay.x = (stage.stageWidth - _tvDisplay.width) / 2 ;
			_tvDisplay.y = 50;
			_tvDisplay.touchable = false;
			
			_deviceDisplay = new DeviceDisplay();
			_deviceDisplay.laptop.setBackgroundImage(getTexture("Device" + DeviceTypeVo.LAPTOP + "Blank"));
			_deviceDisplay.mobile.setBackgroundImage(getTexture("Device" + DeviceTypeVo.MOBILE + "Blank"));
			_deviceDisplay.tablet.setBackgroundImage(getTexture("Device" + DeviceTypeVo.TABLET + "Blank"));
			_deviceDisplay.touchable = false;
			
			_infoText = new TextField(100,100,"");
			_infoText.fontName = "Roboto";
			_infoText.autoSize = TextFieldAutoSize.VERTICAL;
			_infoText.hAlign = HAlign.CENTER;
			_infoText.vAlign = VAlign.CENTER;
			_infoText.fontSize = 40;
			_infoText.color = 0x656666;
			_infoText.touchable = false;
			
			_castButton = new ImageButton();
			_castButton.texture = getTexture("CastIcon");
			_castButton.alpha = 0;
			_castButton.scaleX = 0.4;
			_castButton.scaleY = 0.4;
			
			_castButton.visible = false;
			
			_swipeToContinue = new SwipeToContinue();
			_swipeToContinue.x = (stage.stageWidth - _swipeToContinue.width) / 2;
			_swipeToContinue.y = stage.stageHeight - _swipeToContinue.height - 50;
			_swipeToContinue.titleField.color = 0xFFFFFF;
			_swipeToContinue.visible = false;
			
			addChild(_tvDisplay);
			addChild(_deviceDisplay);
			addChild(_infoText);
			addChild(_castButton);
			addChild(_gradient);
			addChild(_swipeToContinue);
			
			dispatchEvent(new ViewEvent(ViewEvent.ON_VIEW_INIT_COMPLETE));
		}


		override protected function onViewTweenInComplete():void
		{
			super.onViewTweenInComplete();


		}

		public function get deviceDisplay():DeviceDisplay
		{
			return _deviceDisplay;
		}

		public function set deviceDisplay(value:DeviceDisplay):void
		{
			_deviceDisplay = value;
		}


		public function get infoText():TextField
		{
			return _infoText;
		}

		public function set infoText(value:TextField):void
		{
			_infoText = value;
		}


		public function get gradient():GradientText
		{
			return _gradient;
		}

		public function set gradient(value:GradientText):void
		{
			_gradient = value;
		}

		public function get castButton():ImageButton
		{
			return _castButton;
		}

		public function set castButton(value:ImageButton):void
		{
			_castButton = value;
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
