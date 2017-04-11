/**
 * Created by russellmilburn on 11/08/15.
 */
package com.tro.chromecast.views.components.devicedisplay
{

	import com.tro.chromecast.views.components.*;
	import com.tro.chromecast.views.components.devicedisplay.videocontrols.VideoControlPanel;
	import com.tro.chromecast.views.components.devicedisplay.videocontrols.VideoControlPanelTexturesVo;
	import com.tro.chromecast.views.components.mediadisplay.MediaDisplaySprite;

	import flash.geom.Point;

	import flash.geom.Rectangle;
	import flash.globalization.Collator;
	import flash.utils.getTimer;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.display.BlendMode;

	public class Device extends Sprite
	{
		public var screenSize : Rectangle;
		public var popUpPosition : Point;
		public var screen : Image;



		private var background : Image;


		public function Device()
		{
			super();

		}


		public function setBackgroundImage(texture : Texture) : void
		{
			if (background != null)
			{
				removeChild(background);
			}
			background = new Image(texture);
			addChildAt(background, 0);

		}


		public function removeScreenTexture() : void
		{
			if (screen != null)
			{
				removeChild(screen);
			}

		}

		public function updateScreen(texture : Texture) : void
		{

			if (screen != null)
			{
				removeChild(screen);
			}

			screen = new Image(texture);
			screen.x = screenSize.x;
			screen.y = screenSize.y;
			screen.width = screenSize.width;
			screen.height = screenSize.height;
			screen.blendMode = BlendMode.NONE;
			addChild(screen);
		}


	}
}
