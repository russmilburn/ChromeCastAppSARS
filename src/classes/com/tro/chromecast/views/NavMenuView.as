/**
 * Created by russellmilburn on 29/07/15.
 */
package com.tro.chromecast.views
{

	import com.greensock.TweenMax;
	import com.greensock.easing.Cubic;
	import com.tro.chromecast.models.vos.NavigationBtnVo;
	import com.tro.chromecast.views.components.buttons.NavigationBtn;
	import com.tro.chromecast.views.components.SwipeControl;

	import starling.display.Canvas;
	import starling.display.Sprite;
	import starling.filters.BlurFilter;

	public class NavMenuView extends View
	{
		private var _dataProvider : Array;

		private var _menuContainer : Sprite;
		private var _backgroundCanvas : Canvas;
		private var _swipeControl : SwipeControl;
		private var _buttonContainer:Sprite;
		public var btns:Array;

		public function NavMenuView()
		{
			super();

		}


		override protected function onViewInit():void
		{
			super.onViewInit();

			_viewBackground.visible = false;

			_swipeControl = new SwipeControl(0x00ff00);

			_menuContainer = new Sprite();
			_menuContainer.x = stage.stageWidth - 375;
			_menuContainer.height = stage.stageHeight;

			_backgroundCanvas = new Canvas();
			_backgroundCanvas.beginFill(0xffffff);
			_backgroundCanvas.drawRectangle(0,0, 375, stage.stageHeight);

			_menuContainer.addChild(_backgroundCanvas);

			addChild(_menuContainer);
			_menuContainer.addChild(_swipeControl);

			_swipeControl.setRectWidth(375);

			_menuContainer.filter = BlurFilter.createDropShadow(4, 2.70, 0x000000, 0.4, 0.5, 0.5);

			dispatchEvent(new ViewEvent(ViewEvent.ON_VIEW_INIT_COMPLETE));
		}

		public function get dataProvider():Array
		{
			return _dataProvider;
		}

		public function set dataProvider(value:Array):void
		{
			_dataProvider = value;


			updateDisplayList();
		}

		private function updateDisplayList():void
		{
			btns = new Array();
			_buttonContainer  = new Sprite();
			_menuContainer.addChild(_buttonContainer);
			var xPos : int = 0;
			var yPos : int = 113;
			var padding : int = 25;

			for (var i:int = 0; i < dataProvider.length; i++)
			{
				var vo:NavigationBtnVo = dataProvider[i];
				var btn : NavigationBtn = new NavigationBtn();
				btn.data = vo;
				btn.x = xPos;
				btn.y = yPos;
				
				yPos = yPos + padding + btn.height;
				
				btn.enable();
				btns.push(btn);
				
				_buttonContainer.addChild(btn);
			}
			
			_buttonContainer.y = (stage.stageHeight - _menuContainer.height) / 2;
			
			_swipeControl.width = 300;
			_swipeControl.height = _menuContainer.height;
		}
		
		public function openMenu() : void
		{
			TweenMax.to(_menuContainer, 1, {x:stage.stageWidth - 375, ease:Cubic.easeOut});
		}
		
		public function closeMenu() : void
		{
			TweenMax.to(_menuContainer, 1, {x:stage.stageWidth, ease:Cubic.easeOut});
		}
		
		override protected function initStageAssets():void
		{
		
		}
	}
}
