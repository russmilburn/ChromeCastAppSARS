/**
 * Created by russellmilburn on 22/07/15.
 */
package com.tro.chromecast.commands.startup
{

	import com.tro.chromecast.commands.*;
	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.models.augreality.IARModel;
	import com.tro.chromecast.models.StageModel;
	import com.tro.chromecast.models.TrackingModel;
	import com.tro.chromecast.views.ARView;
	import com.tro.chromecast.views.ViewList;
	import com.tro.chromecast.views.ViewRoot;

	import flash.desktop.NativeApplication;

	public class StartUpCommand extends BaseCommand
	{
		[Inject]
		public var arModel : IARModel;
		
		[Inject]
		public var stageModel : StageModel;

		[Inject]
		public var checkInternetConnectionModel : TrackingModel;
		
		
		
		public function StartUpCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			super.execute();

			NativeApplication.nativeApplication.autoExit = true;
			NativeApplication.nativeApplication.executeInBackground = false;

			logger.info("[START UP 0]: Startup Command");
			
			stageModel.stage = contextView.view.stage;
			
			stageModel.stage3DProxy = getViewRoot().stage3DProxy;
			
			
			stageModel.stageWidth = stageModel.stage.width;
			stageModel.stageHeight = stageModel.stage.height;
			
			arModel.stage = contextView.view.stage;
			arModel.stage3DProxy = ViewRoot(contextView.view).stage3DProxy;
			
			var arView : ARView = new ARView();
			arView.name = ViewList.AR_VIEW;
			arView.mouseChildren = false;
			
			contextView.view.addChild(arView);
			
			dispatch(new AppEvent(AppEvent.INIT_DATABASE));
			//databaseService.connect();
			
			
		}
	}
}
