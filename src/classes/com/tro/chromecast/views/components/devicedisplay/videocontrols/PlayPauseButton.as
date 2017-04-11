/**
 * Created by tro on 13/08/2015.
 */
package com.tro.chromecast.views.components.devicedisplay.videocontrols
{

	import com.tro.chromecast.views.components.buttons.ImageButton;

	import org.gestouch.events.GestureEvent;

	import org.gestouch.gestures.TapGesture;

	import starling.display.Canvas;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.geom.Polygon;
	import starling.textures.Texture;
	import starling.utils.Color;

	public class PlayPauseButton extends Sprite
	{

		private var _playBtn:PlayButton;
		private var _pauseBtn:PauseButton;


		public function PlayPauseButton()
		{
			init();
		}

		private function init():void
		{

		}


		public function get playBtn():PlayButton
		{
			return _playBtn;
		}

		public function set playBtn(value:PlayButton):void
		{

			if (_playBtn != null)
			{
				_playBtn.tap.removeEventListener(GestureEvent.GESTURE_RECOGNIZED, onPlayTap);
				removeChild(_playBtn)
			}
			_playBtn = value;
			_playBtn.tap.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onPlayTap);
			addChild(_playBtn);
			_playBtn.visible = false;

		}

		private function onPlayTap(event:GestureEvent):void
		{
			var evt : VideoControlPanelEvent = new VideoControlPanelEvent(VideoControlPanelEvent.ON_PLAY_BTN_TAP, true);
			dispatchEvent(evt);
		}

		private function onPauseTap(event:GestureEvent):void
		{
			var evt : VideoControlPanelEvent = new VideoControlPanelEvent(VideoControlPanelEvent.ON_PAUSE_BTN_TAP, true);
			dispatchEvent(evt);
		}

		public function get pauseBtn():PauseButton
		{
			return _pauseBtn;
		}

		public function set pauseBtn(value:PauseButton):void
		{
			if (_pauseBtn != null)
			{
				_pauseBtn.tap.removeEventListener(GestureEvent.GESTURE_RECOGNIZED, onPauseTap);
				removeChild(_pauseBtn)

			}
			_pauseBtn = value;
			_pauseBtn.tap.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onPauseTap);
			addChild(_pauseBtn);

		}


	}
}
