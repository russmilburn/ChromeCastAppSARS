/**
 * Created by russellmilburn on 21/09/15.
 */
package com.tro.chromecast.views
{

	import away3d.tools.utils.Grid;
	import com.greensock.TweenMax;

	import com.tro.chromecast.models.vos.DoMoreAppVo;
	import com.tro.chromecast.views.components.ContentBox;

	import com.tro.chromecast.views.components.GridButton;

	import com.tro.chromecast.views.components.SwipeControl;
	import com.tro.chromecast.views.components.TVDisplay;
	import com.tro.chromecast.views.components.TVDisplayVo;
	import com.tro.chromecast.views.components.tabs.TabMenu;

	import starling.display.BlendMode;

	import starling.display.Canvas;

	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.utils.HAlign;

	public class DiscoverMoreAppView extends View
	{
		private var swipeControl:SwipeControl;

		private var _dataProvider: Array;
		private var gridContainer : Sprite;
		private var padding : int = 40;

		private var _tabMenu : TabMenu;
		private var _btns : Array;
		private var _contentBox : ContentBox;
		private var _titleText : TextField;


		public function DiscoverMoreAppView()
		{
			super();
		}

		override protected function onViewInit():void
		{
			swipeControl = new SwipeControl();
			addChild(swipeControl);

			swipeControl.width = this.stage.stageWidth;
			swipeControl.height = this.stage.stageHeight;

			_btns = new Array();

			super.onViewInit();

		}

		override protected function initStageAssets():void
		{
			_viewBackground = new Canvas();
			_viewBackground.beginFill(0xFFFFFF, 1);
			_viewBackground.drawRectangle(0,0, stage.stageWidth, stage.stageHeight);
			_viewBackground.touchable = false;
			_viewBackground.blendMode = BlendMode.NONE;


			_titleText = new TextField(stage.stageWidth - 200, 0, "");
			_titleText.autoSize = TextFieldAutoSize.VERTICAL;
			_titleText.hAlign = HAlign.CENTER;
			_titleText.fontName = "Roboto";
			_titleText.fontSize = 60;
			_titleText.color = 0x656666;
			_titleText.touchable = false;
			_titleText.text = "Discover more Google Cast Ready Apps";
			_titleText.x = (stage.stageWidth - _titleText.width) / 2;
			_titleText.y = 50;

			_contentBox = new ContentBox();
			_contentBox.closeTexture = getTexture("closeIcon");

			_tabMenu = new TabMenu();
			_tabMenu.setBackground(getTexture("TabMenuBackground"));

			_tabMenu.x = (stage.stageWidth - _tabMenu.width) / 2;
			_tabMenu.y = 200;

			gridContainer = new Sprite();
			gridContainer.y = 350;

			addChild(_viewBackground);
			addChild(_tabMenu);
			addChild(gridContainer);
			addChild(_contentBox);
			addChild(_titleText);


			dispatchEvent(new ViewEvent(ViewEvent.ON_VIEW_INIT_COMPLETE));
		}

		public function set dataProvider(value : Array) : void
		{
			_dataProvider = value;

			if (_btns.length > 0)
			{
				for (var i:int = 0; i < _btns.length; i++)
				{
					gridContainer.removeChild(_btns[i]);
				}
				_btns = new Array();
			}
			updateDisplayList();
		}

		public function updateDisplayList() : void
		{
			var xPos:Number = 0;
			var yPos:Number = 0;

			for (var i:int = 0; i <_dataProvider.length; i++)
			{
				var vo : DoMoreAppVo = DoMoreAppVo(_dataProvider[i]);
				vo.iconTexture = getTexture(vo.id + "_icon");
				var btn : GridButton = new GridButton();
				btn.texture = getTexture("AppButtonBg");
				btn.data = vo;
				btn.x = xPos;
				btn.y = yPos;
				btn.visible = false;
				btn.alpha = 0;
				xPos += btn.width + padding;
				if (i%5 == 4)
				{
					xPos = 0;
					yPos += btn.height + padding;
				}
				_btns.push(btn);
				gridContainer.addChild(btn);
			}
			
			gridContainer.x = (stage.stageWidth - gridContainer.width) / 2;
		}
		public function animateGrid():void
		{
			var delay:Number = 0;
			
			for (var i:Number = 0; i < _btns.length; i++)
			{
				TweenMax.to(_btns[i], .5, { delay:delay, autoAlpha:1 } );
				delay += .1;
			}
		}
		
		public function hideGrid():void
		{
			for (var i:Number = 0; i < _btns.length; i++)
			{
				TweenMax.killTweensOf(_btns[i]);
				_btns[i].alpha = 0;
				_btns[i].visible = false;
				
			}
		}
		public function get tabMenu():TabMenu
		{
			return _tabMenu;
		}

		public function set tabMenu(value:TabMenu):void
		{
			_tabMenu = value;
		}


		public function get contentBox():ContentBox
		{
			return _contentBox;
		}

		public function set contentBox(value:ContentBox):void
		{
			_contentBox = value;
		}
	}
}
