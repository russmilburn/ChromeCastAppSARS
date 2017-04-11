/**
 * Created by russellmilburn on 24/07/15.
 */
package com.tro.chromecast.views
{

	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	import com.tro.chromecast.views.components.buttons.ImageButton;
	import com.tro.chromecast.views.components.buttons.KeyPadNumber;
	import com.tro.chromecast.views.components.buttons.PinCodeBackButton;
	import com.tro.chromecast.views.components.PinCodeInput;

	import starling.display.BlendMode;

	import starling.display.Canvas;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.textures.Texture;
	import starling.display.BlendMode;

	public class LoginView extends View
	{
		private var chromeCastLogoSprite:Sprite;

		private var _jbHiFiLogoSprite:ImageButton;

		private var _backspaceBtn:PinCodeBackButton;

		private var pinCodeInputArray:Array = [];

		private var buttonArray:Array = [];

		private var pinBoxContainer:Sprite;

		private var index:int = -1;
		private var _instructionsText:TextField;
		private var _versionInfo:TextField;

		public function LoginView()
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
		}

		private function setupDisplay():void
		{
			setupButtons();
			setupImages();

			dispatchEvent(new ViewEvent(ViewEvent.ON_VIEW_INIT_COMPLETE));
		}

		private function setupButtons():void
		{
			var xPos:Number = 115 - 14;
			var yPos:Number = stage.stageHeight - 50;
			var padding:Number = 55;

			var keyPadNumberBtn:KeyPadNumber;

			for (var i:int = 0; i < 10; i++)
			{
				keyPadNumberBtn = new KeyPadNumber();

				keyPadNumberBtn.x = xPos;
				keyPadNumberBtn.y = yPos - keyPadNumberBtn.height;
				xPos = keyPadNumberBtn.x + padding + keyPadNumberBtn.width;
				buttonArray.push(keyPadNumberBtn);
				addChild(keyPadNumberBtn);
				if (i < 9)
				{
					keyPadNumberBtn.setLabelText((i + 1).toString());

				}
				else
				{
					keyPadNumberBtn.setLabelText((0).toString());
				}
			}

			_backspaceBtn = new PinCodeBackButton();
			_backspaceBtn.textureSprite = assetManager.getTexture("BackSpace");
			_backspaceBtn.x = xPos + 10;
			_backspaceBtn.y = yPos - keyPadNumberBtn.height +(keyPadNumberBtn.height / 2) - (_backspaceBtn.height / 2);
			addChild(_backspaceBtn);
		}

		private function setupImages():void
		{
			chromeCastLogoSprite = getTexturesSprite("ChromeCastLogoLoginView");
			chromeCastLogoSprite.x = 141;
			chromeCastLogoSprite.y = 108;

			var texture : Texture = assetManager.getTexture("JBHifiLogo");

			_jbHiFiLogoSprite = new ImageButton();
			_jbHiFiLogoSprite.texture = texture;
			_jbHiFiLogoSprite.blendMode = BlendMode.NONE;

			//jbHiFiLogoSprite = getTexturesSprite("PinCodeView_JB_HIFI_IMG");
			_jbHiFiLogoSprite.x = 1398;
			_jbHiFiLogoSprite.y = 117;

			//TODO : Refactor to text
			_instructionsText = new TextField(1000, 100, "blah");
			_instructionsText.touchable = false;
			_instructionsText.autoSize = TextFieldAutoSize.HORIZONTAL;
			_instructionsText.fontName = "Roboto";
			_instructionsText.fontSize = 50;
			_instructionsText.text = "Enter 4 digit code";
			_instructionsText.color = 0x898989;
			_instructionsText.x = (stage.stageWidth - _instructionsText.width) / 2;
			_instructionsText.y =( (stage.stageHeight - _instructionsText.height) / 2) - 50;

			var xPos:Number = 0;
			pinBoxContainer = new Sprite();

			var pinCodeInput:PinCodeInput;

			for (var i:Number = 0; i < 4; i++)
			{
				//trace("adding boxes to stage");
				pinCodeInput = new PinCodeInput();
				pinCodeInput.spriteTexture = assetManager.getTexture("InputBox");

				pinCodeInput.x = 576 + xPos;
				pinCodeInput.y = 575;

				pinBoxContainer.addChildAt(pinCodeInput, 0);
				pinCodeInputArray.push(pinCodeInput);
				xPos += 49 + pinCodeInput.width;
			}

			_versionInfo = new TextField(100, 40, "");
			_versionInfo.touchable = false;
			_versionInfo.autoSize = TextFieldAutoSize.HORIZONTAL;
			_versionInfo.fontName = "Roboto";
			_versionInfo.fontSize = 25;
			_versionInfo.text = "Version : 1.0";
			_versionInfo.color = 0x898989;
			_versionInfo.x = stage.stageWidth - _versionInfo.width - 25;
			_versionInfo.y = stage.stageHeight - _versionInfo.height;

			addChild(pinBoxContainer);
			addChild(chromeCastLogoSprite);
			addChild(_jbHiFiLogoSprite);
			addChild(_instructionsText);
			addChild(_versionInfo);
		}

		public function backspaceButtonPressed():void
		{
			//trace(this + " index -" + index);
			pinCodeInputArray[index].update("");
			prev();
		}

		public function updatePinCodeBox(string:String, value:Number):void
		{

			pinCodeInputArray[value - 1].update(string);
			next();
		}


		private function animate():void
		{
			var xPos:Number = pinCodeInputArray[index].x;
			TweenMax.to(_backspaceBtn, 0.5, {x: xPos});
		}

		private function next():void
		{
			index++;
			//trace("Index next: " + index);
			if (index >= pinCodeInputArray.length)
			{
				return;
			}

			//animate();
		}

		private function prev():void
		{
			index--;
			//trace("Index Prev: " + index);
			if (index < 0)
			{
				return;
			}

			//animate();
		}

		public function disableButtons():void
		{
			for (var i:Number = 0; i < buttonArray.length; i++)
			{
				buttonArray[i].disableButtons();
			}
		}

		public function enableButtons():void
		{
			for (var i:Number = 0; i < buttonArray.length; i++)
			{
				buttonArray[i].enableButtons();
			}
		}

		public function displayFailFeedback():void
		{
			var tl:TimelineMax = new TimelineMax();
			var origX:Number = pinBoxContainer.x;
			tl.add(TweenMax.to(pinBoxContainer, .3, {x: origX - 25, ease: Bounce.easeOut}));
			tl.add(TweenMax.to(pinBoxContainer, .3, {x: origX, ease: Bounce.easeOut, onComplete: clearPinCode}));
		}

		public function clearPinCode():void
		{
			for (var i:Number = 0; i < pinCodeInputArray.length; i++)
			{
				pinCodeInputArray[i].update("");
			}

			index = -1;
		}


		public function get backspaceBtn():PinCodeBackButton
		{
			return _backspaceBtn;
		}

		public function set backspaceBtn(value:PinCodeBackButton):void
		{
			_backspaceBtn = value;
		}


		public function get jbHiFiLogoSprite():ImageButton
		{
			return _jbHiFiLogoSprite;
		}

		public function set jbHiFiLogoSprite(value:ImageButton):void
		{
			_jbHiFiLogoSprite = value;
		}
	}

}
