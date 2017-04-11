/**
 * Created by russellmilburn on 30/09/15.
 */
package com.tro.chromecast.models.states.section
{

	import com.tro.chromecast.interfaces.ISectionState;
	import com.tro.chromecast.views.ViewList;

	public class BackdropSection extends Section implements ISectionState
	{
		public function BackdropSection()
		{
			super(SectionList.BACKDROP_SECTION);
			sectionHighlightName = SectionList.DO_MORE_SECTION;

			viewList = new Array(
					ViewList.BACKDROP_EXAMPLE_VIEW,
					ViewList.BACKDROP_SLIDESHOW_VIEW,
					ViewList.DO_MORE_MENU_VIEW
			)
		}
	}
}
