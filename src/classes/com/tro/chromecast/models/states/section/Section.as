/**
 * Created by russellmilburn on 28/07/15.
 */
package com.tro.chromecast.models.states.section
{

	import com.tro.chromecast.interfaces.ISectionState;

	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	import robotlegs.bender.framework.api.ILogger;

	public class Section extends EventDispatcher implements ISectionState
	{
		[Inject]
		public var logger : ILogger;


		private var _sectionName : String;
		private var _viewList : Array;
		private var _viewIndex : int;
		private var _isComplete : Boolean;
		private var _sectionHighlightName : String;

		public function Section(name : String)
		{
			super();
			_viewIndex = -1;
			sectionName = name;
			viewList = new Array();
		}


		public function get sectionName():String
		{
			return _sectionName;
		}

		public function set sectionName(value:String):void
		{
			_sectionName = value;
		}

		public function get viewList():Array
		{
			return _viewList;
		}

		public function set viewList(value:Array):void
		{
			_viewList = value;
		}


		public function get viewIndex():int
		{
			return _viewIndex;
		}

		public function set viewIndex(value:int):void
		{
			_viewIndex = value;
		}

		public function getNumberOfViews():Number
		{
			return viewList.length;
		}

		public function getViewName(index : Number):String
		{
			return viewList[index];
		}

		public function nextView():void
		{
			viewIndex ++;

			//logger.info("[INCOMING 2]: nextViewIndex: " + viewIndex);

			if (viewIndex >= viewList.length)
			{
				viewIndex = viewList.length-1;
				dispatchEvent(new SectionEvent(SectionEvent.SECTION_END));
			}
			else
			{
				dispatchEvent(new SectionEvent(SectionEvent.SECTION_CONTINUE));
			}
		}

		public function prevView():void
		{
			viewIndex --;

			if (viewIndex < 0)
			{
				viewIndex = 0;
				dispatchEvent(new SectionEvent(SectionEvent.SECTION_END));
			}
			else
			{
				dispatchEvent(new SectionEvent(SectionEvent.SECTION_CONTINUE));
			}
		}


		public function get isComplete():Boolean
		{
			return _isComplete;
		}

		public function set isComplete(value:Boolean):void
		{
			_isComplete = value;
		}


		public function get sectionHighlightName():String
		{
			return _sectionHighlightName;
		}

		public function set sectionHighlightName(value:String):void
		{
			_sectionHighlightName = value;
		}
	}
}
