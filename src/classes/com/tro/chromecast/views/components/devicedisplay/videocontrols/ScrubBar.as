/**
 * Created by tro on 13/08/2015.
 */
package com.tro.chromecast.views.components.devicedisplay.videocontrols
{

	import com.tro.chromecast.views.components.buttons.ImageButton;

	import flash.geom.Point;

	import org.gestouch.events.GestureEvent;
	import org.gestouch.gestures.LongPressGesture;
	import org.gestouch.gestures.PanGesture;
	import org.gestouch.gestures.TapGesture;

	import starling.display.Canvas;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class ScrubBar extends Sprite
	{
		private var _scrubBarContainer : Sprite;
		private var _hitArea:HitArea;
		private var _bg : Canvas;

		private var _scrubHandle:ImageButton;

		private var _pan:PanGesture;
		private var _tap : TapGesture;
		private var _press : LongPressGesture;
		private var _scrubAreaWidth : Number;

		public function ScrubBar()
		{
			init();
		}

		private function init():void
		{
			_scrubBarContainer = new Sprite();
			_hitArea = new HitArea();

			_scrubBarContainer.addChild(_hitArea);
			addChild(_scrubBarContainer);



		}

		private function onTapHitArea(event:GestureEvent):void
		{
			updateHandlePos(_hitArea.globalToLocal(tap.location));
		}


		private function validatePosition(value:Number):void
		{
			var xPos:Number = _scrubHandle.x;

			//xPos = xPos + value;

			if (value < _hitArea.x)
			{
				value = _hitArea.x;
			}

			if (value > _hitArea.width + (_scrubHandle.width / 2))
			{
				value = _hitArea.width + (_scrubHandle.width / 2);
			}

			_scrubHandle.x = value;
		}


		private function getScrubPosition():Number
		{
			var srcubPos:Number = _scrubHandle.x / _hitArea.width;
			return srcubPos;
		}



		public function setScrubHandlePosByPercent(value : Number) : void
		{
			_scrubHandle.x = value * _scrubAreaWidth;
		}

		public function updateHandlePos(value:Point):void
		{
			var xPos:Number = value.x;
			_scrubHandle.x = xPos + (_scrubHandle.width /2);
		}

		public function setBarWidth(value:Number):void
		{
			_hitArea.scrubBarWidth = value - (_scrubHandle.width /2);

			_scrubAreaWidth = value;

			if (_bg != null)
			{
				removeChild(_bg);
			}

			//_bg is used to set the bounds of the scrub bar container
			_bg = new Canvas();
			_bg.beginFill(0xFFFFFF, 0);
			_bg.drawRectangle(0, 0, _hitArea.x + _hitArea.width + (_scrubHandle.width / 2), 50);

			addChildAt(_bg, 0);
		}

		public function setBarHeight(value:Number):void
		{
			_hitArea.scrubBarHeight = value;
		}

		public function get scrubHandle():ImageButton
		{
			return _scrubHandle;
		}

		public function set scrubHandle(value:ImageButton):void
		{

			if (_scrubHandle != null)
			{

				removeChild(_scrubHandle);
				scrubHandle.removeEventListener(TouchEvent.TOUCH, onHandleTouch);

			}

			_scrubHandle = value;

			_hitArea.x =  0 + (_scrubHandle.width / 2);

			_scrubHandle.pivotX = _scrubHandle.width/2;
			_scrubHandle.pivotY = _scrubHandle.height/2;
			_scrubHandle.x = _hitArea.x;
			_scrubHandle.y = _hitArea.height / 2;

			_scrubBarContainer.addChild(_scrubHandle);
			_scrubBarContainer.y = (50 - _hitArea.height)/ 2;

			scrubHandle.addEventListener(TouchEvent.TOUCH, onHandleTouch);
		}

		private function onHandleTouch(event:TouchEvent):void
		{
			var point:Point;
			var evt :VideoControlPanelEvent;
			
			if (event.getTouch(scrubHandle, TouchPhase.BEGAN))
			{
				point = event.getTouch(scrubHandle, TouchPhase.BEGAN).getLocation(this);
				validatePosition(point.x);
				dispatchEvent(new VideoControlPanelEvent(VideoControlPanelEvent.ON_SCRUB_START, true));
			}
			else if (event.getTouch(scrubHandle, TouchPhase.MOVED))
			{
				point = event.getTouch(scrubHandle, TouchPhase.MOVED).getLocation(this);
				validatePosition(point.x);

				evt = new VideoControlPanelEvent(VideoControlPanelEvent.ON_SCRUB, true);
				evt.scrubPos = getScrubPosition();
				dispatchEvent(evt);
			}
			else if (event.getTouch(scrubHandle, TouchPhase.ENDED))
			{
				point = event.getTouch(scrubHandle, TouchPhase.ENDED).getLocation(this);
				validatePosition(point.x);
				evt = new VideoControlPanelEvent(VideoControlPanelEvent.ON_SCRUB_END, true);
				evt.scrubPos = getScrubPosition();
				dispatchEvent(evt);
			}


		}


		public function get pan():PanGesture
		{
			return _pan;
		}

		public function set pan(value:PanGesture):void
		{
			_pan = value;
		}

		public function get tap():TapGesture
		{
			return _tap;
		}

		public function set tap(value:TapGesture):void
		{
			_tap = value;
		}
	}
}
