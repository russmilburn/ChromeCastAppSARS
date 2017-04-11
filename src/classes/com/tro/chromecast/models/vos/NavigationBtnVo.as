/**
 * Created by russellmilburn on 29/07/15.
 */
package com.tro.chromecast.models.vos
{

	import com.tro.chromecast.interfaces.ISectionState;

	public class NavigationBtnVo
	{
		public var label: String;
		public var sectionName: String;
		public var isSelected : Boolean;
		public var hasVisited : Boolean;


		public function NavigationBtnVo()
		{
		}

		public function toString() : String
		{
			return "[NavigationBtnVo:" +
					"label: " + label +
					"sectionName: " + sectionName +
					"]";
		}

	}
}
