/**
 * Created by russellmilburn on 02/09/15.
 */
package com.tro.chromecast.models.states.section
{

	import com.tro.chromecast.interfaces.ISectionState;
	import com.tro.chromecast.views.ViewList;

	public class ExitSection extends Section implements ISectionState
	{
		public function ExitSection()
		{
			super(SectionList.EXIT_SECTION);
			sectionHighlightName = SectionList.EXIT_SECTION;
			viewList.push(
					ViewList.EXIT_APP_VIEW
			);
		}
	}
}
