/**
 * Created by russellmilburn on 27/09/15.
 */
package com.tro.chromecast.views.mediators
{

	import com.greensock.TweenMax;
	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.models.AssetStorageEvent;
	import com.tro.chromecast.views.ViewLoader;

	public class ViewLoaderMediator extends BaseMediator
	{
		[Inject]
		public var view : ViewLoader;

		public function ViewLoaderMediator()
		{
			super();
		}


		override public function initialize():void
		{
			super.initialize();

			addContextListener(AssetStorageEvent.ON_LOADING_MODELS, onLoadingModels);
			addContextListener(AssetStorageEvent.ON_MODEL_LOADED, onModelsLoaded);
			addContextListener(AssetStorageEvent.ON_LOADING_ASSETS, onLoadingAsset);
			addContextListener(AppEvent.INIT_VIEWS, onInitViews);
			addContextListener(AppEvent.START_UP_COMPLETE, onStartUpComplete);
		}

		private function onStartUpComplete(event : AppEvent):void
		{
			setInfoLabelText("Start up complete");

			TweenMax.to(view, 0.5, {autoAlpha: 0});
		}

		private function onInitViews(event : AppEvent):void
		{
			setInfoLabelText("Initializing views");
		}

		private function onLoadingAsset(event : AssetStorageEvent):void
		{
			setInfoLabelText("Loading assets");
		}

		private function onModelsLoaded(event : AssetStorageEvent):void
		{
			setInfoLabelText("Loading 3D models complete");
		}

		private function onLoadingModels(event : AssetStorageEvent):void
		{
			setInfoLabelText("Loading 3D models");
		}

		private function setInfoLabelText(value : String) : void
		{
			view.infoText.text = value;
			view.infoText.x = (view.stage.stageWidth - view.infoText.width) / 2;
		}
	}
}
