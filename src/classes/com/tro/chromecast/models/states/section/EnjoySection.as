/**
 * Created by russellmilburn on 10/08/15.
 */
package com.tro.chromecast.models.states.section
{

	import com.tro.chromecast.interfaces.ISectionState;
	import com.tro.chromecast.views.View;
	import com.tro.chromecast.views.ViewList;

	public class EnjoySection extends Section implements ISectionState
	{
		public function EnjoySection()
		{
			super(SectionList.ENJOY_SECTION);
			sectionHighlightName = SectionList.ENJOY_SECTION;
			viewList.push(
					ViewList.CHOOSE_DEVICE_VIEW_A,
					ViewList.CAST_APPS_VIEW,
					ViewList.BACKGROUND_TASKS_VIEW,
					ViewList.REPEAT_SECTION_VIEW
			);
		}
	}
}
