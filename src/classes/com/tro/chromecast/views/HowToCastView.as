/**
 * Created by russellmilburn on 10/08/15.
 */
package com.tro.chromecast.views
{

	import com.tro.chromecast.models.vos.DeviceTypeVo;
	import com.tro.chromecast.views.components.PopUpMagnifier;
	import com.tro.chromecast.views.components.SwipeControl;
	import com.tro.chromecast.views.components.SwipeToContinue;
	import com.tro.chromecast.views.components.TVDisplay;
	import com.tro.chromecast.views.components.TVDisplayVo;
	import com.tro.chromecast.views.components.devicedisplay.DeviceDisplay;
	import com.tro.chromecast.views.components.devicedisplay.videocontrols.VideoControlPanelTexturesVo;
	import com.tro.chromecast.views.components.imagemenu.ImageMenu;
	import com.tro.chromecast.views.components.imagemenu.ImageMenuEvent;
	import com.tro.chromecast.views.components.mediadisplay.MediaDisplaySprite;

	import starling.display.Image;

	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class HowToCastView extends View
	{

		private var _swipeControl : SwipeControl;
		private var _videoDisplay : Sprite;

		private var _appMenu : ImageMenu;
		private var _deviceDisplay : DeviceDisplay;
		private var _popUpMagnifier : PopUpMagnifier;

		private var _zoomContainer : Sprite;

		private var _gradient : Sprite;
		private var _tvDisplay : TVDisplay;

		private var _instructionsText : TextField;
		private var _swipeToContinue:SwipeToContinue;
		
//		private var _gradientShort:Sprite;

		public function HowToCastView()
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
			_gradient.visible = true;
			
//			_gradientShort  = getTexturesSprite("gradient_short");
//			_gradientShort.y = stage.stageHeight - _gradientShort.height;
//			_gradientShort.touchable = false;

			_zoomContainer = new Sprite();

			_tvDisplay  = new TVDisplay();
			_tvDisplay.tvDisplayVo = getContentVo();
			_tvDisplay.touchable = false;
			_tvDisplay.x = (stage.stageWidth - _tvDisplay.width) / 2 ;
			_tvDisplay.y = 50;
			_tvDisplay.layout = TVDisplay.ALIGN_TOP;

			_tvDisplay.updateScreenImage(assetManager.getTexture("TVReadyToCast"));

			deviceDisplay = new DeviceDisplay();
			deviceDisplay.laptop.setBackgroundImage(getTexture("Device" + DeviceTypeVo.LAPTOP));
			deviceDisplay.mobile.setBackgroundImage(getTexture("Device" + DeviceTypeVo.MOBILE));
			deviceDisplay.tablet.setBackgroundImage(getTexture("Device" + DeviceTypeVo.TABLET));
			deviceDisplay.touchable = false;

			appMenu = new ImageMenu();
			appMenu.y = stage.stageHeight - 500;
			appMenu.padding = 55;
			appMenu.addEventListener(ImageMenuEvent.ON_UPDATE, onUpdateHandler);

			_popUpMagnifier = new PopUpMagnifier();
			_popUpMagnifier.setBackgroundImage(getTexture("PopMagnifierBgLaptop"));
			//_popUpMagnifier.setImageButtonTexture(getTexture("CastIcon"));
			_popUpMagnifier.enablePopUpButton();

			_popUpMagnifier.x = stage.stageWidth - _popUpMagnifier.width - 100;
			_popUpMagnifier.y = 390;

			_popUpMagnifier.visible = false;

			_instructionsText = new TextField(1720, 150, "");
			_instructionsText.touchable = false;
			_instructionsText.autoSize = TextFieldAutoSize.VERTICAL;
			_instructionsText.hAlign = HAlign.CENTER;
			_instructionsText.vAlign = VAlign.CENTER;
			_instructionsText.fontName = "Roboto";
			_instructionsText.fontSize = 50;
			_instructionsText.text = "Open an app that works with Chromecast";
			_instructionsText.color = 0xffffff;
			_instructionsText.x = (stage.stageWidth - _instructionsText.width) / 2;
			_instructionsText.visible = true;
			
			_swipeToContinue = new SwipeToContinue();
			_swipeToContinue.titleField.color = 0xFFFFFF;
			_swipeToContinue.visible = false;
			_swipeToContinue.touchable = false;
			
			zoomContainer.addChild(_tvDisplay);
			zoomContainer.addChild(deviceDisplay);
			
			addChild(zoomContainer);
			addChild(_gradient);
//			addChild(_gradientShort);
			addChild(_instructionsText);
			addChild(_popUpMagnifier);
			addChild(appMenu);
			addChild(_swipeToContinue);
			
			dispatchEvent(new ViewEvent(ViewEvent.ON_VIEW_INIT_COMPLETE));
		}
		
		public function positionPopUp() : void
		{
			_popUpMagnifier.x = deviceDisplay.getPopUpPosition().x;
			_popUpMagnifier.y = deviceDisplay.getPopUpPosition().y;
		}
		
		private function onUpdateHandler(event:ImageMenuEvent):void
		{
			appMenu.x = (stage.stageWidth - appMenu.width) / 2;
			appMenu.y = stage.stageHeight - appMenu.height - 25;
			
			_instructionsText.y = (stage.stageHeight -  appMenu.height - 25 - _instructionsText.height - 75);
			
			_swipeToContinue.x = _instructionsText.x + 725;
			_swipeToContinue.y = _instructionsText.y;
		}
		
		public function reset():void
		{
			_popUpMagnifier.visible = false;
			
			if (videoDisplay != null)
			{
				zoomContainer.removeChild(videoDisplay)
			}
			
			zoomContainer.scaleX = 1;
			zoomContainer.scaleY = 1;
			zoomContainer.x = 0;
			zoomContainer.y = 0;
			deviceDisplay.reset();
			appMenu.reset();
		}
		
		private function initVideo() : void
		{
			var texturesVo : VideoControlPanelTexturesVo = new VideoControlPanelTexturesVo();
			texturesVo.playTexture = getTexture("PlayIcon");
			texturesVo.volumeDownTexture = getTexture("VolumeDown");
			texturesVo.volumeUpTexture = getTexture("VolumeUp");
			texturesVo.scrubHandleTexture = getTexture("ScrubHandle");
			texturesVo.volumeLevelTextures = new Array();
			texturesVo.volumeLevelTextures.push(getTexture("VolumeLevel0"));
			texturesVo.volumeLevelTextures.push(getTexture("VolumeLevel1"));
			texturesVo.volumeLevelTextures.push(getTexture("VolumeLevel2"));
			texturesVo.volumeLevelTextures.push(getTexture("VolumeLevel3"));
			
			deviceDisplay.setControlPanelTextureVo(texturesVo);
			deviceDisplay.initVideo();
		}

		override protected function getContentVo() : TVDisplayVo
		{
			var vo : TVDisplayVo = super.getContentVo();
			//vo.title = "Open an app that works with Chromecast";
			return vo;
		}

		override public function prepareViewIn(direction:String):void
		{
			super.prepareViewIn(direction);

			initVideoWithinView();

		}

		private function initVideoWithinView() : void
		{
			videoDisplay = new Sprite();
			videoDisplay.x = tvContentArea.x;
			videoDisplay.y = tvContentArea.y;
			videoDisplay.touchable = false;

			zoomContainer.addChildAt(videoDisplay, 1);

			initVideo();

		}

		public function get appMenu():ImageMenu
		{
			return _appMenu;
		}

		public function set appMenu(value:ImageMenu):void
		{
			_appMenu = value;
		}

		public function get videoDisplay():Sprite
		{
			return _videoDisplay;
		}

		public function set videoDisplay(value:Sprite):void
		{
			_videoDisplay = value;
		}

		public function addVideoImage(videoImage : Image ) : void
		{
			videoImage.x = 0;
			videoImage.y = 0;
			videoImage.width = tvContentArea.width;
			videoImage.height = tvContentArea.height;

			_videoDisplay.addChild(videoImage);
		}

		public function get deviceDisplay():DeviceDisplay
		{
			return _deviceDisplay;
		}

		public function set deviceDisplay(value:DeviceDisplay):void
		{
			_deviceDisplay = value;
		}

		public function get popUpMagnifier():PopUpMagnifier
		{
			return _popUpMagnifier;
		}

		public function set popUpMagnifier(value:PopUpMagnifier):void
		{
			_popUpMagnifier = value;
		}

		public function get zoomContainer():Sprite
		{
			return _zoomContainer;
		}

		public function set zoomContainer(value:Sprite):void
		{
			_zoomContainer = value;
		}

		public function get instructionsText():TextField
		{
			return _instructionsText;
		}

		public function set instructionsText(value:TextField):void
		{
			_instructionsText = value;
		}

		public function get tvDisplay():TVDisplay
		{
			return _tvDisplay;
		}

		public function set tvDisplay(value:TVDisplay):void
		{
			_tvDisplay = value;
		}

		public function get gradient():Sprite
		{
			return _gradient;
		}

		public function set gradient(value:Sprite):void
		{
			_gradient = value;
		}
		
		public function get swipeToContinue():SwipeToContinue 
		{
			return _swipeToContinue;
		}
		
		public function set swipeToContinue(value:SwipeToContinue):void 
		{
			_swipeToContinue = value;
		}
	}
}
