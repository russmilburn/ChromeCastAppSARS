/**
 * Created by russellmilburn on 28/07/15.
 */
package com.tro.chromecast.interfaces
{

	import flash.events.IEventDispatcher;

	public interface ISectionState extends IEventDispatcher
	{
		function get sectionName():String;

		function set sectionName(name:String):void;

		function get viewList():Array;

		function set viewList(value:Array):void;

		function get isComplete() : Boolean

		function set isComplete(value: Boolean) : void

		function get viewIndex():int;

		function set viewIndex(value :int):void;

		function nextView() : void

		function prevView() : void

		function getNumberOfViews():Number;

		function get sectionHighlightName() : String

		function set sectionHighlightName(value: String) : void



		function getViewName(index : Number):String



	}
}
