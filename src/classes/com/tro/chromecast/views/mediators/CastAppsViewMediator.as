/**
 * Created by russellmilburn on 10/08/15.
 */
package com.tro.chromecast.views.mediators
{

	import com.greensock.TweenMax;
	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.models.ApplicationModel;
	import com.tro.chromecast.models.ApplicationModelEvent;
	import com.tro.chromecast.models.ContentModel;
	import com.tro.chromecast.models.vos.CastAppsVo;
	import com.tro.chromecast.models.vos.CastAppsVo;
	import com.tro.chromecast.models.vos.TrackingVo;
	import com.tro.chromecast.views.CastAppsView;
	import com.tro.chromecast.views.ViewEvent;
	import com.tro.chromecast.views.components.PopUpMagnifierEvent;
	import com.tro.chromecast.views.components.SwipeControlEvent;
	import com.tro.chromecast.views.components.devicedisplay.videocontrols.VideoControlPanel;
	import com.tro.chromecast.views.components.devicedisplay.videocontrols.VideoControlPanelEvent;
	import com.tro.chromecast.views.components.imagemenu.ImageMenuEvent;
	import com.tro.chromecast.views.components.mediadisplay.MediaDisplayEvent;
	import com.tro.chromecast.views.components.mediadisplay.MediaDisplaySprite;

	import flash.geom.Rectangle;

	import org.gestouch.events.GestureEvent;

	import starling.display.Sprite;

	import starling.textures.Texture;
	
	import com.gamua.flox.Flox;

	public class CastAppsViewMediator extends BaseMediator
	{
		

		[Inject]
		public var view : CastAppsView;

		[Inject]
		public var contentModel : ContentModel;

		[Inject]
		public var appModel : ApplicationModel;
		
		private var dataProvider : Array;
		private var selectedVo : CastAppsVo;
		private var selectedDevice : String;
		private var _wasPlaying : Boolean;
		private var hasToResetState : Boolean = false;
		private var mediaDisplaySprite : MediaDisplaySprite;
		private var numPlayed : int;
		private var hasVideoInitialized:Boolean = false;
		private var popupTween : TweenMax;


		public function CastAppsViewMediator()
		{
			super();
		}


		override public function initialize():void
		{
			super.initialize();

			view.logger = super.logger;
			view.assetManager = assetStore.assetManager;

			dataProvider = new Array();

			view.addEventListener(SwipeControlEvent.SWIPE_LEFT, onSwipeLeft);
			view.addEventListener(SwipeControlEvent.SWIPE_RIGHT, onSwipeRight);

			addContextListener(ApplicationModelEvent.ON_UPDATE_DEVICE, onUpdateDevice);

			view.addEventListener(ViewEvent.ON_VIEW_INIT_COMPLETE, onViewInitComplete);
			view.addEventListener(ViewEvent.ON_VIEW_IN_COMPLETE, onViewInComplete);
			view.addEventListener(ViewEvent.ON_VIEW_OUT_COMPLETE, onViewOutComplete);

		}

		private function onViewInitComplete(event:ViewEvent):void
		{

			view.appMenu.addEventListener(ImageMenuEvent.ON_TAP, onAppMenuTap);
			view.popUpMagnifier.addEventListener(PopUpMagnifierEvent.ON_BUTTON_TAP, onPopUpTapHandler);

			view.deviceDisplay.addEventListener(VideoControlPanelEvent.ON_PLAY_BTN_TAP, onPlayButtonTap);
			view.deviceDisplay.addEventListener(VideoControlPanelEvent.ON_PAUSE_BTN_TAP, onPauseButtonTap);
			view.deviceDisplay.addEventListener(VideoControlPanelEvent.ON_SCRUB_START, onSeekStart);
			view.deviceDisplay.addEventListener(VideoControlPanelEvent.ON_SCRUB, onSeek);
			view.deviceDisplay.addEventListener(VideoControlPanelEvent.ON_SCRUB_END, onSeekEnd);
			view.deviceDisplay.addEventListener(VideoControlPanelEvent.ON_VOLUME_UP, onVolumeUp);
			view.deviceDisplay.addEventListener(VideoControlPanelEvent.ON_VOLUME_DOWN, onVolumeDown);


			updateImageMenu(contentModel.castAppsData);

		}


		private function onViewInComplete(event:ViewEvent):void
		{
			numPlayed = 0;
			var rect : Rectangle = view.deviceDisplay.getCurrentDeviceScreenSize();
			mediaDisplaySprite = new MediaDisplaySprite(rect.width, rect.height);
			mediaDisplaySprite.addEventListener(MediaDisplayEvent.ON_VIDEO_PLAYER_INIT, onLoadComplete);
			mediaDisplaySprite.addEventListener(MediaDisplayEvent.ON_VIDEO_COMPLETE, onVideoComplete);
			mediaDisplaySprite.addEventListener(MediaDisplayEvent.ON_VIDEO_PLAYHEAD_TIME_CHANGE, onUpdatePlayhead);
			mediaDisplaySprite.addEventListener(MediaDisplayEvent.ON_PLAY, onVideoPlay);
			mediaDisplaySprite.addEventListener(MediaDisplayEvent.ON_PAUSE, onVideoPause);
		}


		private function updateImageMenu(a : Array) : void
		{
			dataProvider = a;

			for(var i:int = 0; i < dataProvider.length; i ++)
			{
				var vo : CastAppsVo = CastAppsVo(dataProvider[i]);
				vo.texture = view.assetManager.getTexture(vo.textureId);

			}

			view.appMenu.dataProvider = dataProvider;
		}

		private function onUpdateDevice(event : ApplicationModelEvent):void
		{
			selectedDevice = event.device;
			view.deviceDisplay.changeDevice(selectedDevice);
			view.positionPopUp();
			view.loaderDisplay.x = view.deviceDisplay.currentDevice.x;
			view.loaderDisplay.y = view.deviceDisplay.currentDevice.y;
			view.loaderDisplay.dimensions = view.deviceDisplay.currentDevice.screenSize;
		}

		private function onAppMenuTap(event:ImageMenuEvent):void
		{

			if (selectedVo == event.vo)
			{
				return;
			}

			if (hasToResetState)
			{
				resetState();
			}

			if (CastAppsVo(event.vo).appId == "moreApps")
			{
				hasToResetState = true;
				selectedVo = CastAppsVo(event.vo);
				showMoreApps();
				return;
			}

			selectedVo = CastAppsVo(event.vo);


			if (popupTween != null)
			{
				popupTween.pause();
				popupTween = null;
				view.popUpMagnifier.alpha = 0;
				view.popUpMagnifier.visible = false;
			}

			view.popUpMagnifier.enablePopUpButton();
			popupTween = TweenMax.to(view.popUpMagnifier, 1, {delay:3, autoAlpha:1});
			
			view.tvDisplay.titleText = "Press the cast button to watch it on TV";

			mediaDisplaySprite.load(selectedVo.contentPath);
			mediaDisplaySprite.resume();

			if (mediaDisplaySprite.getVideoImage()!= null)
			{
				view.deviceDisplay.playVideoOnCurrentDevice(mediaDisplaySprite.getVideoImage());
				mediaDisplaySprite.getVideoImage().visible = true;
			}

			var evt : AppEvent = new AppEvent(AppEvent.SET_CAST_APP_VO);
			evt.castAppVo = selectedVo;
			dispatch(evt);
			
			var trackingVo : TrackingVo = new TrackingVo();
			trackingVo.code = appModel.currentSection.sectionHighlightName + "_SELECT_VIDEO";
			trackingVo.parameter = "Video";
			trackingVo.value = selectedVo.appId;
			
			var floxEvt : AppEvent = new AppEvent(AppEvent.TRACK_INTERACTION);
			floxEvt.trackingVo = trackingVo;
			dispatch(floxEvt);
		}


		private function showMoreApps():void
		{
			resetState();
			TweenMax.to(view.deviceDisplay, 1, {y:450});
			view.tvDisplay.titleText = "";
			view.tvDisplay.updateScreenImage(view.getTexture("MoreAppsScreen"));
			hasToResetState = true;
		}

		private function updateTextFieldPos() : void
		{
			view.instructionsText.x = (view.stage.stageWidth - view.instructionsText.width) / 2;
		}


		private function onPopUpTapHandler(event:PopUpMagnifierEvent):void
		{
			event.stopPropagation();
			if (hasVideoInitialized == false)
			{
				return;
			}

			view.gradientShort.visible = false;
			view.gradient.visible = true;
			view.instructionsText.text = "Your device works just like a remote. Tap on it";
			updateTextFieldPos();

			view.addVideoImage(mediaDisplaySprite.getVideoImage());
			mediaDisplaySprite.getVideoImage().visible = true;

			if (numPlayed >= 3)
			{
				mediaDisplaySprite.seek(0);
				mediaDisplaySprite.isPlaying = true;
				mediaDisplaySprite.resume();
			}

			//Add screen Texture to Device
			var screenTextureId : String = selectedVo.appId + "ScreenImage" + "Laptop";
			var screenTexture : Texture = view.assetManager.getTexture(screenTextureId);
			view.deviceDisplay.updateScreenOnCurrentDevice(screenTexture);

			//Hide Cast Button
			TweenMax.to(view.popUpMagnifier, 1, {autoAlpha:0});

			//Display text "Click on the device to use as remote Controls"
			view.instructionsText.visible = true;

			hasToResetState = true;

			// add tap handler to device
			view.deviceDisplay.tap.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onDeviceTap);


		}



		private function onDeviceTap(event:GestureEvent):void
		{
			view.instructionsText.text = "Fast forward, rewind or pause, and change the volume.";
			updateTextFieldPos();

			//remove tap handler on device
			view.deviceDisplay.tap.removeEventListener(GestureEvent.GESTURE_RECOGNIZED, onDeviceTap);

			var xPos:Number = 0 - (view.stage.stageWidth * 0.25);
			var yPos:Number = 0 - (view.stage.stageHeight  * 0.50);

			//fade in controls
			var controlPanel : VideoControlPanel = view.deviceDisplay.controlPanel;
			TweenMax.to(controlPanel, 1, {autoAlpha: 1});
			TweenMax.to(view.zoomContainer, 1, {x:xPos, y:yPos, scaleX:1.5, scaleY:1.5});
		}



		private function resetState():void
		{
			logger.info("resetState");
			if (view.popUpMagnifier.visible == true)
			{
				//logger.info("resetState.popUpMagnifier");
				if (popupTween != null)
				{
					popupTween.pause();
					popupTween = null;
				}
				view.popUpMagnifier.disablePopUpButton();
				TweenMax.to(view.popUpMagnifier, 0.5, {autoAlpha:0});
			}

			var controlPanel : VideoControlPanel = view.deviceDisplay.controlPanel;
			if (controlPanel.visible == true)
			{
				//logger.info("resetState.controlPanel");
				TweenMax.to(controlPanel, 0.5, {autoAlpha: 0});
			}

			if (view.zoomContainer.x != 0)
			{
				//logger.info("resetState.zoomContainer");
				TweenMax.to(view.zoomContainer, 0.5, {x:0, y:0, scaleX:1, scaleY:1});
			}

			if (view.deviceDisplay.y != 0 )
			{
				//logger.info("resetState.deviceDisplay");
				TweenMax.to(view.deviceDisplay, 0.5, { y:0 } );
				view.popUpMagnifier.disablePopUpButton();
			}

			view.tvDisplay.titleText = "Press the cast button to watch it on TV";
			view.tvDisplay.removeScreenImage();

			view.deviceDisplay.currentDevice.removeScreenTexture();
			view.instructionsText.text = "";
			updateTextFieldPos();

			if (mediaDisplaySprite.getVideoImage() != null)
			{
				mediaDisplaySprite.getVideoImage().visible = false;
				mediaDisplaySprite.pause();
			}

			view.deviceDisplay.tap.removeEventListener(GestureEvent.GESTURE_RECOGNIZED, onDeviceTap);

			hasToResetState = false;
			view.gradientShort.visible = true;
			view.gradient.visible = false;
		}

		private function onVolumeDown(event:VideoControlPanelEvent):void
		{
			event.stopPropagation();
			mediaDisplaySprite.volume = event.volumeLevel;
		}

		private function onVolumeUp(event:VideoControlPanelEvent):void
		{
			event.stopPropagation();
			mediaDisplaySprite.volume = event.volumeLevel;
		}


		private function onSeekStart(event:VideoControlPanelEvent):void
		{
			event.stopPropagation();
			_wasPlaying = mediaDisplaySprite.isPlaying;
			if (mediaDisplaySprite.isPlaying)
			{
				mediaDisplaySprite.pause();
			}
		}

		private function onSeek(event:VideoControlPanelEvent):void
		{
			event.stopPropagation();
			mediaDisplaySprite.seekByPercent(event.scrubPos);
		}

		private function onSeekEnd(event:VideoControlPanelEvent):void
		{
			event.stopPropagation();
			if (_wasPlaying)
			{
				mediaDisplaySprite.resume();
			}
			else
			{
				mediaDisplaySprite.pause();
			}
		}



		private function onPauseButtonTap(event:VideoControlPanelEvent):void
		{
			event.stopPropagation();
			mediaDisplaySprite.isPlaying = false;
		}

		private function onPlayButtonTap(event:VideoControlPanelEvent):void
		{
			event.stopPropagation();
			mediaDisplaySprite.isPlaying = true;
		}

		private function onUpdatePlayhead(event:MediaDisplayEvent):void
		{
			if (view.loaderDisplay.visible == true)
			{
				view.loaderDisplay.visible = false;
			}
			var pc : Number = event.playheadTime / event.totalTime;
			updateScrubHandle(pc);
		}

		private function updateScrubHandle(percent : Number) : void
		{
			getVideoControlPanel().updateScrubHandlePos(percent);
		}


		private function onVideoPlay(event:MediaDisplayEvent):void
		{
			getVideoControlPanel().isPlaying = true;
			var pc : Number = event.playheadTime / event.totalTime;
			updateScrubHandle(pc);
		}

		private function onVideoPause(event:MediaDisplayEvent):void
		{
			getVideoControlPanel().isPlaying = false;
			var pc : Number = event.playheadTime / event.totalTime;
			updateScrubHandle(pc);
		}


		private function onStartPlaying(event:MediaDisplayEvent):void
		{
			//logger.info("onStartPlaying");
			getVideoControlPanel().isPlaying = true;
			var pc : Number = event.playheadTime / event.totalTime;
			updateScrubHandle(pc);
		}

		private function onVideoComplete(event:MediaDisplayEvent):void
		{
			//logger.info("onVideoComplete");
			numPlayed ++;
			if (numPlayed <= 3)
			{
				mediaDisplaySprite.seek(0);
				mediaDisplaySprite.isPlaying = true;
				mediaDisplaySprite.resume();
			}

		}

		private function onLoadComplete(event:MediaDisplayEvent):void
		{
			//logger.info("onLoadComplete");
			hasVideoInitialized = true;
			view.addVideoImage(mediaDisplaySprite.getVideoImage());
			view.deviceDisplay.playVideoOnCurrentDevice(mediaDisplaySprite.getVideoImage());

		}

		private function getVideoControlPanel() : VideoControlPanel
		{
			return view.deviceDisplay.controlPanel;
		}



		private function onViewOutComplete(event:ViewEvent):void
		{
			selectedVo = null;
			view.reset();
			resetState();
			mediaDisplaySprite.removeEventListeners();
			mediaDisplaySprite.reset();
			mediaDisplaySprite = null;
			hasVideoInitialized = false;
		}


	}
}
