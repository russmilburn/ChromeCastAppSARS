/**
 * Created by russellmilburn on 06/08/15.
 */
package com.tro.chromecast.commands.startup
{

	import com.tro.chromecast.commands.BaseCommand;
	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.models.TrackingModel;
	import com.tro.chromecast.models.states.section.SectionList;
	import com.tro.chromecast.models.vos.DeviceTypeVo;
	import com.tro.chromecast.models.vos.TrackingVo;
	import flash.system.Capabilities;

	public class StartUpCompleteCommand extends BaseCommand
	{
		[Inject]
		public var checkInternetConnectionModel:TrackingModel;
		
		public function StartUpCompleteCommand()
		{

		}


		override public function execute():void
		{
			super.execute();

			var evt : AppEvent = new AppEvent(AppEvent.UPDATE_SECTION);
			evt.sectionName = SectionList.INTRO_SECTION;
			dispatch(evt);

			evt = new AppEvent(AppEvent.SET_DEVICE_TYPE);
			evt.deviceType = DeviceTypeVo.LAPTOP;
			dispatch(evt);
			
			checkInternetConnectionModel.init();
		}
	}
}
