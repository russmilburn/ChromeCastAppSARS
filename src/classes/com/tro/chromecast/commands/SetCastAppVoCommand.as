/**
 * Created by russellmilburn on 20/08/15.
 */
package com.tro.chromecast.commands
{

	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.models.ContentModel;

	public class SetCastAppVoCommand extends BaseCommand
	{
		[Inject]
		public var event : AppEvent;

		[Inject]
		public var contentModel : ContentModel;


		public function SetCastAppVoCommand()
		{
			super();
		}


		override public function execute():void
		{
			super.execute();

			contentModel.currentCasAppVo = event.castAppVo;
		}
	}
}
