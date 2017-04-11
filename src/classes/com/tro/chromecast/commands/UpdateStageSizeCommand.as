/**
 * Created by russellmilburn on 27/07/15.
 */
package com.tro.chromecast.commands
{

	import com.tro.chromecast.models.augreality.ARModel;
	import com.tro.chromecast.models.StageModelEvent;

	public class UpdateStageSizeCommand extends BaseCommand
	{
		[Inject]
		public var event: StageModelEvent;


		public function UpdateStageSizeCommand()
		{
			super();
		}


		override public function execute():void
		{
			super.execute();

			getViewRoot().stage3DProxy.width = event.stageWidth;
			getViewRoot().stage3DProxy.height = event.stageHeight;
		}
	}
}
