/**
 * Created by russellmilburn on 03/08/15.
 */
package com.tro.chromecast.commands
{

	import com.tro.chromecast.models.augreality.ARModel;
	import com.tro.chromecast.models.augreality.IARModel;

	public class DestroyAugRealityCommand extends BaseCommand
	{
		[Inject]
		public var arModel : IARModel;


		public function DestroyAugRealityCommand()
		{
			super();
		}


		override public function execute():void
		{
			super.execute();

			arModel.destroyAugReality();

		}
	}
}
