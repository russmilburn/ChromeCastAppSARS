package com.tro.chromecast.views
{
	import starling.display.Canvas;
	import starling.display.Sprite;
	import starling.animation.Tween;
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.EnterFrameEvent;
	import starling.display.Quad;
	import starling.display.BlendMode;
	
	import com.tro.chromecast.views.components.GradientText;
	import com.tro.chromecast.views.components.SwipeControl;
	import com.tro.chromecast.views.components.plugin.GlowingAssets;
	
	/**
	 * ...
	 * @author David Armstrong
	 */
	
	public class PluginDragView extends View
	{
		private var _swipeControl:SwipeControl;
		
		private var _tvDisplay:MovieClip;
		private var _tvBack:Image;
		private var _gradient:GradientText;
		private var _tvReversed:Boolean = false;
		
		private var _powerpoint:Image;
		private var _hdmi:Image;
		private var _hdmiGlow:Image;
		
		private var _chromecast:GlowingAssets;
		private var _chromecastContainer:Sprite;
		private var _cable:MovieClip;
		private var _cableContainer:Sprite;
		
		private static const tvPlugX:int = 1192;
		
		private static const _chromecastStartX:int = 595;
		private static const _chromecastEndX:int = tvPlugX - 416 + 90;
		private var _cableStartX:int;
		
		private static const tvMask:Quad = new Quad(tvPlugX + 4, 1080);
		
		public static const TV_IN_DONE:String = "TV_IN_DONE";
		public static const TV_OUT_DONE:String = "TV_OUT_DONE";
		
		public function PluginDragView()
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
		}
		
		override protected function initStageAssets():void
		{
			_tvDisplay = new MovieClip(assetManager.getTextures("PlugIn_TV_Spin_"), 20);
			_tvDisplay.touchable = false;
			_tvDisplay.loop = false;
			_tvDisplay.visible = true;
			addChild(_tvDisplay);
			_tvDisplay.pivotX = _tvDisplay.width * 0.5;
			_tvDisplay.pivotY = _tvDisplay.height * 0.5;
			_tvDisplay.scaleX = 1.2967741935483870967741935483871;
			_tvDisplay.scaleY = 1.2967741935483870967741935483871;
			_tvDisplay.x = stage.stageWidth * 0.5;
			_tvDisplay.y = stage.stageHeight * 0.5;
			
			_tvBack = new Image(getTexture("pluginTVback"));
			_tvBack.touchable = false;
			_tvBack.visible = false;
			_tvBack.x = stage.stageWidth;
			_tvBack.blendMode = BlendMode.NONE;
			addChild(_tvBack);
			
			_gradient = new GradientText();
			_gradient.setGradientTexture(getTexture("gradient"));
			_gradient.y = stage.stageHeight - _gradient.height;
			addChild(_gradient);
			_gradient.visible = false;
			_gradient.touchable = false;
			
			_powerpoint = new Image(getTexture("powerPoint"));
			_powerpoint.touchable = false;
			_powerpoint.visible = false;
			addChild(_powerpoint);
			_powerpoint.x = 175;
			_powerpoint.y = 655;
			
			_hdmi = new Image(getTexture("HDMI"));
			_hdmi.touchable = false;
			_hdmi.visible = false;
			addChild(_hdmi);
			
			_hdmiGlow = new Image(getTexture("HDMIGlow"));
			_hdmiGlow.touchable = false;
			_hdmiGlow.visible = false;
			addChild(_hdmiGlow);
			
			_cable = new MovieClip(assetManager.getTextures("cable-"), 60);
			_cable.loop = false;
			addChild(_cable);
			_cable.pivotX = _cable.width;
			_cable.visible = false;
			_cable.touchable = false;
			
			_chromecast = new GlowingAssets();
			_chromecast.mainSprite = new Image(getTexture("chromecastPlugin"));
			_chromecast.glowSprite = new Image(getTexture("chromecastPlugin-glow"));
			_chromecast.y = 200;
			_chromecast.pivotY = _chromecast.mainSprite.height * 0.5;
			_chromecast.visible = false;
			_chromecast.touchable = false;
			
			_chromecastContainer = new Sprite();
			addChild(_chromecastContainer);
			_chromecastContainer.mask = tvMask;
			_chromecastContainer.addChild(_chromecast);
			
			_cableStartX = (_chromecastStartX + 2);
			_cable.x = _cableStartX;
			_cable.y = _chromecast.y - 21;
			
			dispatchEvent(new ViewEvent(ViewEvent.ON_VIEW_INIT_COMPLETE));
		}
		
		// Chromecast interaction.
		
		public function get chromecast():GlowingAssets
		{
			return _chromecast;
		}
		
		public function set chromecast(value:GlowingAssets):void
		{
			_chromecast = value;
		}
		
		public function pluginChromecast(xValue:Number):Boolean
		{
			_chromecast.x += xValue;
			
			if (_chromecast.x < _chromecastStartX)
			{
				_chromecast.x = _chromecastStartX;
			}
			else if (_chromecast.x >= (_chromecastEndX - 50))
			{
				Starling.juggler.removeTweens(_cable);
				Starling.juggler.removeTweens(_chromecast);
				
				hdmiGlowOff();
				
				var cableTween:Tween = new Tween(_cable, 0.1, Transitions.EASE_IN);
				var chromecastTween:Tween = new Tween(_chromecast, 0.1, Transitions.EASE_IN);
				
				cableTween.moveTo(_chromecastEndX, _cable.y);
				chromecastTween.moveTo(_chromecastEndX, _chromecast.y);
				
				Starling.juggler.add(cableTween);
				Starling.juggler.add(chromecastTween);				
				
				return true;
			}
			
			_cable.x = _chromecast.x;
			return false;
		}
		
		// Cable interaction.
		
		public function get cable():MovieClip
		{
			return _cable;
		}
		
		public function set cable(value:MovieClip):void
		{
			_cable = value;
		}
		
		public function get gradient():GradientText
		{
			return _gradient;
		}
		
		public function set gradient(value:GradientText):void
		{
			_gradient = value;
		}
		
		public function tvDisplayPlay(reverse:Boolean = false):void
		{
			Starling.juggler.removeTweens(_tvDisplay);
			
			if (!reverse)
			{
				_tvDisplay.stop();
				_tvDisplay.play();
				
				addEventListener(EnterFrameEvent.ENTER_FRAME, tvBackSlideIn);
				Starling.juggler.add(_tvDisplay);
			}
			else
			{
				tvBackSlidOut();
			}
		}
		
		private function tvBackSlideIn(e:EnterFrameEvent):void
		{
			if (_tvDisplay.isComplete)
			{
				removeEventListener(EnterFrameEvent.ENTER_FRAME, tvBackSlideIn);
				
				Starling.juggler.removeTweens(_tvBack);
				
				_tvBack.visible = true;
				_tvDisplay.visible = false;
				var tween:Tween = new Tween(_tvBack, 1, Transitions.EASE_OUT);
				tween.moveTo(750, 0);
				tween.onComplete = function():void
				{
					dispatchEventWith(TV_IN_DONE);
					
					Starling.juggler.removeTweens(_hdmi);
					
					_hdmi.alpha = 0;
					_hdmi.visible = true;
					
					var tween:Tween = new Tween(_hdmi, 1);
					tween.fadeTo(1);
					
					Starling.juggler.add(tween);
				}
				
				Starling.juggler.add(tween);
			}		
		}
		
		private function tvBackSlidOut():void
		{
			Starling.juggler.removeTweens(_tvBack);
			Starling.juggler.removeTweens(_hdmi);
			
			chromecastOff();
			cableOff();
			
			var tween:Tween = new Tween(_tvBack, 1, Transitions.EASE_IN);
			tween.moveTo(stage.stageWidth, 0);
			tween.onComplete = function():void
			{
				_tvBack.visible = false;
				
				dispatchEventWith(TV_OUT_DONE);
			}
			
			var hdmiTween:Tween = new Tween(_hdmi, 0.25);
			hdmiTween.fadeTo(0);
			hdmiTween.onComplete = function():void
			{
				_hdmi.visible = false;
			}
			
			Starling.juggler.add(tween);
			Starling.juggler.add(hdmiTween);
		}
		
		public function chromecastOn():void
		{
			Starling.juggler.removeTweens(_chromecast);
			
			// Chromecast
			_chromecast.alpha = 0;
			_chromecast.x = _chromecastStartX;
			_chromecast.visible = true;
			
			var tween:Tween = new Tween(_chromecast, 0.35, Transitions.EASE_OUT);
			tween.fadeTo(1);
			tween.onComplete = function():void
			{
				_chromecast.touchable = true;
				_chromecast.startGlow();
			}
			
			// HDMI glow
			_hdmiGlow.alpha = 0;
			_hdmiGlow.visible = true;
			
			var hdmiGlowTween:Tween = new Tween(_hdmiGlow, 0.35, Transitions.EASE_OUT);
			hdmiGlowTween.fadeTo(0.3);
			hdmiGlowTween.onComplete = function():void
			{
				hdmiGlowOn();
			}			
			
			Starling.juggler.add(tween);
			Starling.juggler.add(hdmiGlowTween);			
		}
		
		public function chromecastOff():void
		{
			Starling.juggler.removeTweens(_chromecast);
			
			// Chromecast
			_chromecast.alpha = 1;
			_chromecast.touchable = false;
			
			var tween:Tween = new Tween(_chromecast, 0.35, Transitions.EASE_OUT);
			tween.fadeTo(0);
			tween.onComplete = function():void
			{
				_chromecast.visible = false;
				_chromecast.stopGlow();
			}
			
			Starling.juggler.add(tween);
		}
		
		public function hdmiGlowOn():void
		{
			Starling.juggler.removeTweens(_hdmiGlow);
			
			_hdmiGlow.alpha = 0.3;
			_hdmiGlow.visible = true;
			
			var tween:Tween = new Tween(_hdmiGlow, 0.85, Transitions.EASE_IN_OUT);
			tween.fadeTo(0.8);
			tween.repeatCount = 0;
			tween.reverse = true;			
			
			Starling.juggler.add(tween);
		}
		
		public function hdmiGlowOff():void
		{
			Starling.juggler.removeTweens(_hdmiGlow);
			
			var tween:Tween = new Tween(_hdmiGlow, 0.5);
			tween.fadeTo(0);
			tween.onComplete = function ():void
			{
				_hdmiGlow.visible = false;
			}
			
			Starling.juggler.add(tween);
		}
		
		public function cableOn():void
		{
			Starling.juggler.removeTweens(_cable);
			
			_cable.alpha = 0;
			_cable.visible = true;
			
			var tween:Tween = new Tween(_cable, 0.35, Transitions.EASE_OUT);
			tween.fadeTo(1);
			tween.onComplete = function():void
			{
				_cable.touchable = true;
			}
			
			Starling.juggler.add(tween);
		}
		
		public function cableOff():void
		{
			Starling.juggler.removeTweens(_cable);
			
			_cable.alpha = 0;
			_cable.visible = true;
			
			var tween:Tween = new Tween(_cable, 0.35, Transitions.EASE_OUT);
			tween.fadeTo(0);
			tween.onComplete = function():void
			{
				_cable.visible = false;
			}
			
			Starling.juggler.add(tween);
		}
		
		public function cablePlay():void
		{
			Starling.juggler.removeTweens(_cable);
			
			_cable.play();
			
			Starling.juggler.add(_cable);
		}
		
		public function powerpointOn():void
		{
			Starling.juggler.removeTweens(_powerpoint);
			
			_powerpoint.alpha = 0;
			_powerpoint.visible = true;
			
			var tween:Tween = new Tween(_powerpoint, 0.5, Transitions.EASE_OUT);
			tween.fadeTo(1);
			
			Starling.juggler.add(tween);
		}
		
		public function powerpointOff():void
		{
			Starling.juggler.removeTweens(_powerpoint);
			
			_powerpoint.alpha = 1;
			_powerpoint.visible = true;
			
			var tween:Tween = new Tween(_powerpoint, 0.5, Transitions.EASE_OUT);
			tween.fadeTo(0);
			tween.onComplete = function():void
			{
				_powerpoint.visible = false;
			}
			
			Starling.juggler.add(tween);
		}
		
		public function pluginCable(xValue:Number):Boolean
		{
			return false;
		}
		
		public function gradientOn():void
		{
			Starling.juggler.removeTweens(_gradient);
			
			_gradient.alpha = 0;
			_gradient.visible = true;
			
			var tween:Tween = new Tween(_gradient, 0.5, Transitions.EASE_OUT);
			tween.fadeTo(1);
			
			Starling.juggler.add(tween);
		}
		
		public function gradientOff():void
		{
			Starling.juggler.removeTweens(_gradient);
			
			var tween:Tween = new Tween(_gradient, 0.5, Transitions.EASE_OUT);
			tween.fadeTo(0);
			tween.onComplete = function():void
			{
				_gradient.visible = false;
			}
			
			Starling.juggler.add(tween);
		}
		
		public function reset():void
		{
			removeEventListeners(EnterFrameEvent.ENTER_FRAME);
			
			Starling.juggler.removeTweens(_gradient);
			Starling.juggler.removeTweens(_powerpoint);
			Starling.juggler.removeTweens(_cable);
			Starling.juggler.removeTweens(_chromecast);
			Starling.juggler.removeTweens(_tvDisplay);
			Starling.juggler.removeTweens(_tvBack);
			Starling.juggler.removeTweens(_hdmi);
			Starling.juggler.removeTweens(_hdmiGlow);
			
			_chromecast.hide();
			_chromecast.x = _chromecastStartX;
			
			_cable.visible = false;
			_cable.x = _cableStartX;
			_cable.stop();
			
			_powerpoint.visible = false;
			
			_tvBack.x = stage.stageWidth;
			_tvBack.visible = false;
			
			_hdmi.visible = false;
			_hdmiGlow.visible = false;
			
			if (_tvReversed)
			{
				_tvDisplay.reverseFrames();
				_tvReversed = false;
			}
			
			_tvDisplay.visible = true;
			_tvDisplay.stop();
			
			_gradient.setText("");
			_gradient.visible = false;
		}
	}
}