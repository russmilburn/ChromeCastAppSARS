/**
 * Created by russellmilburn on 25/09/15.
 */
package com.tro.chromecast.views
{

	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	import com.tro.chromecast.views.components.devicedisplay.videocontrols.Background;

	import starling.display.Canvas;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.utils.AssetManager;

	public class ViewLoader extends Sprite
	{
		private var _assetManager : AssetManager;
		private var _infoText:TextField;
		private var _background : Canvas;

		public function ViewLoader()
		{
			super();

			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

			_background = new Canvas();
			_background = new Canvas();
			_background.beginFill(0xffffff, 1);
			_background.drawRectangle(0, 0, stage.stageWidth, stage.stageHeight);
			addChild(_background);

			init();

			//visible = false;
		}

		private function init():void
		{
			_assetManager = new AssetManager();

			_assetManager.enqueue("/assets/fonts/Roboto.fnt");
			_assetManager.enqueue("/assets/fonts/Roboto.png");
			_assetManager.enqueue("/assets/textures/AppLoaderAssets.atf");
			_assetManager.enqueue("/assets/textures/AppLoaderAssets.xml");

			_assetManager.loadQueue(onLoadProgress);

		}

		private function onLoadProgress(ratio : Number):void
		{
			if (ratio == 1.0)
			{
				onLoadComplete();
			}
		}

		private function onLoadComplete():void
		{
			var imageOuter : Image = new Image(_assetManager.getTexture("Outer"));
			addChild(imageOuter);

			imageOuter.pivotX = imageOuter.width / 2;
			imageOuter.pivotY = imageOuter.height / 2;

			imageOuter.x = (stage.stageWidth) / 2;
			imageOuter.y = (stage.height / 2) - 100;
			
			var imageInner : Image = new Image(_assetManager.getTexture("Inner"));
			addChild(imageInner);

			imageInner.pivotX = imageInner.width / 2;
			imageInner.pivotY = imageInner.height / 2;

			imageInner.x = (stage.stageWidth) / 2;
			imageInner.y = (stage.height / 2) - 80;




			TweenMax.to(imageOuter, 45, {rotation: 360, repeat: -1, ease:Linear.easeNone});


			_infoText = new TextField(1000, 100, "blah");
			_infoText.touchable = false;
			_infoText.autoSize = TextFieldAutoSize.HORIZONTAL;
			_infoText.fontName = "Roboto";
			_infoText.fontSize = 50;
			_infoText.text = "Loading...";
			_infoText.color = 0x4d88e5;
			_infoText.x = (stage.stageWidth - _infoText.width) / 2;

			_infoText.y = imageOuter.y + imageOuter.height + 50;

			addChild(_infoText);

		}


		public function get infoText():TextField
		{
			return _infoText;
		}

		public function set infoText(value:TextField):void
		{
			_infoText = value;
		}
	}
}
