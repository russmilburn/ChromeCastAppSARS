/**
 * Created by russellmilburn on 30/09/15.
 */
package com.tro.chromecast.models.states.section
{

	import com.tro.chromecast.interfaces.ISectionState;
	import com.tro.chromecast.views.ViewList;

	public class DiscoverMoreSection extends Section implements ISectionState
	{
		public function DiscoverMoreSection()
		{
			super(SectionList.DISCOVER_MORE);
			sectionHighlightName = SectionList.DO_MORE_SECTION;
			viewList = new Array(
					ViewList.DISCOVER_MORE_APPS_VIEW,
					ViewList.DO_MORE_MENU_VIEW

			)
		}
	}
}
