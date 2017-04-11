/**
 * Created by russellmilburn on 15/09/15.
 */
package com.tro.chromecast.models.states.section
{

	import com.tro.chromecast.interfaces.ISectionState;
	import com.tro.chromecast.views.ViewList;

	public class ConnectLaptopSection extends Section implements ISectionState
	{
		public function ConnectLaptopSection()
		{
			super(SectionList.CONNECT_LAPTOP_SECTION);
			sectionHighlightName = SectionList.CONNECT_SECTION;
			viewList = new Array(
					ViewList.INSTALL_CHROME_VIEW,
					ViewList.ADD_EXTENSION_VIEW,
					ViewList.CONNECT_TO_WIFI_VIEW,
					ViewList.REPEAT_SECTION_VIEW
			)
		}
	}
}
