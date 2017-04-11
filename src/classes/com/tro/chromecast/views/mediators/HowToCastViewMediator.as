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
	import com.tro.chromecast.models.vos.DeviceTypeVo;
	import com.tro.chromecast.models.vos.TrackingVo;
	import com.tro.chromecast.views.HowToCastView;
	import com.tro.chromecast.views.ViewEvent;
	import com.tro.chromecast.views.components.PopUpMagnifierEvent;
	import com.tro.chromecast.views.components.SwipeControlEvent;
	import com.tro.chromecast.views.components.devicedisplay.videocontrols.VideoControlPanel;
	import com.tro.chromecast.views.components.imagemenu.ImageMenuEvent;
	import com.tro.chromecast.views.components.mediadisplay.MediaDisplayEvent;
	import com.tro.chromecast.views.components.mediadisplay.MediaDisplaySprite;

	import flash.geom.Rectangle;

	import starling.textures.Texture;

	public class HowToCastViewMediator extends BaseMediator
	{


		[Inject]
		public var view : HowToCastView;

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

		public function HowToCastViewMediator()
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

			updateImageMenu(contentModel.castAppsData);

		}


		private function onViewInComplete(event:ViewEvent):void
		{
			numPlayed = 0;
			var rect : Rectangle = view.deviceDisplay.getCurrentDeviceScreenSize();
			mediaDisplaySprite = new MediaDisplaySprite(rect.width, rect.height);
			mediaDisplaySprite.addEventListener(MediaDisplayEvent.ON_VIDEO_PLAYER_INIT, onLoadComplete);
			mediaDisplaySprite.addEventListener(MediaDisplayEvent.ON_VIDEO_COMPLETE, onVideoComplete);
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

			view.instructionsText.text = "Simply press the icon to cast your favourite entertainment \nfrom your mobile device straight to the TV";
			
			view.swipeToContinue.visible = false;
			
			updateTextFieldPos();

			if (popupTween != null)
			{
				popupTween.pause();
				popupTween = null;
				view.popUpMagnifier.alpha = 0;
				view.popUpMagnifier.visible = false;
			}
			
			view.popUpMagnifier.enablePopUpButton();
			TweenMax.to(view.popUpMagnifier, 1, {delay: 3, autoAlpha:1});

			mediaDisplaySprite.load(selectedVo.contentPath);
			mediaDisplaySprite.resume();

			if (mediaDisplaySprite.getVideoImage()!= null)
			{
				view.deviceDisplay.playVideoOnCurrentDevice(mediaDisplaySprite.getVideoImage());
				mediaDisplaySprite.getVideoImage().visible = true;
			}
			
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
			
			selectedVo = null;
			
			TweenMax.to(view.deviceDisplay, 1, { y:450 } );
			
			view.instructionsText.text = "";
			
			view.swipeToContinue.visible = false;
			
			view.tvDisplay.updateScreenImage(view.getTexture("MoreAppsScreen"));
			
			hasToResetState = true;
		}
		
		private function updateTextFieldPos() : void
		{
			if (view.instructionsText.text == "Too easy!")
			{
				view.instructionsText.x = (view.stage.stageWidth - view.instructionsText.width) / 2 - 250;
			}
			else
			{
				view.instructionsText.x = (view.stage.stageWidth - view.instructionsText.width) / 2;
			}
		}
		
		private function onPopUpTapHandler(event:PopUpMagnifierEvent):void
		{
			event.stopPropagation();
			
			if (hasVideoInitialized == false)
			{
				return;
			}
			
			view.gradient.visible = true;
			view.addVideoImage(mediaDisplaySprite.getVideoImage());
			
			mediaDisplaySprite.getVideoImage().visible = true;
			
			//Add screen Texture to Device
			var screenTextureId : String = selectedVo.appId + "ScreenImage" + DeviceTypeVo.LAPTOP;
			var screenTexture : Texture = view.assetManager.getTexture(screenTextureId);
			view.deviceDisplay.updateScreenOnCurrentDevice(screenTexture);

			//Hide Cast Button
			view.popUpMagnifier.disablePopUpButton();
			TweenMax.to(view.popUpMagnifier, 1, {autoAlpha:0});
			TweenMax.to(view.deviceDisplay, 1, {y:450});

			//Display text "Click on the device to use as remote Controls"
			view.instructionsText.text = "Too easy!";
			view.instructionsText.visible = true;
			
			view.swipeToContinue.visible = true;
			hasToResetState = true;
			
			updateTextFieldPos();

		}

		private function resetState():void
		{
			//logger.info("resetState");
			
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
			
			if (view.deviceDisplay.y != 0)
			{
				//logger.info("resetState.deviceDisplay");
				TweenMax.to(view.deviceDisplay, 0.5, {y:0});
			}
			
			view.tvDisplay.removeScreenImage();
			view.tvDisplay.updateScreenImage(view.assetManager.getTexture("TVReadyToCast"));
			
			view.deviceDisplay.currentDevice.removeScreenTexture();
			
			view.instructionsText.text = "Open an app that works with Chromecast";
			view.instructionsText.visible = true;
			
			view.swipeToContinue.visible = false;
			
			updateTextFieldPos();
			
			if (mediaDisplaySprite.getVideoImage() != null)
			{
				mediaDisplaySprite.getVideoImage().visible = false;
				mediaDisplaySprite.pause();
			}
			
			hasToResetState = false;
			view.gradient.visible = true;
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
