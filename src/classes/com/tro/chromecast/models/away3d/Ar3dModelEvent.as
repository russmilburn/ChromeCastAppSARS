/**
 * Created by russellmilburn on 19/08/15.
 */
package com.tro.chromecast.models.away3d
{

	import flash.events.Event;

	public class Ar3dModelEvent extends Event
	{

		public static const ON_3D_MODEL_READY : String = "on3dModelReady";
		public static const ON_CC_INTRO_COMPLETE : String = "onCCIntroComplete";

		public static const DISABLE_INTERACTION : String =  "disableInteraction";
		public static const WAITING_FOR_INTERACTION : String = "waitingForInteraction";
		public static const ON_USER_INTERACTION : String = "onUserInteraction";


		public static const ON_CC_CYCLE_COMPLETE : String = "onCCIntroCycleComplete";
		public static const ON_CC_INTO_TV_START : String = "onChromeCastIntoTvStart";
		public static const ON_CC_INTO_TV_COMPLETE : String = "onCCIntoTvComplete";

		public static const ON_ICONS_INTRO_COMPLETE : String = "onIconsIntroComplete";
		public static const ON_ICONS_SPIN_COMPLETE : String = "onIconsSpinComplete";
		public static const ON_ICONS_EXIT_COMPLETE : String = "onIconsExitComplete";

		public static const DISPLAY_LOUNGE : String = "displayLounge";
		public static const ON_LOUNGE_INTRO_COMPLETE : String = "onLoungeIntroComplete";


		public function Ar3dModelEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
