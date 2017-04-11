/**
 * Created by russellmilburn on 15/09/15.
 */
package com.tro.chromecast.views.connectsectionviews
{

	import com.tro.chromecast.views.*;
	import com.tro.chromecast.views.components.GradientText;
	import com.tro.chromecast.views.components.SwipeControl;
	import com.tro.chromecast.views.components.TVDisplay;
	import com.tro.chromecast.views.components.buttons.ImageButton;

	import starling.display.Sprite;

	public class ChooseDeviceOsView extends View
	{
		private var swipeControl:SwipeControl;

		private var _androidIcon : ImageButton;
		private var _appleIcon : ImageButton;
		private var _tvDisplay : TVDisplay;
		private var _iconContainer : Sprite;
		private var _gradient : GradientText;
		public function ChooseDeviceOsView()
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

			_gradient.setText("Choose your platform");

			_tvDisplay  = new TVDisplay();
			_tvDisplay.tvDisplayVo = getContentVo();
			_tvDisplay.touchable = false;
			_tvDisplay.x = (stage.stageWidth - _tvDisplay.width) / 2 ;
			_tvDisplay.y = 50;
			_tvDisplay.touchable = false;

			_iconContainer = new Sprite();

			_androidIcon = new ImageButton();
			_androidIcon.texture = assetManager.getTexture("AndroidIconLarge");

			_appleIcon = new ImageButton();
			_appleIcon.x = _androidIcon.x + _androidIcon.width + 150;
			_appleIcon.texture = assetManager.getTexture("AppleIconLarge");

			addChild(_tvDisplay);
			addChild(_gradient);

			_iconContainer.addChild(_androidIcon);
			_iconContainer.addChild(_appleIcon);

			addChild(_iconContainer);

			_iconContainer.x = (stage.stageWidth - _iconContainer.width) / 2;
			_iconContainer.y = (stage.stageHeight - _iconContainer.height - 200) / 2;

			dispatchEvent(new ViewEvent(ViewEvent.ON_VIEW_INIT_COMPLETE));
		}


		public function get androidIcon():ImageButton
		{
			return _androidIcon;
		}

		public function set androidIcon(value:ImageButton):void
		{
			_androidIcon = value;
		}

		public function get appleIcon():ImageButton
		{
			return _appleIcon;
		}

		public function set appleIcon(value:ImageButton):void
		{
			_appleIcon = value;
		}
	}
}
