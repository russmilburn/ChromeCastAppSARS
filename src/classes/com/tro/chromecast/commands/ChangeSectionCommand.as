/**
 * Created by russellmilburn on 29/07/15.
 */
package com.tro.chromecast.commands
{

	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.models.ApplicationModel;
	import com.tro.chromecast.interfaces.ISectionState;
	import com.tro.chromecast.models.states.section.IntroSection;
	import com.tro.chromecast.models.states.section.SectionList;
	import com.tro.chromecast.models.vos.TrackingVo;
	import com.tro.chromecast.views.LoginView;
	import com.tro.chromecast.views.LoginView;
	import com.tro.chromecast.views.NavMenuView;
	import com.gamua.flox.Flox;

	public class ChangeSectionCommand extends BaseCommand
	{
		[Inject]
		public var event : AppEvent;
		
		[Inject]
		public var appModel : ApplicationModel;
		
		
		public function ChangeSectionCommand()
		{
			super();
		}
		
		
		override public function execute():void
		{
			super.execute();
			
			//logger.info("execute");
			
			var incomingSection : ISectionState = appModel.getSection(event.sectionName);
			
			if (incomingSection.viewIndex == 0 && incomingSection == appModel.currentSection)
			{
				return;
			}
			
			if (incomingSection.viewIndex > -1)
			{
				incomingSection.viewIndex = -1;
			}
			
			if (incomingSection == appModel.getSection(SectionList.INTRO_SECTION))
			{
				dispatch(new AppEvent(AppEvent.HIDE_NAV_MENU));
			}
			
			appModel.setNewSection(incomingSection);
			
			appModel.updateVisitedSection(incomingSection.sectionHighlightName);
			
			var trackingVo : TrackingVo = new TrackingVo();
			trackingVo.code = "CHANGE_SECTION";
			trackingVo.parameter = "Section";
			trackingVo.value = incomingSection.sectionHighlightName;
			
			var floxEvt : AppEvent = new AppEvent(AppEvent.TRACK_INTERACTION);
			floxEvt.trackingVo = trackingVo;
			dispatch(floxEvt);
		}
	}
}
