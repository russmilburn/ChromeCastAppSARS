/**
 * Created by tro on 10/08/2015.
 */
package com.tro.chromecast.views.components.imagemenu
{

	import com.tro.chromecast.views.components.imagemenu.ImageMenuButton;
	
	import starling.display.Sprite;

	public class ImageMenu extends Sprite
	{

		private var _dataProvider:Array;

		private var _padding:Number = 0;

		private var btns:Array;

		public function ImageMenu()
		{
			super();
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

		private function updateDisplayList() : void
		{
			if (dataProvider == null)
			{
				return;
			}

			btns = new Array();

			var xPos:Number = 0;
			var yPos:Number = 0;

			for(var i:Number = 0; i < _dataProvider.length;i++)
			{
				var btn:ImageMenuButton = new ImageMenuButton();
				btn.addEventListener(ImageMenuEvent.ON_TAP, menuItemTapped);
				btn.data = _dataProvider[i];
				btn.data.index = i;
				btn.x = xPos;
				if (i != 0)
				{
					btn.y = yPos - btn.height;
				}
				//btn.y = yPos;
				btn.enable();
				addChild(btn);
				btns.push(btn);
				xPos += btn.width + _padding;
				yPos = btn.height;
			}
			dispatchEvent(new ImageMenuEvent(ImageMenuEvent.ON_UPDATE));
		}

		public function destroy() : void
		{
			if (btns == null)
			{
				return;
			}

			for(var i:Number = 0; i < btns.length;i++)
			{
				var btn:ImageMenuButton = btns[i];
				btn.disable();
				btn.removeEventListener(ImageMenuEvent.ON_TAP, menuItemTapped);
				removeChild(btn);
			}
			btns = null;
		}

		public function reset() : void
		{
			for(var i:Number = 0; i < btns.length;i++)
			{
				var btn : ImageMenuButton = ImageMenuButton(btns[i]);
				btn.selected = false;
				//btn.alpha = 1;				
				btn.image.color = 0xFFFFFF;
			}
		}


		private function menuItemTapped(event:ImageMenuEvent):void
		{
			var target : ImageMenuButton = ImageMenuButton(event.currentTarget);
			for(var i:Number = 0; i < btns.length;i++)
			{
				var btn : ImageMenuButton = ImageMenuButton(btns[i]);
				if (btn == target)
				{
					btn.selected = true;
					//btn.alpha = 1;
					btn.image.color = 0xFFFFFF;
				}
				else
				{
					btn.selected = false;
					//btn.alpha = 0.35;
					btn.image.color = 0x888888;
				}
			}

		}


		public function get padding():Number
		{
			return _padding;
		}

		public function set padding(value:Number):void
		{
			_padding = value;

			destroy();

			updateDisplayList();
		}
	}
}
