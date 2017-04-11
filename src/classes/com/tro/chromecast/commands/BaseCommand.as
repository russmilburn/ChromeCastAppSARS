/**
 * Created by russellmilburn on 22/07/15.
 */
package com.tro.chromecast.commands
{

	import com.tro.chromecast.views.ViewRoot;

	import flash.events.Event;
	import flash.events.IEventDispatcher;

	import robotlegs.bender.bundles.mvcs.Command;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.api.ILogger;

	public class BaseCommand extends Command
	{
		[Inject]
		public var logger : ILogger;

		[Inject]
		public var eventDispatcher:IEventDispatcher;

		[Inject]
		public var contextView : ContextView;


		public function BaseCommand()
		{
			super();
		}

		protected function dispatch(event:Event):void
		{
			if(eventDispatcher.hasEventListener(event.type))
				eventDispatcher.dispatchEvent(event);
		}

		protected  function getViewRoot() : ViewRoot
		{
			return ViewRoot(contextView.view);
		}
	}
}
