/**
 * Created by tro on 31/07/2015.
 */
package com.tro.chromecast.views
{

	import com.greensock.TweenMax;
	import com.greensock.easing.*;
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
	import starling.utils.HAlign;

	public class SwipeInstructionsView extends View
	{
		private static const CHROME_LOGO_X:Number = 801;
		private static const CHROME_LOGO_Y:Number = 470;
		private static const ANIMATION_WIDTH:Number = 500;
		private static const HAND_X:Number = 1050;
		
		private var maskWidth:Number = 428;
		private var maskHeight:Number = 270;
		
		private var maskMc:Sprite;
		private var titleSprite:Sprite;
		private var chromeCastLogoSpriteA:Sprite;
		private var chromeCastLogoSpriteB:Sprite;
		private var handSprite:Sprite;
		
		private var deviceSprite:Sprite;
		
		private var chromeCastLogoContainer:Sprite;
		
		private var swipeControl:SwipeControl;
		private var _instructionsText:TextField;
		private var _titleText:TextField;
		private var _swipeToContinue:SwipeToContinue;
		
		public function SwipeInstructionsView()
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
			setupDisplay();
			
			swipeControl = new SwipeControl();
			
			addChild(swipeControl);
			
			swipeControl.width = this.stage.stageWidth;
			swipeControl.height = this.stage.stageHeight;
		}
		
		private function setupDisplay():void
		{
			setupImages();
		}
		
		private function setupImages():void
		{
			//TODO : Refactor To Text
			
			
			_titleText = new TextField(1000, 100, "blah");
			_titleText.touchable = false;
			_titleText.autoSize = TextFieldAutoSize.HORIZONTAL;
			_titleText.fontName = "Roboto";
			_titleText.fontSize = 50;
			_titleText.text = "Welcome to Chromecast.";
			_titleText.hAlign = HAlign.RIGHT;
			_titleText.color = 0x898989;
			_titleText.x = (stage.stageWidth - _titleText.width) / 2;
			_titleText.y = ( (stage.stageHeight - _titleText.height) / 2) - 400;

			_instructionsText = new TextField(1000, 100, "blah");
			_instructionsText.touchable = false;
			_instructionsText.autoSize = TextFieldAutoSize.HORIZONTAL;
			_instructionsText.fontName = "Roboto";
			_instructionsText.fontSize = 50;
			_instructionsText.text = "Just swipe left or right to navigate.";
			_instructionsText.color = 0x898989;
			_instructionsText.x = (stage.stageWidth - _instructionsText.width) / 2;
			_instructionsText.y =( (stage.stageHeight - _instructionsText.height) / 2) - 300;

			deviceSprite =  getTexturesSprite("DeviceInstructionsView");
			deviceSprite.x = 664;
			deviceSprite.y = 417;

			chromeCastLogoContainer = new Sprite();

			chromeCastLogoSpriteA = getTexturesSprite("ChromeCastLogoInstrutions");
			chromeCastLogoSpriteA.x = CHROME_LOGO_X;
			chromeCastLogoSpriteA.y = CHROME_LOGO_Y;

			chromeCastLogoSpriteB = getTexturesSprite("ChromeCastLogoInstrutions");
			chromeCastLogoSpriteB.x = CHROME_LOGO_X + ANIMATION_WIDTH;
			chromeCastLogoSpriteB.y = CHROME_LOGO_Y;

			var handTexture:Texture =  assetManager.getTexture("Hand");
			var handImage:Image = new Image(handTexture);

			handSprite = new Sprite();
			handSprite.x = HAND_X;
			handSprite.y = 1335;
			handSprite.addChild(handImage);

			handImage.x = -handImage.width/2;
			handImage.y = -handImage.height;

			maskMc = getTexturesSprite("Mask");
			maskMc.width = maskWidth;
			maskMc.height = maskHeight;
			maskMc.x = 765;
			maskMc.y = 435;

			_swipeToContinue = new SwipeToContinue();
			_swipeToContinue.titleField.color = 0x898989;
			_swipeToContinue.y = ( (stage.stageHeight - _swipeToContinue.height) / 2) - 200;
			_swipeToContinue.x = (stage.stageWidth - _swipeToContinue.width) / 2; 
			
			addChild(deviceSprite);
			addChild(chromeCastLogoContainer);
			addChild(handSprite);
			addChild(maskMc);
			addChild(_instructionsText);
			addChild(_titleText);
			addChild(_swipeToContinue);
			

			chromeCastLogoContainer.addChild(chromeCastLogoSpriteA);
			chromeCastLogoContainer.addChild(chromeCastLogoSpriteB);

			chromeCastLogoContainer.mask = maskMc;

			dispatchEvent(new ViewEvent(ViewEvent.ON_VIEW_INIT_COMPLETE));
		}

		public function animate():void
		{
			var delay:Number = 0;

			if (this.visible == false)
			{
				return;
			}

			TweenMax.to(handSprite, .3, {rotation: -.2,x: HAND_X - 100, delay: delay+.5, ease:Strong.easeOut});//
			TweenMax.to(handSprite, .5, {rotation: 0,x: HAND_X, delay: delay+.7});//rotation: 0,

			TweenMax.to(chromeCastLogoSpriteA, .5, {x: CHROME_LOGO_X - ANIMATION_WIDTH, delay: delay+.3, ease:Strong.easeIn});
			TweenMax.to(chromeCastLogoSpriteB, .5, {x: CHROME_LOGO_X, delay: delay+.3, ease:Strong.easeIn});

			TweenMax.to(handSprite, .3, {rotation: .2,x: HAND_X + 100, delay: delay+2, ease:Strong.easeOut});//rotation: 25,
			TweenMax.to(handSprite, .5, {rotation: 0,x: HAND_X, delay: delay+2.3});//rotation: 0,

			TweenMax.to(chromeCastLogoSpriteA, .5, {x: CHROME_LOGO_X, delay: delay+1.8, ease:Strong.easeIn});
			TweenMax.to(chromeCastLogoSpriteB, .5, {x: CHROME_LOGO_X + ANIMATION_WIDTH, delay: delay+1.8 , ease:Strong.easeIn, onComplete:replayAnimation});
		}

		public function reset():void
		{
			TweenMax.killTweensOf(this);
			handSprite.rotation = 0;
			chromeCastLogoSpriteA.x = CHROME_LOGO_X;
			chromeCastLogoSpriteB.x = CHROME_LOGO_X + ANIMATION_WIDTH;
		}

		private function replayAnimation():void
		{
			animate();
		}
	}
}
