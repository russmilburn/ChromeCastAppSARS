/**
 * Created by russellmilburn on 29/09/15.
 */
package com.tro.chromecast.views
{

	import com.tro.chromecast.views.components.GradientText;
	import com.tro.chromecast.views.components.PopUpMagnifier;
	import com.tro.chromecast.views.components.SwipeControl;
	import com.tro.chromecast.views.components.SwipeToContinue;

	import starling.display.Sprite;

	public class BackdropSlideShowView extends View
	{
		private var swipeControl:SwipeControl;
		private var _gradient:GradientText;
		private var _slideContainer:Sprite;
		private var _popUp : PopUpMagnifier;

		public function BackdropSlideShowView()
		{
			super();
		}

		override protected function onViewInit():void
		{
			swipeControl = new SwipeControl();
			addChild(swipeControl);

			swipeControl.width = this.stage.stageWidth;
			swipeControl.height = this.stage.stageHeight;

			super.onViewInit();

		}

		override protected function initStageAssets():void
		{
			_gradient = new GradientText();
			_gradient.setGradientTexture(getTexture("gradient"));
			_gradient.y = stage.stageHeight - _gradient.height;

			_gradient.touchable = false;

			_slideContainer = new Sprite();
			_slideContainer.touchable = false;

			_popUp = new PopUpMagnifier();
			_popUp.setBackgroundImage(getTexture("SlideShow0PopUp"));
			_popUp.enablePopUpButton();

			addChild(_slideContainer);
			addChild(_popUp);
			addChild(_gradient);
			

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


		public function get slideContainer():Sprite
		{
			return _slideContainer;
		}

		public function set slideContainer(value:Sprite):void
		{
			_slideContainer = value;
		}


		public function get popUp():PopUpMagnifier
		{
			return _popUp;
		}

		public function set popUp(value:PopUpMagnifier):void
		{
			_popUp = value;
		}
	}
}
