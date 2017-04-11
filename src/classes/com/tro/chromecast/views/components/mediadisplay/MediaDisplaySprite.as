package com.tro.chromecast.views.components.mediadisplay
{

	import flash.display3D.Context3D;
	import flash.events.NetStatusEvent;
	import flash.events.TimerEvent;
	import flash.media.SoundTransform;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.Timer;

	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.ConcreteTexture;
	import starling.textures.Texture;
	import starling.utils.SystemUtil;

	/**
	 * ...
	 * @author David Armstrong
	 */
	public class MediaDisplaySprite extends Sprite
	{
		private var netConnection:NetConnection;
		private var netStream:NetStream;

		private var cTexture:ConcreteTexture;
		private var vTexture:Texture;
		private var image:Image;

		public var fileName:String;

		private var timer:Timer;

		private var videoWidth:int;
		private var videoHeight:int;
		private var _isPlaying : Boolean;

		private var tickBeacon:Timer;
		private var videoDuration : Number;


		public static const STARTED_PLAYING:String = "STARTED_PLAYING";
		public static const DONE_PLAYING:String = "DONE_PLAYING";
		public static const DONE_LOADING:String = "DONE_LOADING";
		public static const BUFFER_EMPTY:String = "BUFFER_EMPTY";

		public function MediaDisplaySprite(videoWidth:int = -1, videoHeight:int = -1)
		{
			super();

			this.videoWidth = videoWidth;
			this.videoHeight = videoHeight;


			tickBeacon = new Timer(100, 1);
			tickBeacon.addEventListener(TimerEvent.TIMER_COMPLETE, onPlayheadTimeChange);

			//this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			init();

		}

		private function onAddedToStage(event:Event):void
		{
			//this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			//init();
		}



		private function init():void
		{

			if (SystemUtil.supportsVideoTexture)
			{
				var context3D:Context3D = Starling.context;

				netConnection = new NetConnection();
				netConnection.connect(null);
				netStream = new NetStream(netConnection);
				netStream.client = this;
				netStream.soundTransform = new SoundTransform();
				netStream.useHardwareDecoder = false; // Disable if you see green flashes between videos.

				netStream.play(null);

//				vTexture = context3D.createVideoTexture();
//				vTexture.attachNetStream(netStream);
//				vTexture.addEventListener(VideoTextureEvent.RENDER_STATE, renderFrame);
//				cTexture = new ConcreteTexture(vTexture, Context3DTextureFormat.BGRA, 512, 512, false, true, true);
//				cTexture.attachNetStream(netStream);
//				image = new Image(cTexture);
//				addChild(image);

				vTexture = Texture.fromNetStream(netStream, 1, onTextureFromVideoComplete);

				timer = new Timer(1000, 1);

				//dispatchEvent(new MediaDisplayEvent(MediaDisplayEvent.ON_VIDEO_PLAYER_INIT));

			}
			else
			{
				trace("LoadVideo: VideoTexture not supported.");
			}
		}

		private function onTextureFromVideoComplete():void
		{
			image = new Image(vTexture);
			image.width = this.videoWidth;
			image.height = this.videoHeight;
			addChild(image);
			dispatchEvent(new MediaDisplayEvent(MediaDisplayEvent.ON_VIDEO_PLAYER_INIT));

		}


		public function cue():void
		{
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, videoShouldHaveStopped);
			netStream.play(fileName, 0);
			isPlaying = false;
		}

		public function load(fileName : String) : void
		{
			this.fileName = fileName;
			start();
		}

		public function start():void
		{
			netStream.addEventListener(NetStatusEvent.NET_STATUS, netStatus);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, videoShouldHaveStopped);
			netStream.play(fileName, 0);

			isPlaying = false;
		}

		public function pause() : void
		{
			isPlaying = false;
		}

		public function resume() : void
		{
			isPlaying = true;
		}

		public function set isPlaying(value : Boolean):void
		{
			_isPlaying = value;
			var evt :MediaDisplayEvent;
			if (_isPlaying)
			{
				tickBeacon.start();
				netStream.resume();
				evt  = new MediaDisplayEvent(MediaDisplayEvent.ON_PLAY);
				evt.playheadTime = netStream.time;
				evt.totalTime = videoDuration;
				dispatchEvent(evt);
			}
			else
			{
				tickBeacon.stop();
				netStream.pause();
				evt  = new MediaDisplayEvent(MediaDisplayEvent.ON_PAUSE);
				evt.playheadTime = netStream.time;
				evt.totalTime = videoDuration;
				dispatchEvent(evt);
			}
		}

		public function get isPlaying() : Boolean
		{
			return _isPlaying;
		}

		private function onPlayheadTimeChange(event:TimerEvent):void
		{
			tickBeacon.reset();
			tickBeacon.start();
			var evt : MediaDisplayEvent = new MediaDisplayEvent(MediaDisplayEvent.ON_VIDEO_PLAYHEAD_TIME_CHANGE);
			evt.playheadTime = netStream.time;
			evt.totalTime = videoDuration;
			dispatchEvent(evt);
		}

		public function seek(seekTime :Number) : void
		{
			//isPlaying = false;
			netStream.seek(seekTime);
			//isPlaying = true;

		}
		public function seekByPercent(percent :Number) : void
		{
			var seekPos : Number = percent * videoDuration;
			seek(seekPos);

		}

		public function loop():void
		{
			//netStream.seek(0);
			netStream.play(fileName, 0);
		}

		public function reset():void
		{
			netStream.close();
			netStream.removeEventListener(NetStatusEvent.NET_STATUS, netStatus);
			isPlaying = false;
			removeEventListener(Event.REMOVED_FROM_STAGE, removed);

			//cTexture.dispose();
			if (vTexture != null)
			{
				vTexture.dispose();
			}

			if (image != null)
			{
				removeChild(image);
				image.dispose();
			}

			timer.reset();
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, videoShouldHaveStopped);

			removeChildren();
			dispose();
			removeEventListeners();

		}

		private function netStatus(event:NetStatusEvent):void
		{
			switch (event.info.code)
			{
				case "NetStream.Buffer.Full":
					//trace("NetStream.Buffer.Full");
					//cTexture.attachNetStream(netStream);
					dispatchEvent(new MediaDisplayEvent(MediaDisplayEvent.ON_VIDEO_START));

					//dispatchEvent(new Event(STARTED_PLAYING));
					break;

				case "NetStream.Buffer.Empty":
					//trace("NetStream.Buffer.Empty");
					dispatchEvent(new MediaDisplayEvent(MediaDisplayEvent.ON_BUFFER_EMPTY));
					//dispatchEvent(new Event(BUFFER_EMPTY));
					break;
				case "NetStream.Seek.InvalidTime":
					trace("InvalidTime seek time");
					break;

				default:
					//trace(fileName, event.info.code);
					break;
			}
		}

		private function videoShouldHaveStopped(event:TimerEvent):void
		{
			var object:Object = new Object();
			object.code = "NetStream.Play.Complete";
			onPlayStatus(object);
		}

		public function onPlayStatus( info:Object ):void
		{
			switch(info.code)
			{
				case "NetStream.Play.Complete":
					timer.reset();
					isPlaying = false;
					dispatchEvent(new MediaDisplayEvent(MediaDisplayEvent.ON_VIDEO_COMPLETE));
					break;
				default:
					trace("LoadStageVideo: onPlayStatus says "+info.code);
					break;
			}
		}

		public function onMetaData( info:Object ) : void
		{
			videoDuration = info["duration"];
			timer.delay = (int(info["duration"]) + 1) * 1000;
		}

		public function onCuePoint( info:Object ) : void { trace("GOT CUE"); }
		public function onXMPData( info:Object ):void { trace("GOT XMP DATA"); }

		private function removed(e:Event):void
		{
			isPlaying = false;
			removeEventListener(Event.REMOVED_FROM_STAGE, removed);

			netStream.removeEventListener(NetStatusEvent.NET_STATUS, netStatus);

			//cTexture.dispose();
			vTexture.dispose();

			removeChild(image);
			image.dispose();

			timer.reset();
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, videoShouldHaveStopped);

			removeChildren();
			dispose();
			removeEventListeners();
		}

		public function set volume(value:Number) : void
		{
			var st : SoundTransform = new SoundTransform();
			st.volume = value / 3;
			netStream.soundTransform = st;
		}

		public function getPosition() : Number
		{
			return netStream.time;
		}

		public function getVideoImage() : Image
		{
			return image;
		}
	}
}