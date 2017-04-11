/**
 * Created by russellmilburn on 30/09/15.
 */
package com.tro.chromecast.models.states.section
{

	import com.tro.chromecast.views.ViewList;

	public class GuestModeSection extends Section
	{
		public function GuestModeSection()
		{
			super(SectionList.GUEST_MODE_SECTION);
			sectionHighlightName = SectionList.DO_MORE_SECTION;
			viewList = new Array(
					ViewList.GUEST_MODE_VIEW,
					ViewList.DO_MORE_MENU_VIEW

			)
		}
	}
}
