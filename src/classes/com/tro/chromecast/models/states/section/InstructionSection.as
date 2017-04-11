/**
 * Created by russellmilburn on 05/08/15.
 */
package com.tro.chromecast.models.states.section
{

	import com.tro.chromecast.views.ViewList;

	public class InstructionSection extends Section
	{
		public function InstructionSection()
		{
			super(SectionList.INSTRUCTIONS_SECTION);
			sectionHighlightName = SectionList.INSTRUCTIONS_SECTION;

			viewList.push(
					ViewList.AUG_REALITY_INSTRUCTIONS_VIEW,
					ViewList.SWIPE_INSTRUCTIONS_VIEW

			);
		}
	}
}
