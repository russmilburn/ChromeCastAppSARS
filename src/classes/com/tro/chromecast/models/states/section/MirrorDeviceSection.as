/**
 * Created by russellmilburn on 30/09/15.
 */
package com.tro.chromecast.models.states.section
{

	import com.tro.chromecast.views.ViewList;

	public class MirrorDeviceSection extends Section
	{
		public function MirrorDeviceSection()
		{
			super(SectionList.MIRROR_DEVICE_SECTION);
			sectionHighlightName = SectionList.DO_MORE_SECTION;
			viewList = new Array(
					ViewList.MIRROR_YOUR_DEVICE_LAPTOP_VIEW,
					ViewList.MIRROR_YOUR_DEVICE_MOBILE_VIEW,
					ViewList.DO_MORE_MENU_VIEW
			)
		}
	}
}
