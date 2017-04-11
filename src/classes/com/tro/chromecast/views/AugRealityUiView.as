/**
 * Created by russellmilburn on 31/08/15.
 */
package com.tro.chromecast.views
{

	import com.tro.chromecast.models.vos.DeviceTypeVo;
	import com.tro.chromecast.views.components.SwipeToContinue;
	import com.tro.chromecast.views.View;
	import com.tro.chromecast.views.components.GradientText;
	import com.tro.chromecast.views.components.SwipeControl;

	import starling.display.Sprite;

	public class AugRealityUiView extends View
	{
		private var _swipeControl:SwipeControl;


		private var _uiContainer : Sprite;
		private var _gradient:GradientText;
		
		private var _swipeToContinue:SwipeToContinue;
		
		public function AugRealityUiView()
		{
			super();
		}


		override protected function onViewInit():void
		{
			_swipeControl = new SwipeControl(0xff0000);
			addChild(_swipeControl);

			_swipeControl.setRectWidth(this.stage.stageWidth);
			_swipeControl.setRectHeight(this.stage.stageHeight);


			super.onViewInit();

			super._viewBackground.visible = false;
		}

		override protected function initStageAssets():void
		{
			_uiContainer = new Sprite();

			_gradient = new GradientText();

			_gradient.setGradientTexture(getTexture("gradient"));
			_gradient.y = stage.stageHeight - _gradient.height;

			_uiContainer.addChild(_gradient);

			_swipeToContinue = new SwipeToContinue();
			_swipeToContinue.visible = false;
			_swipeToContinue.x = (stage.stageWidth - _swipeToContinue.width) / 2;
			_swipeToContinue.titleField.color = 0xFFFFFF;
			_swipeToContinue.y = stage.stageHeight - swipeToContinue.height - 50;
			
			
			addChild(_swipeControl);
			addChild(_uiContainer);
			addChild(_swipeToContinue);
			
			dispatchEvent(new ViewEvent(ViewEvent.ON_VIEW_INIT_COMPLETE));
		}

		public function get gradient():GradientText
		{
			return _gradient;
		}

		public function set gradient(value:GradientText):void
		{
			_gradient = value;
		}

		public function get uiContainer():Sprite
		{
			return _uiContainer;
		}

		public function set uiContainer(value:Sprite):void
		{
			_uiContainer = value;
		}

		public function get swipeControl():SwipeControl
		{
			return _swipeControl;
		}

		public function set swipeControl(value:SwipeControl):void
		{
			_swipeControl = value;
		}
		
		public function get swipeToContinue():SwipeToContinue 
		{
			return _swipeToContinue;
		}
		
		public function set swipeToContinue(value:SwipeToContinue):void 
		{
			_swipeToContinue = value;
		}
	}
}
