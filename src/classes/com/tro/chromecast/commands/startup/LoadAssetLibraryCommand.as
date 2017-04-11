/**
 * Created by russellmilburn on 06/08/15.
 */
package com.tro.chromecast.commands.startup
{

	import com.tro.chromecast.commands.BaseCommand;
	import com.tro.chromecast.models.AssetStorage;

	public class LoadAssetLibraryCommand extends BaseCommand
	{
		[Inject]
		public var modelStorage : AssetStorage;

		public function LoadAssetLibraryCommand()
		{
			super();
		}


		override public function execute():void
		{
			super.execute();

			logger.info("[START UP 6]: Load Fonts");
			modelStorage.loadAssets();
		}
	}
}
