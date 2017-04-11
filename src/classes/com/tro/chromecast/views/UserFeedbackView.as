/**
 * Created by russellmilburn on 04/08/15.
 */
package com.tro.chromecast.views
{

	import starling.display.Canvas;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;

	public class UserFeedbackView extends View
	{
		public function UserFeedbackView()
		{
			super();
		}


		override protected function onViewInit():void
		{
			super.onViewInit();


			var _label:TextField = new TextField(1000, 100, "blah");
			_label.touchable = false;
			_label.autoSize = TextFieldAutoSize.HORIZONTAL;
			_label.fontName = "Roboto";
			_label.fontSize = 60;
			_label.text = "Just a second...";
			_label.color = 0x656666;
			_label.x = (stage.stageWidth - _label.width) / 2;
			_label.y = (stage.stageHeight - _label.height) / 2;

			addChild(_label);

			dispatchEvent(new ViewEvent(ViewEvent.ON_VIEW_INIT_COMPLETE));
		}

		override protected function initStageAssets():void
		{

		}
	}
}
