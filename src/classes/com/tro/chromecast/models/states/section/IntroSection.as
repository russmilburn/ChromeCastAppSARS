/**
 * Created by russellmilburn on 28/07/15.
 */
package com.tro.chromecast.models.states.section
{

	import com.tro.chromecast.interfaces.ISectionState;
	import com.tro.chromecast.interfaces.IView;

	import com.tro.chromecast.views.ViewList;


	import starling.events.Event;

	public class IntroSection extends Section implements ISectionState
	{

		public function IntroSection()
		{
			super(SectionList.INTRO_SECTION);

			viewIndex = -1;

			//TODO : if I need to transitions mulitple views in at one time
			//i need to set up and a mulitdimentional array and send to be processed by the view
			viewList.push(
					ViewList.LOG_IN_VIEW,
					ViewList.INTRO_VIEW,
					ViewList.AUG_REALITY_INSTRUCTIONS_VIEW
			);
		}


	}
}
