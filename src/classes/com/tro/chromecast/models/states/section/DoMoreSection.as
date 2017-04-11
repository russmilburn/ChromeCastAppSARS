/**
 * Created by russellmilburn on 15/09/15.
 */
package com.tro.chromecast.models.states.section
{

	import com.tro.chromecast.interfaces.ISectionState;
	import com.tro.chromecast.views.ViewList;

	public class DoMoreSection extends Section implements ISectionState
	{
		public function DoMoreSection()
		{
			super(SectionList.DO_MORE_SECTION);
			sectionHighlightName = SectionList.DO_MORE_SECTION;
			viewList = new Array(
					ViewList.DO_MORE_MENU_VIEW,
					ViewList.DISCOVER_MORE_APPS_VIEW,
					ViewList.BACKDROP_EXAMPLE_VIEW,
					ViewList.BACKDROP_SLIDESHOW_VIEW,
					ViewList.MIRROR_YOUR_DEVICE_LAPTOP_VIEW,
					ViewList.MIRROR_YOUR_DEVICE_MOBILE_VIEW,
					ViewList.CAST_YOUR_OWN_CONTENT_VIEW,
					ViewList.GUEST_MODE_VIEW
			)
		}



	}
}
