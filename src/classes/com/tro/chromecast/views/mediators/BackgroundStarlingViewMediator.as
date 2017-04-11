/**
 * Created by russellmilburn on 08/09/15.
 */
package com.tro.chromecast.views.mediators
{

	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.views.BackgroundStarlingView;

	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;

	public class BackgroundStarlingViewMediator extends BaseMediator
	{
		[Inject]
		public var view : BackgroundStarlingView;

		[Inject(name="background")]
		public var background : DisplayObjectContainer;




		public function BackgroundStarlingViewMediator()
		{
			super();

			//trace("************************************ BackgroundStarlingViewMediator");
		}


		override public function initialize():void
		{
			super.initialize();


			//logger.info("************************************ initialize");
			addContextListener(AppEvent.START_VIEW_INIT, startViewInit);


		}

		private function startViewInit(event:AppEvent):void
		{
			//trace("startViewInit");
		}
	}
}
