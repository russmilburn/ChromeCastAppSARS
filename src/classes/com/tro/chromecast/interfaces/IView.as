/**
 * Created by russellmilburn on 29/07/15.
 */
package com.tro.chromecast.interfaces
{

	import com.greensock.TweenMax;

	import starling.events.Event;

	public interface IView
	{

		function addEventListener(type:String,listener:Function):void;
		function removeEventListener(type:String,listener:Function):void;
		function dispatchEvent(event:Event):void;

		function prepareViewIn(direction : String) : void;
		function prepareViewOut(direction : String) : void;

		function viewIn() : void;
		function viewOut() : void;
		function finish() : void;
		function hide() : void;
		function display() : void;

		function startViewIn() : void;
		function startViewOut() : void;

		function set x(value:Number):void
		function get x():Number

		function set y(value:Number):void
		function get y():Number

		function get width():Number
		function set width(value:Number):void


		function set tweenIn(value:TweenMax):void
		function get tweenIn():TweenMax

		function set tweenOut(value:TweenMax):void
		function get tweenOut():TweenMax

		function getTweenFromPos(direction : String, inIncomingView : Boolean) :Number;
		function getTweenToPos(direction : String, inIncomingView : Boolean) :Number;

	}
}
