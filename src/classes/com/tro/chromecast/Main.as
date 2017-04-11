package com.tro.chromecast
{

	import com.tro.chromecast.views.ViewRoot;

	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	[SWF(backgroundColor="#000000", frameRate='60')]
	public class Main extends Sprite
	{
		private var viewRoot : ViewRoot;
		public function Main()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			viewRoot = new ViewRoot();

			addChild(viewRoot);
		}
	}
}
