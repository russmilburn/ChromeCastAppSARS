/**
 * Created by russellmilburn on 30/09/15.
 */
package com.tro.chromecast.models.states.section
{

	import com.tro.chromecast.views.ViewList;

	public class CastContentSection extends Section
	{
		public function CastContentSection()
		{
			super(SectionList.CAST_CONTENT_SECTION);
			sectionHighlightName = SectionList.DO_MORE_SECTION;
			viewList = new Array(
					ViewList.CAST_YOUR_OWN_CONTENT_VIEW,
					ViewList.DO_MORE_MENU_VIEW

			)
		}
	}
}
