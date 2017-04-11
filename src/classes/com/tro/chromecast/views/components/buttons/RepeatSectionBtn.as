/**
 * Created by russellmilburn on 02/09/15.
 */
package com.tro.chromecast.views.components.buttons
{

	import org.gestouch.events.GestureEvent;
	import org.gestouch.gestures.TapGesture;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class RepeatSectionBtn extends NavigationBtn
	{
		private var texture : Texture;
		private var repeatLogo : Sprite;

		public function RepeatSectionBtn()
		{
			super();
			labelColour = VISITED_TEXT_COLOUR;
		}

		public function setRepeatTexture(texture : Texture) : void
		{
			this.texture = texture;

			updateDisplayList();
		}


		override protected function updateDisplayList():void
		{
			super.updateDisplayList();


			if (repeatLogo != null)
			{
				removeChild(repeatLogo)
			}

			if (texture != null)
			{
				label.x = 0;
				label.height = 75;

				label.fontSize = 50;
				repeatLogo = new Sprite();
				var image : Image = new Image(texture);
				repeatLogo.addChild(image);
				repeatLogo.y = label.y + label.height + 10;
				repeatLogo.x = (label.width - repeatLogo.width) / 2;


				addChild(repeatLogo)
			}

			background.width = label.width;
			background.height = this.height;
		}

		override public function enable() : void
		{
			tap = new TapGesture(this);
			tap.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onTapHandler);

		}
	}
}
