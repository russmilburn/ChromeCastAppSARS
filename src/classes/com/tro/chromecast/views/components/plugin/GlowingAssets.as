package com.tro.chromecast.views.components.plugin
{
	import starling.display.Sprite;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.animation.Transitions;
	
	/**
	 * ...
	 * @author David Armstrong
	 */
	
	public class GlowingAssets extends Sprite
	{
		private var _mainSprite:Image;
		private var _glowSprite:Image;
		
		public function GlowingAssets()
		{
			super();
		
		}
		
		public function get mainSprite():Image
		{
			return _mainSprite;
		}
		
		public function set mainSprite(value:Image):void
		{
			if (_mainSprite)
			{
				removeChild(_mainSprite);
			}
			
			_mainSprite = value;
			addChild(_mainSprite);
			
			glowPosition();
		}
		
		public function get glowSprite():Image
		{
			return _glowSprite;
		}
		
		public function set glowSprite(value:Image):void
		{
			if (_glowSprite)
			{
				removeChild(_glowSprite);
			}
			
			_glowSprite = value;
			addChildAt(_glowSprite, 0);
			_glowSprite.visible = false;
			
			_glowSprite.pivotX = _glowSprite.width * 0.5;
			_glowSprite.pivotY = _glowSprite.height * 0.5;
			
			glowPosition();
		}
		
		private function glowPosition():void
		{
			if (_mainSprite && _glowSprite)
			{
				_glowSprite.x = _mainSprite.width * 0.5;
				_glowSprite.y = _mainSprite.height * 0.5;
			}
		}
		
		public function startGlow():void
		{
			Starling.juggler.removeTweens(_glowSprite);
			_glowSprite.alpha = 0.3;
			_glowSprite.visible = true;
			
			var tween:Tween = new Tween(_glowSprite, 0.85, Transitions.EASE_IN_OUT);
			tween.fadeTo(0.8);
			tween.repeatCount = 0;
			tween.reverse = true;
			
			Starling.juggler.add(tween);
		}
		
		public function stopGlow():void
		{
			Starling.juggler.removeTweens(_glowSprite);
			_glowSprite.alpha = 1;
			_glowSprite.visible = true;
			
			var tween:Tween = new Tween(_glowSprite, 1);
			tween.fadeTo(0);
			tween.onComplete = function():void {
				_glowSprite.visible = false;
			}
			
			Starling.juggler.add(tween);
		}
		
		public function hide():void
		{			
			visible = false;
			stopGlow();
		}
	
	}

}