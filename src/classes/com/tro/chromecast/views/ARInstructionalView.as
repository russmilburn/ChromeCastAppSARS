/**
 * Created by tro on 28/07/2015.
 */
package com.tro.chromecast.views
{

	import com.greensock.events.TweenEvent;
	import com.tro.chromecast.views.components.SwipeControl;
	import com.tro.chromecast.views.components.SwipeToContinue;

	import starling.display.BlendMode;

	import starling.display.Canvas;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.textures.Texture;
	import starling.utils.AssetManager;

	import com.greensock.TweenMax;
	import com.greensock.TimelineMax;
	import com.greensock.easing.*;

	import starling.utils.HAlign;

	public class ARInstructionalView extends View
	{

		private var titleSprite:Sprite;
		private var boxSprite:Sprite;
		private var handAndDeviceSprite:Sprite;
		private var manBackgroundRightSprite:Sprite;
		private var pointYourDeviceSprite:Sprite;
		private var rotatingArmRight:Image;
		private var rotatingArmRightSprite:Sprite;
		private var timeline:TimelineMax;
		private var swipeControl:SwipeControl;

		private var xPadding:Number;
		private var yPadding:Number;
		private var _instructionsText:TextField;
		
		private var _swipeToContinue:SwipeToContinue;

		public function ARInstructionalView()
		{
			super();
		}
		
		override protected function onViewInit():void
		{
			super.onViewInit();
			
			removeChild(_viewBackground);
			
			_viewBackground = new Canvas();
			_viewBackground.beginFill(0xFFFFFF, 1);
			_viewBackground.drawRectangle(0,0, stage.stageWidth, stage.stageHeight);
			_viewBackground.touchable = false;
			_viewBackground.blendMode = BlendMode.NONE;
			
			addChildAt(_viewBackground, 0);
		}
		
		override protected function initStageAssets():void
		{
			addSprites();
			
			swipeControl = new SwipeControl();
			addChild(swipeControl);
			
			swipeControl.height = stage.stageHeight;
			swipeControl.width = stage.stageWidth;
		}
		
		private function addSprites():void
		{
			xPadding = 100;
			yPadding = 100;
			
			//TODO: Refactor to text
			_instructionsText = new TextField(1000, 0, "");
			_instructionsText.autoSize = TextFieldAutoSize.VERTICAL;
			_instructionsText.hAlign = HAlign.CENTER;
			_instructionsText.fontName = "Roboto";
			_instructionsText.fontSize = 50;
			_instructionsText.color = 0x898989;
			_instructionsText.touchable = false;
			_instructionsText.text = "Point your device’s camera at the back of the\nChromecast box while holding your\ndevice at a 45 degree angle.";
			_instructionsText.x = (stage.stageWidth - _instructionsText.width) / 2;
			_instructionsText.y =( (stage.stageHeight - _instructionsText.height) / 2) - 300;
			
			boxSprite = getTexturesSprite("BoxBackground");
			boxSprite.x = 520 - xPadding;
			boxSprite.y = 570 - yPadding;
			
			handAndDeviceSprite = getTexturesSprite("HandAndDevice");
			handAndDeviceSprite.x = 50 - xPadding;
			handAndDeviceSprite.y = 800 - yPadding;
			
			manBackgroundRightSprite = getTexturesSprite("ManHoldingDevice");
			manBackgroundRightSprite.x = 1082 - xPadding;
			manBackgroundRightSprite.y = 633 - yPadding;

			rotatingArmRightSprite = getTexturesSprite("RotatingArmRight");
			rotatingArmRightSprite.x = 2000 - xPadding;
			rotatingArmRightSprite.y = 632 - yPadding;
			rotatingArmRightSprite.rotation = 0;

			rotatingArmRight = Image(rotatingArmRightSprite.getChildByName("image"));
			rotatingArmRight.x = -rotatingArmRight.width;
			rotatingArmRight.y = -rotatingArmRight.height;
			
			_swipeToContinue = new SwipeToContinue();
			_swipeToContinue.y = stage.stageHeight - _swipeToContinue.height - 25;
			_swipeToContinue.x = (stage.stageWidth - _swipeToContinue.width) / 2; 
			
			addChild(_instructionsText);
			addChild(boxSprite);
			addChild(handAndDeviceSprite);
			addChild(manBackgroundRightSprite);
			addChild(rotatingArmRightSprite);
			addChild(_swipeToContinue);
			
			dispatchEvent(new ViewEvent(ViewEvent.ON_VIEW_INIT_COMPLETE));
		}

		public function animate():void
		{
			//dispatchEvent(new ARInstructionalViewEvent(ARInstructionalViewEvent.ON_ANIMATION_START));

			timeline = new TimelineMax();
			timeline.insert(TweenMax.to(handAndDeviceSprite, 3, {x: 165 - xPadding, y: 547 - yPadding}));
			timeline.insert(TweenMax.to(rotatingArmRightSprite, 3, {rotation: -.85}));
			timeline.insert(TweenMax.to(manBackgroundRightSprite, .5, {alpha: 1}));
			//timeline.startTime(0);
		}

		public function reset() : void
		{
			try
			{
				timeline.stop();
				timeline = null;

				handAndDeviceSprite.x = 50 - xPadding;
				handAndDeviceSprite.y = 800 - yPadding;

				rotatingArmRightSprite.x = 2000 - xPadding;
				rotatingArmRightSprite.y = 632 - yPadding;
				rotatingArmRightSprite.rotation = 0;
			}
			catch (error : Error )
			{

			}

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
