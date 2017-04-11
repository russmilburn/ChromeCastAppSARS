/**
 * Created by russellmilburn on 03/08/15.
 */
package com.tro.chromecast.commands
{

	import com.tro.chromecast.models.augreality.ARModel;
	import com.tro.chromecast.models.augreality.IARModel;

	public class InitAugRealityCommand extends BaseCommand
	{
		[Inject]
		public var arModel : IARModel;


		public function InitAugRealityCommand()
		{
			super();
		}


		override public function execute():void
		{
			super.execute();

			arModel.initAugReality();


		}
	}
}
