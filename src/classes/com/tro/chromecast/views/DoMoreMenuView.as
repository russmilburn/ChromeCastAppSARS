/**
 * Created by russellmilburn on 15/09/15.
 */
package com.tro.chromecast.views
{

	import com.tro.chromecast.models.vos.NavigationBtnVo;
	import com.tro.chromecast.views.components.SwipeControl;
	import com.tro.chromecast.views.components.TVDisplay;
	import com.tro.chromecast.views.components.buttons.ContinueBtn;
	import com.tro.chromecast.views.components.buttons.NavigationBtn;

	import starling.display.Sprite;

	public class DoMoreMenuView extends View
	{
		private var swipeControl:SwipeControl;
		private var _tvDisplay:TVDisplay;
		private var _menuContainer : Sprite;
		private var _dataProvider:Array;
		private var btns : Array;
		private var _buttonContainer : Sprite;

		public function DoMoreMenuView()
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
			_tvDisplay  = new TVDisplay();
			_tvDisplay.tvDisplayVo = getContentVo();
			_tvDisplay.titleText = "Do More";
			_tvDisplay.layout = TVDisplay.ALIGN_TOP;
			_tvDisplay.touchable = false;
			_tvDisplay.x = (stage.stageWidth - _tvDisplay.width) / 2 ;
			_tvDisplay.y = 50;

			_menuContainer = new Sprite();


			addChild(_tvDisplay);
			addChild(_menuContainer);

			dispatchEvent(new ViewEvent(ViewEvent.ON_VIEW_INIT_COMPLETE));
		}


		public function set dataProvider(value : Array) : void
		{
			_dataProvider  = value;

			updateDisplayList();
		}

		public function get dataProvider() : Array
		{
			return _dataProvider;
		}

		private function updateDisplayList():void
		{
			btns = new Array();
			_buttonContainer  = new Sprite();
			_menuContainer.addChild(_buttonContainer);
			var xPos : int = 0;
			var yPos : int = 0;
			var padding : int = 0;

			for (var i:int = 0; i < dataProvider.length; i++)
			{
				var vo:NavigationBtnVo = dataProvider[i];
				var btn : ContinueBtn = new ContinueBtn();
				btn.data = vo;
				btn.x = (xPos - btn.width) / 2;
				btn.y = yPos;

				yPos = yPos + padding + btn.height;

				btn.enable();
				btns.push(btn);
				_buttonContainer.addChild(btn);

			}
			_buttonContainer.x = _buttonContainer.width / 2;

			_menuContainer.x = (stage.stageWidth - _menuContainer.width) /2;
			_menuContainer.y = (stage.stageHeight - _menuContainer.height) /2;
		}


		public function get tvDisplay():TVDisplay
		{
			return _tvDisplay;
		}

		public function set tvDisplay(value:TVDisplay):void
		{
			_tvDisplay = value;
		}
	}
}
