/**
 * Created by russellmilburn on 15/09/15.
 */
package com.tro.chromecast.models.states.section
{

	import com.tro.chromecast.interfaces.ISectionState;
	import com.tro.chromecast.views.ViewList;

	public class ConnectDeviceSection extends Section implements ISectionState
	{
		public function ConnectDeviceSection()
		{
			super(SectionList.CONNECT_DEVICE_SECTION);
			sectionHighlightName = SectionList.CONNECT_SECTION;
			viewList = new Array(
					ViewList.CHOOSE_DEVICE_OS_VIEW,
					ViewList.DOWNLOAD_VIEW,
					ViewList.CONNECT_TO_WIFI_VIEW,
					ViewList.REPEAT_SECTION_VIEW
			)
		}
	}
}
