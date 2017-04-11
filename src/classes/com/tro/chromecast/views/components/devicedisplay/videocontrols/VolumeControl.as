/**
 * Created by tro on 11/08/2015.
 */
package com.tro.chromecast.views.components.devicedisplay.videocontrols
{

	import com.tro.chromecast.views.components.devicedisplay.*;


	import com.tro.chromecast.views.components.buttons.ImageButton;
	import com.greensock.TweenMax;

	import flash.events.TimerEvent;

	import flash.utils.Timer;

	import org.gestouch.events.GestureEvent;

	import starling.display.Image;


	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.utils.AssetManager;

	public class VolumeControl extends Sprite
	{
		private var index:int = 2;
		private var volLevelTextures:Array = [];

		private var _volumeUpBtn:VolumeButton;
		private var _volumeDownBtn:VolumeButton;
		private var _volumeLevel:ImageButton;

		private var _volumeLevelContainer:Sprite;
		private var btnContainer:Sprite;
		private var _fadeTimer:Timer;

		private var _padding:Number = 5;
		private var _videoControlPanelHeight:Number = 20;

		private var _volumeControlHeight:Number;

		public function VolumeControl()
		{
			super();

			_volumeLevelContainer = new Sprite();
			addChild(_volumeLevelContainer);

			btnContainer = new Sprite();
			addChild(btnContainer);

			_fadeTimer = new Timer(2000);
			_fadeTimer.addEventListener(TimerEvent.TIMER, onTimerComplete);
		}

		protected function init():void
		{

			_volumeLevelContainer = new Sprite();

			updateDisplayList();
		}

		public function updateDisplayList():void
		{
			if (_volumeDownBtn == null || _volumeUpBtn == null)
			{
				return;
			}

			_volumeUpBtn.x = _volumeDownBtn.x + _volumeDownBtn.width;


			if (_volumeLevel == null)
			{
				return;
			}

			_volumeLevel.x = 0;
			_volumeLevel.y = 0;

			_volumeLevelContainer.y = (_volumeLevelContainer.height * -1);
			btnContainer.y = _volumeLevelContainer.y + _volumeLevelContainer.height;
		}

		public function setVolume(_index:int):void
		{
			index = _index;
			setVolumeImage();
		}

		private function onVolumeUp(event:GestureEvent):void
		{
			tweenVolumeContainer();

			if (index >= 3)
			{
				return;
			}
			else
			{
				index++;
				setVolumeImage();

				var evt :VideoControlPanelEvent = new VideoControlPanelEvent(VideoControlPanelEvent.ON_VOLUME_UP, true);
				evt.volumeLevel = index;
				dispatchEvent(evt);
			}
		}

		private function onVolumeDown(event:GestureEvent):void
		{
			tweenVolumeContainer();

			if (index <= 0)
			{
				return;
			}
			else
			{
				index--;
				setVolumeImage();
				var evt :VideoControlPanelEvent = new VideoControlPanelEvent(VideoControlPanelEvent.ON_VOLUME_DOWN, true);
				evt.volumeLevel = index;
				dispatchEvent(evt);
			}
		}

		private function tweenVolumeContainer():void
		{
			_fadeTimer.reset();
			TweenMax.to(_volumeLevelContainer, .5, { autoAlpha:1, onComplete:startDisplayVolumeTimer});
		}

		private function setVolumeImage():void
		{
			_volumeLevel.texture = volLevelTextures[index];
		}

		private function startDisplayVolumeTimer():void
		{
			_fadeTimer.reset();
			_fadeTimer.start();
		}

		private function onTimerComplete(event:TimerEvent):void
		{
			_fadeTimer.stop();
			_fadeTimer.reset();

			TweenMax.to(_volumeLevelContainer, .5, {autoAlpha:0});
		}


		public function setVolumeLevelTextures(textures : Array) :void
		{
			volLevelTextures = textures;

			_volumeLevel = new ImageButton();
			_volumeLevel.texture = Texture(volLevelTextures[index]);

			_volumeLevelContainer.addChild(_volumeLevel);
			_volumeLevelContainer.visible = false;

			updateDisplayList();

		}


		public function get volumeUpBtn():VolumeButton
		{
			return _volumeUpBtn;
		}

		public function set volumeUpBtn(value:VolumeButton):void
		{
			_volumeUpBtn = value;
			if (_volumeUpBtn != null)
			{
				btnContainer.removeChild(_volumeUpBtn);
				_volumeUpBtn.tap.removeEventListener(GestureEvent.GESTURE_RECOGNIZED, onVolumeUp);
			}

			btnContainer.addChild(_volumeUpBtn);
			_volumeUpBtn.tap.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onVolumeUp);

			updateDisplayList();
		}

		public function get volumeDownBtn():VolumeButton
		{
			return _volumeDownBtn;
		}

		public function set volumeDownBtn(value:VolumeButton):void
		{
			_volumeDownBtn = value;

			if (_volumeDownBtn != null)
			{
				btnContainer.removeChild(_volumeDownBtn);
				_volumeDownBtn.tap.removeEventListener(GestureEvent.GESTURE_RECOGNIZED, onVolumeDown);
			}

			btnContainer.addChild(_volumeDownBtn);
			_volumeDownBtn.tap.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onVolumeDown);

			updateDisplayList();
		}
	}
}
