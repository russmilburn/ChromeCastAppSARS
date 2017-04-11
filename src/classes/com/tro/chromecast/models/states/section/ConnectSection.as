/**
 * Created by russellmilburn on 15/09/15.
 */
package com.tro.chromecast.models.states.section
{

	import com.tro.chromecast.interfaces.ISectionState;
	import com.tro.chromecast.views.ViewList;

	public class ConnectSection extends Section implements ISectionState
	{
		public function ConnectSection()
		{
			super(SectionList.CONNECT_SECTION);
			sectionHighlightName = SectionList.CONNECT_SECTION;
			viewList = new Array(
					ViewList.CHOOSE_DEVICE_VIEW_B

			)
		}
	}
}
