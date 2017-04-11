/**
 * Created by tro on 10/08/2015.
 */
package com.tro.chromecast.views.components.imagemenu
{

	import com.tro.chromecast.models.vos.ImageMenuButtonVo;

	import starling.events.Event;

	public class ImageMenuEvent extends Event
	{
		public static const ON_TAP : String = "onTap";
		public static const ON_UPDATE : String = "onUpdate";


		public var vo : ImageMenuButtonVo;
		public var index: Number;

		public function ImageMenuEvent(type:String, bubbles:Boolean = false, data:Object = null)
		{
			super(type, bubbles, data);
		}
	}
}
