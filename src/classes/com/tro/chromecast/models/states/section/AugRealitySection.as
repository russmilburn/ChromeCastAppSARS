/**
 * Created by russellmilburn on 28/07/15.
 */
package com.tro.chromecast.models.states.section
{

	import com.tro.chromecast.interfaces.ISectionState;
	import com.tro.chromecast.views.ViewList;

	public class AugRealitySection extends Section implements ISectionState
	{
		public function AugRealitySection()
		{
			super(SectionList.AR_SECTION);
			sectionHighlightName = SectionList.AR_SECTION;
			viewList.push(
					ViewList.AR_VIEW,
					ViewList.CHOOSE_DEVICE_VIEW_C,
					ViewList.HOW_TO_CAST_VIEW,
					ViewList.REPEAT_SECTION_VIEW
			);
		}

	}
}
