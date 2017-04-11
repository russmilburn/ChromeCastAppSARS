/**
 * Created by russellmilburn on 27/07/15.
 */
package com.tro.chromecast.models
{

	import away3d.core.managers.Stage3DProxy;
	import com.tro.chromecast.models.vos.TrackingVo;
	import com.tro.chromecast.service.DatabaseService;
	import flash.utils.getTimer;

	import com.tro.chromecast.events.AppEvent;

	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.SampleDataEvent;

	public class StageModel extends AbstractModel
	{
		private var _stage : Stage;
		private var _stage3DProxy : Stage3DProxy;
		private var _stageWidth : Number;
		private var _stageHeight : Number;

		public function StageModel()
		{
			super();
		}

		public function get stage():Stage
		{
			return _stage;
		}

		public function set stage(value:Stage):void
		{
			_stage = value;
			_stage.addEventListener(Event.RESIZE, onStageResize);

			_stage.addEventListener(Event.DEACTIVATE, onDeactivate);
			//_stage.addEventListener(Event.CLOSING, onDeactivate);

		}

		private function onDeactivate(event:Event):void
		{
			var trackingVo : TrackingVo = new TrackingVo();
			trackingVo.code = "SESSION_DURATION";
			trackingVo.parameter = "SessionDuration";
			trackingVo.value = getTimer()/1000;
			
			var floxEvt : AppEvent = new AppEvent(AppEvent.TRACK_INTERACTION);
			floxEvt.trackingVo = trackingVo;
			dispatch(floxEvt);
			
			var evt : AppEvent = new AppEvent(AppEvent.ON_CLOSE_APP);
			dispatch(evt);
		}

		private function onStageResize(event:Event):void
		{
			//logger.info("OnStageResize: stage width: " + stage.width +", stage height: " + stage.height);

			stageWidth = stage.width;
			stageHeight = stage.height;

			updateStageSize();
		}

		private function updateStageSize() : void
		{
			var evt : StageModelEvent = new StageModelEvent(StageModelEvent.ON_UPDATE_STAGE_SIZE);
			evt.stageWidth = this._stageWidth;
			evt.stageHeight = this._stageHeight;
			dispatch(evt);
		}


		public function get stage3DProxy():Stage3DProxy
		{
			return _stage3DProxy;
		}

		public function set stage3DProxy(value:Stage3DProxy):void
		{
			_stage3DProxy = value;
		}


		public function get stageWidth():Number
		{
			return _stageWidth;
		}

		public function set stageWidth(value:Number):void
		{
			_stageWidth = value;

			updateStageSize();

			//stage3DProxy.width = _stageWidth;

		}

		public function get stageHeight():Number
		{
			return _stageHeight;
		}

		public function set stageHeight(value:Number):void
		{
			_stageHeight = value;

			updateStageSize();
			//stage3DProxy.height = stageHeight;
		}
	}
}
