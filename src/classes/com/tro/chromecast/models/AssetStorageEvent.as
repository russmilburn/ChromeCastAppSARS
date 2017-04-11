/**
 * Created by russellmilburn on 23/07/15.
 */
package com.tro.chromecast.models
{

	import flash.events.Event;

	public class AssetStorageEvent extends Event
	{
		public static const ON_LOADING_MODELS : String = "onLoadingModels";
		public static const ON_LOADING_ASSETS : String = "onLoadingAssets";
		public static const ON_MODEL_LOADED : String = "onModelLoaded";
		public static const ON_FONT_LOADED : String = "onFontLoaded";
		public static const ON_ASSETS_LOADED : String = "onAssetLoaded";

		public function AssetStorageEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}


		override public function clone():Event
		{
			var evt : AssetStorageEvent = new AssetStorageEvent(type, bubbles, cancelable);
			return evt;
		}
	}
}
