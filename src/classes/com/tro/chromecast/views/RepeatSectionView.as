/**
 * Created by russellmilburn on 02/09/15.
 */
package com.tro.chromecast.views
{

	import com.tro.chromecast.models.vos.NavigationBtnVo;
	import com.tro.chromecast.views.components.buttons.ContinueBtn;
	import com.tro.chromecast.views.components.buttons.NavigationBtn;
	import com.tro.chromecast.views.components.buttons.RepeatSectionBtn;
	import com.tro.chromecast.views.components.SwipeControl;
	import com.tro.chromecast.views.components.TVDisplay;
	import com.tro.chromecast.views.components.TVDisplayVo;

	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class RepeatSectionView extends View
	{
		private var _swipeControl:SwipeControl;
		private var _tvDisplay:TVDisplay;
		private var _continueBtn:ContinueBtn;
		private var _continueVo:NavigationBtnVo;
		private var _repeatVo:NavigationBtnVo;
		private var _repeatBtn:RepeatSectionBtn;

		private var _congratsTextField : TextField;
		private var _bodyText : TextField;

		public function RepeatSectionView()
		{
			super();
		}

		override protected function onViewInit():void
		{
			_swipeControl = new SwipeControl(0xff0000);
			addChild(_swipeControl);

			_swipeControl.setRectWidth(this.stage.stageWidth);
			_swipeControl.setRectHeight(this.stage.stageHeight);

			_continueVo = new NavigationBtnVo();
			_continueVo.label = "Continue";

			_repeatVo = new NavigationBtnVo();
			_repeatVo.label = "Repeat section";

			super.onViewInit();

		}


		override protected function initStageAssets():void
		{
			_continueBtn = new ContinueBtn();
			_continueBtn.data = _continueVo;
			_continueBtn.enable();

			_repeatBtn = new RepeatSectionBtn();
			_repeatBtn.data = _repeatVo;
			_repeatBtn.setRepeatTexture(getTexture("ReplayIcon"));
			_repeatBtn.enable();

			_continueBtn.y = 350;
			_repeatBtn.y = _continueBtn.y + _continueBtn.height;
			_repeatBtn.x = (stage.stageWidth - _repeatBtn.width) / 2;
			_continueBtn.x = (stage.stageWidth - _continueBtn.width ) / 2;


			_tvDisplay  = new TVDisplay();
			_tvDisplay.tvDisplayVo = getContentVo();
			_tvDisplay.touchable = false;
			_tvDisplay.x = (stage.stageWidth - _tvDisplay.width) / 2 ;
			_tvDisplay.y = 50;
			_tvDisplay.layout = TVDisplay.ALIGN_TOP;


			_congratsTextField = new TextField(_tvDisplay.screenArea.width - 50, 0, "");
			_congratsTextField.autoSize = TextFieldAutoSize.VERTICAL;
			_congratsTextField.hAlign = HAlign.CENTER;
			_congratsTextField.fontName = "Roboto";
			_congratsTextField.fontSize = 60;
			_congratsTextField.color = 0x4d88e5;
			_congratsTextField.touchable = false;
			_congratsTextField.text = "Congratulations!";

			_bodyText = new TextField(_tvDisplay.screenArea.width - 150, 0, "");
			_bodyText.fontName = "Roboto";
			_bodyText.autoSize = TextFieldAutoSize.VERTICAL;
			_bodyText.hAlign = HAlign.CENTER;
			_bodyText.vAlign = VAlign.CENTER;
			_bodyText.fontSize = 50;
			_bodyText.color = 0x656666;
			_bodyText.touchable = false;
			_bodyText.text = "You just completed your first cast!\n\nChoose from the Menu to discover\nmore about Chromecast";



			_congratsTextField.x = _tvDisplay.x + _tvDisplay.screenArea.x;
			_congratsTextField.y = _tvDisplay.y + _tvDisplay.screenArea.y+ 200;

			_bodyText.y = _congratsTextField.y + _congratsTextField.height + 25;

			_bodyText.x = _congratsTextField.x + 75;


			addChild(_tvDisplay);
			addChild(_continueBtn);
			addChild(_repeatBtn);
			addChild(_congratsTextField);
			addChild(_bodyText);

			dispatchEvent(new ViewEvent(ViewEvent.ON_VIEW_INIT_COMPLETE));
		}

		override protected function getContentVo() : TVDisplayVo
		{
			var vo : TVDisplayVo = super.getContentVo();
			//vo.bodyCopy = "Discover more apps and \nDo more with Chromecast";
			return vo;
		}


		public function get tvDisplay():TVDisplay
		{
			return _tvDisplay;
		}

		public function set tvDisplay(value:TVDisplay):void
		{
			_tvDisplay = value;
		}

		public function get continueBtn():ContinueBtn
		{
			return _continueBtn;
		}

		public function set continueBtn(value:ContinueBtn):void
		{
			_continueBtn = value;
		}

		public function get repeatBtn():RepeatSectionBtn
		{
			return _repeatBtn;
		}

		public function set repeatBtn(value:RepeatSectionBtn):void
		{
			_repeatBtn = value;
		}


		public function get congratsTextField():TextField
		{
			return _congratsTextField;
		}

		public function set congratsTextField(value:TextField):void
		{
			_congratsTextField = value;
		}

		public function get bodyText():TextField
		{
			return _bodyText;
		}

		public function set bodyText(value:TextField):void
		{
			_bodyText = value;
		}
	}
}
