/**
 * Created by russellmilburn on 23/09/15.
 */
package com.tro.chromecast.views.components.tabs
{

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class TabMenu extends Sprite
	{
		private var background : Image;
		private var _watchBtn : TabMenuToggleButton;
		private var _listenBtn : TabMenuToggleButton;
		private var _playBtn : TabMenuToggleButton;

		public function TabMenu()
		{
			super();

			init();


		}

		public function setBackground(texture : Texture) : void
		{
			if (background != null)
			{
				removeChild(background);
			}
			background = new Image(texture);
			background.touchable = false;
			addChild(background);

		}

		private function init():void
		{
			_watchBtn = new TabMenuToggleButton();
			_watchBtn.setLabelText("Watch");
			_watchBtn.touchable = true;

			_listenBtn = new TabMenuToggleButton();
			_listenBtn.setLabelText("Listen");
			_listenBtn.touchable = true;

			_playBtn = new TabMenuToggleButton();
			_playBtn.setLabelText("Play");
			_playBtn.touchable = true;


			_listenBtn.x = _watchBtn.x + _watchBtn.width + 2;
			_playBtn.x = _listenBtn.x + _listenBtn.width + 2;

			_watchBtn.isSelected = true;

			addChild(_watchBtn);
			addChild(_listenBtn);
			addChild(_playBtn);
		}


		public function get watchBtn():TabMenuToggleButton
		{
			return _watchBtn;
		}

		public function set watchBtn(value:TabMenuToggleButton):void
		{
			_watchBtn = value;
		}

		public function get listenBtn():TabMenuToggleButton
		{
			return _listenBtn;
		}

		public function set listenBtn(value:TabMenuToggleButton):void
		{
			_listenBtn = value;
		}

		public function get playBtn():TabMenuToggleButton
		{
			return _playBtn;
		}

		public function set playBtn(value:TabMenuToggleButton):void
		{
			_playBtn = value;
		}
	}
}
