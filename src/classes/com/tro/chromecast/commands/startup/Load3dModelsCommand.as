package com.tro.chromecast.commands.startup 
{
	import com.tro.chromecast.commands.BaseCommand;
	import com.tro.chromecast.models.AssetStorage;
	import com.tro.chromecast.models.ContentModel;
	
	/**
	 * ...
	 * @author Andrew Day
	 */
	public class Load3dModelsCommand extends BaseCommand 
	{
		[Inject]
		public var modelStorage : AssetStorage;

		[Inject]
		public var contentModel : ContentModel;
		
		public function Load3dModelsCommand() 
		{
			super();
			
		}
		
		
		override public function execute():void 
		{
			super.execute();
			
			modelStorage.loadModels();

			contentModel.initContent();
		}
	}

}