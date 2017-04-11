/**
 * Created by russellmilburn on 15/09/15.
 */
package com.tro.chromecast.models.states.section
{

	import com.tro.chromecast.interfaces.ISectionState;
	import com.tro.chromecast.views.View;
	import com.tro.chromecast.views.ViewList;

	public class PlugInSection extends Section implements ISectionState
	{
		public function PlugInSection()
		{
			super(SectionList.PLUG_IN_SECTION);
			sectionHighlightName = SectionList.PLUG_IN_SECTION;
			viewList.push(
				ViewList.PLUGIN_DRAG_VIEW,
				ViewList.REPEAT_SECTION_VIEW
			);
		}
	}
}
