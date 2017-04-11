/**
 * Created by russellmilburn on 20/08/15.
 */
package com.tro.chromecast.views
{

	import com.tro.chromecast.models.vos.CastAppsVo;
	import com.tro.chromecast.models.vos.DeviceTypeVo;
	import com.tro.chromecast.views.components.SwipeControl;
	import com.tro.chromecast.views.components.TVDisplay;
	import com.tro.chromecast.views.components.devicedisplay.DeviceDisplay;
	import com.tro.chromecast.views.components.imagemenu.ImageMenu;
	import com.tro.chromecast.views.components.imagemenu.ImageMenuEvent;
	import com.tro.chromecast.views.components.mediadisplay.MediaDisplaySprite;

	import starling.display.Image;

	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.utils.HAlign;

	public class BackgroundTasksView extends View
	{
		private var _swipeControl : SwipeControl;
		private var _gradient : Sprite;
		private var _tvDisplay:TVDisplay;
		private var _appMenu : ImageMenu;
		private var _videoDisplay : Sprite;

		private var _deviceDisplay : DeviceDisplay;

		private var _dataVo : CastAppsVo;
		private var _instructionsText:TextField;
		
		public function BackgroundTasksView()
		{
			super();
		}


		override protected function onViewInit():void
		{
			_swipeControl = new SwipeControl(0xff0000);
			addChild(_swipeControl);

			_swipeControl.setRectWidth(this.stage.stageWidth);
			_swipeControl.setRectHeight(this.stage.stageHeight);

			super.onViewInit();

		}

		override protected function initStageAssets():void
		{
			_gradient = getTexturesSprite("gradient");
			_gradient.y = stage.stageHeight - _gradient.height;
			_gradient.touchable = false;

			deviceDisplay = new DeviceDisplay();
			deviceDisplay.laptop.setBackgroundImage(getTexture("Device" + DeviceTypeVo.LAPTOP));
			deviceDisplay.mobile.setBackgroundImage(getTexture("Device" + DeviceTypeVo.MOBILE));
			deviceDisplay.tablet.setBackgroundImage(getTexture("Device" + DeviceTypeVo.TABLET));
			deviceDisplay.touchable = false;

			appMenu = new ImageMenu();
			appMenu.padding = 55;
			appMenu.addEventListener(ImageMenuEvent.ON_UPDATE, onUpdateHandler);

			_tvDisplay  = new TVDisplay();
			_tvDisplay.tvDisplayVo = getContentVo();
			_tvDisplay.touchable = false;
			_tvDisplay.x = (stage.stageWidth - _tvDisplay.width) / 2 ;
			_tvDisplay.y = 50;

			_instructionsText = new TextField(1720, 150, "blah");
			_instructionsText.touchable = false;
			_instructionsText.autoSize = TextFieldAutoSize.VERTICAL;
			_instructionsText.hAlign = HAlign.CENTER;
			_instructionsText.fontName = "Roboto";
			_instructionsText.fontSize = 50;
			_instructionsText.text = "While casting, you’re free to use your device normally. \nBelow are some examples you can try.";
			_instructionsText.color = 0xffffff;
			_instructionsText.x = (stage.stageWidth - _instructionsText.width) / 2;


			addChild(_tvDisplay);
			addChild(deviceDisplay);
			addChild(_gradient);
			addChild(_instructionsText);
			addChild(appMenu);



			dispatchEvent(new ViewEvent(ViewEvent.ON_VIEW_INIT_COMPLETE));
		}




		private function onUpdateHandler(event:ImageMenuEvent):void
		{
			appMenu.x = (stage.stageWidth - appMenu.width) / 2;
			appMenu.y = stage.stageHeight - appMenu.height - 25;
			_instructionsText.y = (stage.stageHeight -  appMenu.height - 25 - _instructionsText.height- 25);
		}

		override public function prepareViewIn(direction:String):void
		{
			super.prepareViewIn(direction);
			_tvDisplay.updateScreenImage(assetManager.getTexture("TVReadyToCast"));
			initVideoWithinView();

		}

		private function initVideoWithinView() : void
		{
			videoDisplay = new Sprite();
			videoDisplay.x = tvContentArea.x;
			videoDisplay.y = tvContentArea.y;
			videoDisplay.touchable = false;

			addChildAt(videoDisplay, 3);

		}

		public function addVideoImage(videoImage : Image ) : void
		{
			videoImage.x = 0;
			videoImage.y = 0;
			videoImage.width = tvContentArea.width;
			videoImage.height = tvContentArea.height;

			_videoDisplay.addChild(videoImage);
		}

		public function reset():void
		{

			if (videoDisplay != null)
			{
				removeChild(videoDisplay)
			}

			deviceDisplay.reset();
			appMenu.reset();

		}


		public function get deviceDisplay():DeviceDisplay
		{
			return _deviceDisplay;
		}

		public function set deviceDisplay(value:DeviceDisplay):void
		{
			_deviceDisplay = value;
		}


		public function get videoDisplay():Sprite
		{
			return _videoDisplay;
		}

		public function set videoDisplay(value:Sprite):void
		{
			_videoDisplay = value;
		}

		public function get appMenu():ImageMenu
		{
			return _appMenu;
		}

		public function set appMenu(value:ImageMenu):void
		{
			_appMenu = value;
		}


		public function get dataVo():CastAppsVo
		{
			return _dataVo;
		}

		public function set dataVo(value:CastAppsVo):void
		{
			_dataVo = value;
		}
	}
}
