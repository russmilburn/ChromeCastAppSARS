/**
 * Created by russellmilburn on 20/08/15.
 */
package com.tro.chromecast.views.mediators
{

	import com.tro.chromecast.models.ApplicationModelEvent;
	import com.tro.chromecast.models.ContentModel;
	import com.tro.chromecast.models.ContentModelEvent;
	import com.tro.chromecast.models.vos.BackgroundTaskVo;
	import com.tro.chromecast.models.vos.CastAppsVo;
	import com.tro.chromecast.models.vos.DeviceTypeVo;
	import com.tro.chromecast.views.BackgroundTasksView;
	import com.tro.chromecast.views.ViewEvent;
	import com.tro.chromecast.views.components.SwipeControlEvent;
	import com.tro.chromecast.views.components.imagemenu.ImageMenuEvent;
	import com.tro.chromecast.views.components.mediadisplay.MediaDisplayEvent;
	import com.tro.chromecast.views.components.mediadisplay.MediaDisplaySprite;

	import starling.textures.Texture;
	import flash.geom.Rectangle;

	public class BackgroundTasksViewMediator extends BaseMediator
	{
		[Inject]
		public var view : BackgroundTasksView;

		[Inject]
		public var contentModel : ContentModel;

		private var selectedDevice : String;
		private var selectedDataVo : CastAppsVo;

		private var dataProvider : Array;
		private var mediaDisplaySprite:MediaDisplaySprite;
		private var numPlayed:int;


		public function BackgroundTasksViewMediator()
		{
			super();
		}


		override public function initialize():void
		{
			super.initialize();

			view.logger = super.logger;

			view.assetManager = assetStore.assetManager;

			selectedDataVo = contentModel.currentCasAppVo;

			addContextListener(ApplicationModelEvent.ON_UPDATE_DEVICE, onUpdateDevice);
			addContextListener(ContentModelEvent.ON_UPDATE_CAST_APP_VO, onUpdateContentVo);

			view.addEventListener(SwipeControlEvent.SWIPE_LEFT, onSwipeLeft);
			view.addEventListener(SwipeControlEvent.SWIPE_RIGHT, onSwipeRight);

			view.addEventListener(ViewEvent.ON_VIEW_INIT_COMPLETE, onViewInitComplete);
			view.addEventListener(ViewEvent.ON_VIEW_OUT_COMPLETE, onViewOutComplete);
			view.addEventListener(ViewEvent.ON_VIEW_IN_COMPLETE, onViewInComplete);
			view.addEventListener(ViewEvent.ON_PREPARE_VIEW_IN, onPrepareViewIn);


		}

		private function onPrepareViewIn(event:ViewEvent):void
		{
			numPlayed = 0;
			var screenTextureId : String = selectedDataVo.appId + "ScreenImage" + "Laptop";
			var screenTexture : Texture = view.assetManager.getTexture(screenTextureId);

			view.deviceDisplay.currentDevice.updateScreen(screenTexture);

			var rect : Rectangle = view.deviceDisplay.getCurrentDeviceScreenSize();
			mediaDisplaySprite = new MediaDisplaySprite(rect.width, rect.height);
			mediaDisplaySprite.addEventListener(MediaDisplayEvent.ON_VIDEO_PLAYER_INIT, onLoadComplete);
			mediaDisplaySprite.addEventListener(MediaDisplayEvent.ON_VIDEO_COMPLETE, onVideoComplete);
		}

		private function onLoadComplete(event:MediaDisplayEvent):void
		{
			view.addVideoImage(mediaDisplaySprite.getVideoImage());
		}

		private function onVideoComplete(event:MediaDisplayEvent):void
		{
			numPlayed ++;
			if (numPlayed <= 3)
			{
				mediaDisplaySprite.seek(0);
				mediaDisplaySprite.isPlaying = true;
				mediaDisplaySprite.resume();
			}
		}



		private function onViewInComplete(event:ViewEvent):void
		{
			//logger.info("selectedDataVo.contentPath: " + selectedDataVo.contentPath);
			mediaDisplaySprite.load(selectedDataVo.contentPath);
			mediaDisplaySprite.resume();
		}

		private function onViewInitComplete(event:ViewEvent):void
		{
			view.appMenu.addEventListener(ImageMenuEvent.ON_TAP, onAppMenuTap);
			updateImageMenu(contentModel.backgroundTasksData);
		}

		private function onAppMenuTap(event:ImageMenuEvent):void
		{
			var vo : BackgroundTaskVo = BackgroundTaskVo(event.vo);
			var contentID : String = vo.contentId + DeviceTypeVo.LAPTOP;
			var texture : Texture = view.assetManager.getTexture(contentID);
			view.deviceDisplay.currentDevice.updateScreen(texture);
		}


		private function updateImageMenu(a : Array) : void
		{
			dataProvider = a;

			for(var i:int = 0; i < dataProvider.length; i ++)
			{
				var vo : BackgroundTaskVo = BackgroundTaskVo(dataProvider[i]);
				vo.texture = view.assetManager.getTexture(vo.textureId);
			}

			view.appMenu.dataProvider = dataProvider;
		}

		private function onUpdateContentVo(event : ContentModelEvent):void
		{
			//logger.info("onUpdateContentVo: " + contentModel.currentCasAppVo.contentPath);
			selectedDataVo = contentModel.currentCasAppVo;

		}

		private function onUpdateDevice(event : ApplicationModelEvent):void
		{
			selectedDevice = event.device;
			view.deviceDisplay.changeDevice(selectedDevice);
		}

		private function onViewOutComplete(event:ViewEvent):void
		{
			mediaDisplaySprite.removeEventListeners();
			mediaDisplaySprite.reset();
			view.reset();
		}



		
	}
}
