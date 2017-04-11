/**
 * Created by russellmilburn on 05/10/2015.
 */
package com.tro.chromecast.views.components
{

	import flash.geom.Rectangle;

	import starling.display.Canvas;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class LoaderDisplay extends Sprite
	{
		private var centerIcon : Image;
		private var outerIcon : Image;
		private var background : Canvas;
		private var rect : Rectangle;

		public function LoaderDisplay()
		{
			super();

			background = new Canvas();
			addChild(background);
		}

		public function set iconCenterTexture(texture : Texture ):void
		{
			if (centerIcon != null)
			{
				removeChild(centerIcon);
				centerIcon.dispose();
			}

			centerIcon = new Image(texture);
			centerIcon.pivotX = centerIcon.width / 2;
			centerIcon.pivotY = centerIcon.height / 2;
			updateDisplayList();
		}

		public function set iconOuterTexture(texture : Texture ):void
		{
			if (outerIcon != null)
			{
				removeChild(outerIcon);
				outerIcon.dispose();
			}

			outerIcon = new Image(texture);
			outerIcon.pivotX = outerIcon.width / 2;
			outerIcon.pivotY = outerIcon.height / 2;
			updateDisplayList();
		}

		private function updateDisplayList():void
		{

			if (outerIcon != null)
			{
				removeChild(outerIcon);
				addChild(outerIcon);
			}

			if (centerIcon != null)
			{
				removeChild(centerIcon);
				addChild(centerIcon);
			}

			if (rect != null)
			{
				background.clear();
				background.beginFill(0x000000, 0.5);
				background.drawRectangle(rect.x,rect.y, rect.width, rect.height);
				background.endFill();

				outerIcon.x = rect.x + background.width / 2;
				outerIcon.y = rect.y + background.height / 2;

				centerIcon.x = rect.x + background.width / 2;
				centerIcon.y = rect.y + background.height / 2;
			}
		}

		public function set dimensions(rect : Rectangle) : void
		{
			this.rect = rect;
			updateDisplayList();
		}
	}
}
