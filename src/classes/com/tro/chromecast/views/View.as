/**
 * Created by russellmilburn on 29/07/15.
 */
package com.tro.chromecast.views
{

	import com.greensock.TweenMax;
	import com.greensock.easing.Cubic;
	import com.tro.chromecast.interfaces.IView;
	import com.tro.chromecast.models.ApplicationModel;
	import com.tro.chromecast.views.components.TVDisplayVo;

	import flash.geom.Rectangle;

	import flash.utils.getQualifiedClassName;
	import flash.utils.getTimer;

	import robotlegs.bender.framework.api.ILogger;

	import starling.display.BlendMode;

	import starling.display.Canvas;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.AssetManager;

	public class View extends Sprite implements IView
	{

		private static var VIEW_TRANSITION_TWEEN_DURATION:Number = 0.5;

		public var logger : ILogger;


		private var _tweenIn : TweenMax;
		private var _tweenOut : TweenMax;
		private var _tweenInLeftFromXPos : Number;
		private var _tweenInLeftToXPos : Number;

		private var _tweenInRightFromXPos : Number;
		private var _tweenInRightToXPos : Number;

		private var _tweenOutLeftFromXPos : Number;
		private var _tweenOutLeftToXPos : Number;

		private var _tweenOutRightFromXPos :Number;
		private var _tweenOutRightToXPos :Number;


		private var _assetManager : AssetManager;

		protected var _viewBackground : Canvas;
		protected var tvContentArea : Rectangle;
		protected var contentContainer : Sprite;
		protected var title : TextField;


		public function View()
		{
			super();

			this.addEventListener(Event.ADDED_TO_STAGE, onViewAddedToStage);
		}

		private function onViewAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onViewAddedToStage);
			onViewInit();

		}

		protected function onViewInit() : void
		{
			_viewBackground = new Canvas();
			_viewBackground.beginFill(0xededed, 1);
			_viewBackground.drawRectangle(0,0, stage.stageWidth, stage.stageHeight);
			_viewBackground.touchable = false;
			_viewBackground.blendMode = BlendMode.NONE;

			addChildAt(_viewBackground, 0);

			tweenInLeftFromXPos = 0 - stage.stageWidth;
			tweenInLeftToXPos = 0;

			tweenInRightFromXPos = stage.stageWidth;
			tweenInRightToXPos = 0;

			tweenOutLeftFromXPos  = tweenInLeftToXPos;
			tweenOutLeftToXPos = tweenInLeftFromXPos;

			tweenOutRightFromXPos  = tweenInRightToXPos;
			tweenOutRightToXPos = tweenInRightFromXPos;

			contentContainer = new Sprite();
			contentContainer.touchable = false;
			tvContentArea = new Rectangle(277, 72, 1365, 777);

			initStageAssets();

		}



		protected function onAssetLoadProgress(ratio : Number):void
		{
			if (ratio == 1.0)
			{
				initStageAssets();
			}
		}

		protected function initStageAssets():void
		{
			trace(this, "Abstract method that needs to be implemented in the sub class");
		}


		public function prepareViewIn(direction:String) : void
		{
			var startPos:Number = getTweenFromPos(direction, true);
			var endPos:Number = getTweenToPos(direction, true);
			tweenIn = TweenMax.fromTo(this, View.VIEW_TRANSITION_TWEEN_DURATION, {x:startPos}, {x:endPos, ease:Cubic.easeOut, onComplete:onViewTweenInComplete});
			tweenIn.paused(true);

			dispatchEvent(new ViewEvent(ViewEvent.ON_PREPARE_VIEW_IN));

		}




		public function prepareViewOut(direction:String):void
		{
			var startPos:Number = getTweenFromPos(direction, false);
			var endPos:Number = getTweenToPos(direction, false);
			tweenOut = TweenMax.fromTo(this, View.VIEW_TRANSITION_TWEEN_DURATION, {x:startPos}, {x:endPos, ease:Cubic.easeOut, onComplete:onViewTweenOutComplete});
			tweenOut.paused(true);
		}

		public function viewIn():void
		{

		}

		public function viewOut():void
		{
		}

		public function finish():void
		{
		}

		public function hide():void
		{
			this.visible = false;
		}

		public function display():void
		{
			this.visible = true;
		}

		public function set tweenIn(value:TweenMax):void
		{
			_tweenIn = value;
		}

		protected function onViewTweenInComplete():void
		{
			dispatchEvent(new ViewEvent(ViewEvent.ON_VIEW_IN_COMPLETE));
		}

		protected function onViewTweenOutComplete():void
		{
			dispatchEvent(new ViewEvent(ViewEvent.ON_VIEW_OUT_COMPLETE));
		}

		public function get tweenIn():TweenMax
		{
			return _tweenIn;
		}

		public function set tweenOut(value:TweenMax):void
		{
			_tweenOut = value;
		}


		public function get tweenOut():TweenMax
		{
			return _tweenOut;
		}

		public function startViewIn():void
		{
			tweenIn.play();
		}

		public function startViewOut():void
		{
			tweenOut.play();
		}

		public function toString() : String
		{
			return getQualifiedClassName(this);
		}

		public function getTweenFromPos(direction:String, isIncomingView:Boolean):Number
		{
			if (isIncomingView)
			{

				if (direction == ApplicationModel.INCOMING_VIEW_FROM_LEFT)
				{
					return tweenInLeftFromXPos
				}
				else
				{
					return tweenInRightFromXPos;
				}
			}
			else
			{
				if (direction == ApplicationModel.INCOMING_VIEW_FROM_LEFT)
				{
					return tweenOutRightFromXPos
				}
				else
				{
					return tweenOutLeftFromXPos
				}
			}

		}

		public function getTweenToPos(direction:String, isIncomingView:Boolean):Number
		{
			if (isIncomingView)
			{
				if (direction == ApplicationModel.INCOMING_VIEW_FROM_LEFT)
				{
					return tweenInLeftToXPos
				}
				else
				{
					return tweenInRightToXPos;
				}
			}
			else
			{
				if (direction == ApplicationModel.INCOMING_VIEW_FROM_LEFT)
				{
					return tweenOutRightToXPos
				}
				else
				{
					return tweenOutLeftToXPos
				}
			}
		}


		public function get tweenInLeftFromXPos():Number
		{
			return _tweenInLeftFromXPos;
		}

		public function set tweenInLeftFromXPos(value:Number):void
		{
			_tweenInLeftFromXPos = value;
		}

		public function get tweenInLeftToXPos():Number
		{
			return _tweenInLeftToXPos;
		}

		public function set tweenInLeftToXPos(value:Number):void
		{
			_tweenInLeftToXPos = value;
		}

		public function get tweenInRightFromXPos():Number
		{
			return _tweenInRightFromXPos;
		}

		public function set tweenInRightFromXPos(value:Number):void
		{
			_tweenInRightFromXPos = value;
		}

		public function get tweenInRightToXPos():Number
		{
			return _tweenInRightToXPos;
		}

		public function set tweenInRightToXPos(value:Number):void
		{
			_tweenInRightToXPos = value;
		}


		public function get tweenOutLeftFromXPos():Number
		{
			return _tweenOutLeftFromXPos;
		}

		public function set tweenOutLeftFromXPos(value:Number):void
		{
			_tweenOutLeftFromXPos = value;
		}

		public function get tweenOutLeftToXPos():Number
		{
			return _tweenOutLeftToXPos;
		}

		public function set tweenOutLeftToXPos(value:Number):void
		{
			_tweenOutLeftToXPos = value;
		}

		public function get tweenOutRightFromXPos():Number
		{
			return _tweenOutRightFromXPos;
		}

		public function set tweenOutRightFromXPos(value:Number):void
		{
			_tweenOutRightFromXPos = value;
		}

		public function get tweenOutRightToXPos():Number
		{
			return _tweenOutRightToXPos;
		}

		public function set tweenOutRightToXPos(value:Number):void
		{
			_tweenOutRightToXPos = value;
		}

		public function get assetManager():AssetManager
		{
			return _assetManager;
		}

		public function set assetManager(value:AssetManager):void
		{
			_assetManager = value;
		}

		public function getTexture(id : String ) : Texture
		{
			return assetManager.getTexture(id);
		}

		public function getTexturesSprite(id : String ) : Sprite
		{
			var texture : Texture = assetManager.getTexture(id);
			var image : Image = new Image(texture);
			image.name = "image";
			var sprite : Sprite = new Sprite();
			sprite.addChild(image);
			return sprite;
		}

		protected function getContentVo() : TVDisplayVo
		{
			var vo : TVDisplayVo = new TVDisplayVo();
			vo.tvBackground = getTexture("TVScreen");
			vo.cabinetTexture = getTexture("TVCabinet");
			return vo;
		}
	}
}
