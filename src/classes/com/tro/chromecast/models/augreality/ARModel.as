/**
 * Created by russellmilburn on 22/07/15.
 */
package com.tro.chromecast.models.augreality
{

	import com.tro.chromecast.models.*;


	import away3d.core.managers.Stage3DProxy;

	import com.in2ar.IIN2AR;
	import com.in2ar.ane.IN2ARNative;
	import com.in2ar.calibration.IntrinsicParameters;
	import com.in2ar.detect.IN2ARReference;
	import com.in2ar.event.IN2ARDetectionEvent;
	import com.tro.chromecast.views.components.away3d.Away3DCameraLens;

	import flash.display.Bitmap;

	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Stage;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.textures.VideoTexture;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.media.Camera;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;

	import starling.textures.ConcreteTexture;

	public class ARModel extends AbstractModel
	{

//		[Embed(source="../../../../../assets/embed_assets/def_data.ass", mimeType="application/octet-stream")]
//		public static const DefinitionData:Class;

		[Embed(source="../../../../../../assets/embed_assets/markers/TVMinionMarker.ass", mimeType="application/octet-stream")]
		public static const TVMinionMarker:Class;

		[Embed(source="../../../../../../assets/embed_assets/markers/ChromecastVerticalMarker.ass", mimeType="application/octet-stream")]
		public static const ChromecastVerticalMarker:Class;

		[Embed(source="../../../../../../assets/embed_assets/markers/ChromecastOnAngleMarker.ass", mimeType="application/octet-stream")]
		public static const ChromecastOnAngleMarker:Class;

		[Embed(source="../../../../../../assets/embed_assets/markers/TVSupermanMarker.ass", mimeType="application/octet-stream")]
		public static const TVSupermanMarker:Class;



		//private var arShell : IN2AR;
		protected var _arLib : IIN2AR;

		private var _stage : Stage;

		private var _params : IntrinsicParameters;
		private var isMarkerDetected:Boolean = false;
		private var _hasAugRealityInitialize:Boolean = false;

		private var camera : Camera;
		private var _stage3DProxy : Stage3DProxy;

		private var _cTexture:ConcreteTexture;
		private var vTexture:VideoTexture;
		private var _cameraBuffer:BitmapData;
		private var isProcessingData : Boolean = false;
		private var isCameraReady : Boolean = false;
		private var isDataReady : Boolean = false;


		public var cameraWidth:int = 720;
		public var cameraHeight:int = 405;
		public var downSize : Number = 1;

		private var bitmapWidth : Number = cameraWidth * downSize;
		private var bitmapHeight : Number=  cameraHeight * downSize;
		private var _lens:Away3DCameraLens;
		protected var isARRunning : Boolean = false;


		public function ARModel()
		{

		}



		protected function start() : void
		{
			if (stage != null)
			{
				logger.info("Aug Reality init");
				_arLib.init(bitmapWidth, bitmapHeight, 300, 4, 100, stage);
			}

			logger.info("Aug Reality init complete");
			_arLib.setupIndexing(12, 10, true);

			_arLib.setUseLSHDictionary(true);

			_arLib.addReferenceObject( ByteArray (new TVMinionMarker));
			_arLib.addReferenceObject( ByteArray (new ChromecastVerticalMarker));
			_arLib.addReferenceObject( ByteArray (new ChromecastOnAngleMarker));
			_arLib.addReferenceObject( ByteArray (new TVSupermanMarker));

			_arLib.setMaxReferencesPerFrame(1);

			_arLib.setMatchThreshold(32);

			params = _arLib.getIntrinsicParams();

			_stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			_stage.addEventListener(Event.EXIT_FRAME, onExitFrame);

			_arLib.addListener(IN2ARDetectionEvent.DETECTED, onMarkerDetected);
			_arLib.addListener(IN2ARDetectionEvent.FAILED, onMarkerDetectionFailed);


			initCamera();

			dispatch(new ARModelEvent(ARModelEvent.ON_INIT_AUG_REALITY));

			isARRunning = true;

			logger.info("Aug Reality Complete");

			logger.info("isProcessingData: " + isProcessingData + ", isCameraReady: " + isCameraReady + ", isDataReady: " + isDataReady  + ", isMarkerDetected: " + isMarkerDetected);
		}

		private function onVideoFrame(event:Event):void
		{
			isCameraReady = true;
		}

		private function onExitFrame(event:Event):void
		{
			//logger.info("onExitFrame: isDataReady: " + isDataReady );
			if (isDataReady)
			{
				arLib.run();
			}

		}

		private function onEnterFrame(event:Event):void
		{
			//logger.info("onEnterFrame: isProcessingData: " + isProcessingData + ", isCameraReady " + isCameraReady);
			if (isProcessingData == false && isCameraReady == true)
			{
				isProcessingData = true;
				camera.drawToBitmapData(_cameraBuffer);
				isCameraReady = false;
				arLib.addBitmapFrame(_cameraBuffer);
				isDataReady = true;
			}

		}


		private function onMarkerDetected(event : IN2ARDetectionEvent):void
		{
			//logger.info("onMarkerDetected: After: " + event. );
			if (isProcessingData)
			{
				isDataReady = false;
				isProcessingData = false;
			}


			if (isMarkerDetected == false)
			{
				dispatch(new ARModelEvent(ARModelEvent.ON_MARKER_DETECTED));
				isMarkerDetected = true;
			}

			var refList:Vector.<IN2ARReference> = event.detectedReferences;
			var refCount:int = event.detectedReferencesCount;

			for(var i:int = 0; i < refCount; ++i)
			{
				var ref:IN2ARReference = refList[i];
				var evt : ARModelEvent = new ARModelEvent(ARModelEvent.ON_MARKER_UPDATE);
				evt.ref = ref;
				dispatch(evt);
			}
		}

		private function onMarkerDetectionFailed(event : IN2ARDetectionEvent):void
		{
			//logger.info("onMarkerDetectionFailed: Afer: " + getTimer() + " " + isProcessingData );
			if (isProcessingData)
			{
				isDataReady = false;
				isProcessingData = false;
			}

			if (isMarkerDetected == true)
			{
				//logger.info("***********************  Lost Marker Lost");
				dispatch(new ARModelEvent(ARModelEvent.ON_MARKER_LOST));
				isMarkerDetected = false;
				arLib.resetDetection();
			}

		}

		private function initCamera():void
		{
			camera = Camera.getCamera("0");
			//logger.info(Camera.names);


			camera.setMode(cameraWidth, cameraHeight, 25, false);
			camera.setLoopback(false);

			_cameraBuffer = new BitmapData(cameraWidth, cameraHeight, true, 0x0);

			_lens = new Away3DCameraLens();
			_lens.updateProjection(params.fx, params.fy, 1920, 1080, cameraWidth, cameraHeight);
//
			vTexture = stage3DProxy.context3D.createVideoTexture();
			vTexture.attachCamera(camera);
//
//			var texture : Texture = Texture.fromCamera(camera, 1);
			_cTexture = new ConcreteTexture(vTexture, Context3DTextureFormat.BGRA, cameraWidth, cameraHeight, false, true, true, -1);

			camera.addEventListener(Event.VIDEO_FRAME, onVideoFrame);

			camera.drawToBitmapData(_cameraBuffer);

			arLib.detect(_cameraBuffer);
		}


		public function destroyAugReality():void
		{
			logger.info("isProcessingData: " + isProcessingData + ", isCameraReady: " + isCameraReady + ", isDataReady: " + isDataReady  + ", isMarkerDetected: " + isMarkerDetected);

			_stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			_stage.removeEventListener(Event.EXIT_FRAME, onExitFrame);
			camera.removeEventListener(Event.VIDEO_FRAME, onVideoFrame);

			_arLib.removeListener(IN2ARDetectionEvent.DETECTED, onMarkerDetected);
			_arLib.removeListener(IN2ARDetectionEvent.FAILED, onMarkerDetectionFailed);
			_arLib.resetDetection();
			_arLib.destroy();

			isProcessingData  = false;
			isCameraReady = false;
			isDataReady = false;
			isMarkerDetected = false;

			vTexture.dispose();
			vTexture = null;

			_cTexture.dispose();
			_cTexture = null;

			_arLib = null;
			camera = null;

			isARRunning = false;
			dispatch(new ARModelEvent(ARModelEvent.ON_DESTROY_AUG_REALITY));

			logger.info("destroyAugReality");




			//arShell = null;
		}





		public function get stage():Stage
		{
			return _stage;
		}

		public function set stage(value:Stage):void
		{
			_stage = value;
		}


		public function get params():IntrinsicParameters
		{
			return _params;
		}

		public function set params(value:IntrinsicParameters):void
		{
			_params = value;
		}


		public function get arLib():IIN2AR
		{
			return _arLib;
		}

		public function set arLib(value:IIN2AR):void
		{
			_arLib = value;
		}


		public function get hasAugRealityInitialize():Boolean
		{
			return _hasAugRealityInitialize;
		}

		public function set hasAugRealityInitialize(value:Boolean):void
		{
			_hasAugRealityInitialize = value;
		}


		public function get cameraBuffer():BitmapData
		{
			return _cameraBuffer;
		}

		public function set cameraBuffer(value:BitmapData):void
		{
			_cameraBuffer = value;
		}

		public function get stage3DProxy():Stage3DProxy
		{
			return _stage3DProxy;
		}

		public function set stage3DProxy(value:Stage3DProxy):void
		{
			_stage3DProxy = value;
		}


		public function get cTexture():ConcreteTexture
		{
			return _cTexture;
		}

		public function set cTexture(value:ConcreteTexture):void
		{
			_cTexture = value;
		}


		public function get lens():Away3DCameraLens
		{
			return _lens;
		}

		public function set lens(value:Away3DCameraLens):void
		{
			_lens = value;
		}
	}
}
