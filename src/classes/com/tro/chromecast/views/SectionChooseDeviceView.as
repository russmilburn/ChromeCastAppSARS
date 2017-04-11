/**
 * Created by russellmilburn on 31/07/15.
 */
package com.tro.chromecast.views
{

	import com.tro.chromecast.views.components.TVDisplayVo;

	public class SectionChooseDeviceView extends ChooseDeviceView
	{
		public function SectionChooseDeviceView()
		{
			super();
		}


		override protected function getContentVo() : TVDisplayVo
		{
			var vo : TVDisplayVo = super.getContentVo();
			vo.title = "Change device";
			vo.bodyCopy = "\nChromecast works with devices you already own. Simply use an Android phone, tablet, " +
				"iPhone®, iPad®, Mac®, Windows® laptop or Chromebook, to cast your favourite " +
				"entertainment and apps right to the big screen.";
			return vo;
		}



	}
}
