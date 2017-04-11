/**
 * Created by russellmilburn on 04/08/15.
 */
package com.tro.chromecast.views.mediators
{

	import com.tro.chromecast.models.ApplicationModel;
	import com.tro.chromecast.models.ApplicationModelEvent;
	import com.tro.chromecast.views.*;

	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.views.mediators.BaseMediator;

	import flash.events.TimerEvent;

	import flash.utils.Timer;

	public class UserFeedbackViewMediator extends BaseMediator
	{
		[Inject]
		public var view : UserFeedbackView;

		[Inject]
		public var appModel : ApplicationModel;

		private var timer : Timer;

		public function UserFeedbackViewMediator()
		{
			super();
		}


		override public function initialize():void
		{
			super.initialize();

			timer = new Timer(100, 1);

			addContextListener(AppEvent.DISPLAY_USER_FEEDBACK_VIEW, onDisplay);
			addContextListener(AppEvent.HIDE_USER_FEEDBACK_VIEW, onHide);
		}



		private function onDisplay(event : AppEvent):void
		{
			view.display();

			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			timer.start();
		}

		private function onTimerComplete(event:TimerEvent):void
		{
			//timer = new Timer(250, 1);
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			timer.reset();
			timer.stop();

			var evt : ApplicationModelEvent = new ApplicationModelEvent(ApplicationModelEvent.ON_PREPARE_AUG_REALITY_VIEW);
			evt.direction = appModel.direction;
			dispatch(evt);
		}

		private function onHide(event : AppEvent):void
		{
			view.hide();


		}
	}
}
