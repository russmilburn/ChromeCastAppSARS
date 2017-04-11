/**
 * Created by tro on 13/08/2015.
 */
package com.tro.chromecast.views.components.devicedisplay.videocontrols
{

	import com.tro.chromecast.views.components.buttons.ImageButton;

	import flash.geom.Point;

	import starling.display.Sprite;

	public class VideoControlPanel extends Sprite
	{
		private var _playPauseBtn:PlayPauseButton;
		private var _scrubBar:ScrubBar;
		private var _volumeControl:VolumeControl;
		private var _background:Background;
		private var padding:Number = 20;
		private var panelWidth:Number = 300;

		private var texturesVo : VideoControlPanelTexturesVo;
		private var _isPlaying:Boolean = false;

		public function VideoControlPanel()
		{

		}

		public function setTextureData(vo : VideoControlPanelTexturesVo) : void
		{
			if (texturesVo == null)
			{
				texturesVo = vo;
				setupDisplay();
			}

		}

		public function setupDisplay():void
		{

			var playButton : PlayButton = new PlayButton();
			playButton.texture = texturesVo.playTexture;

			var playPauseButton : PlayPauseButton = new PlayPauseButton();
			playPauseButton.pauseBtn = new PauseButton();
			playPauseButton.playBtn = playButton;


			var scrubHandle : ImageButton  = new ImageButton();
			scrubHandle.texture = texturesVo.scrubHandleTexture;

			var myScrubBar : ScrubBar = new ScrubBar();
			myScrubBar.scrubHandle = scrubHandle;


			var volumeUp : VolumeButton = new VolumeButton();
			volumeUp.texture = texturesVo.volumeUpTexture;

			var volumeDown : VolumeButton = new VolumeButton();
			volumeDown.texture = texturesVo.volumeDownTexture;

			var volumeControls : VolumeControl = new VolumeControl();
			volumeControls.volumeDownBtn = volumeDown;
			volumeControls.volumeUpBtn = volumeUp;
			volumeControls.updateDisplayList();
			volumeControls.setVolumeLevelTextures(texturesVo.volumeLevelTextures);


			if (_background == null)
			{
				_background = new Background();
				addChildAt(_background, 0);
			}



			playPauseBtn = playPauseButton;
			scrubBar = myScrubBar;
			volumeControl = volumeControls;

			updateDisplayList();
		}


		private function updateDisplayList() : void
		{
			//trace("panelWidth: "  + panelWidth);
			_background.backgroundWidth = panelWidth;
			_scrubBar.setBarWidth(panelWidth - playPauseBtn.width - volumeControl.width - (padding * 3));
			_scrubBar.x = _playPauseBtn.x + _playPauseBtn.width + padding;
			_scrubBar.y = _playPauseBtn.y + _playPauseBtn.height/2 - _scrubBar.height/2 ;

			_volumeControl.x = _scrubBar.x + _scrubBar.width + padding;
		}




		public function setPadding(value:Number):void
		{
			padding = value;
			updateDisplayList();
		}

		public function updateScrubHandlePos(value:Number):void
		{
			_scrubBar.setScrubHandlePosByPercent(value);
		}

		public function set isPlaying(value:Boolean):void
		{
			_isPlaying = value;
			if (_isPlaying)
			{
				_playPauseBtn.playBtn.visible = false;
				_playPauseBtn.pauseBtn.visible = true;
			}
			else
			{
				_playPauseBtn.playBtn.visible = true;
				_playPauseBtn.pauseBtn.visible = false;
			}
		}

		public function get playPauseBtn():PlayPauseButton
		{
			return _playPauseBtn;
		}

		public function set playPauseBtn(value:PlayPauseButton):void
		{
			if (_playPauseBtn != null)
			{
				removeChild(_playPauseBtn)
			}
			_playPauseBtn = value;
			addChild(_playPauseBtn);
		}

		public function get scrubBar():ScrubBar
		{
			return _scrubBar;
		}

		public function set scrubBar(value:ScrubBar):void
		{

			if (_scrubBar != null)
			{
				removeChild(_scrubBar)
			}
			_scrubBar = value;
			addChild(_scrubBar);

		}

		public function get volumeControl():VolumeControl
		{
			return _volumeControl;
		}

		public function set volumeControl(value:VolumeControl):void
		{


			if (_volumeControl != null)
			{
				removeChild(_volumeControl)
			}
			_volumeControl = value;
			addChild(_volumeControl);
		}


		public function setControlPanelWidth(value : Number) : void
		{
			panelWidth = value;
			updateDisplayList();
		}


		public function get background():Background
		{
			return _background;
		}

		public function set background(value:Background):void
		{
			_background = value;
		}
	}
}
