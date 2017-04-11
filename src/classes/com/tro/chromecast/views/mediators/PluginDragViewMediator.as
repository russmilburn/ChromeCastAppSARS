package com.tro.chromecast.views.mediators
{
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	import starling.events.Event;
	import starling.events.EnterFrameEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	import com.tro.chromecast.views.PluginDragView;
	import com.tro.chromecast.views.ViewEvent;
	import com.tro.chromecast.views.components.SwipeControlEvent;
	
	/**
	 * ...
	 * @author David Armstrong
	 */
	public class PluginDragViewMediator extends BaseMediator
	{
		[Inject]
		public var view:PluginDragView;
		
		private var delayTimer:Timer;
		
		private static const dragDist:int = 372;
		private var frames:int;
		private var frameThreshold:int;
		private var framesPerPixel:Number;
		private var currentFrame:Number;
		
		public function PluginDragViewMediator()
		{
			super();
		
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			view.logger = super.logger;
			view.assetManager = assetStore.assetManager;
			
			view.addEventListener(SwipeControlEvent.SWIPE_LEFT, onSwipeLeft);
			view.addEventListener(SwipeControlEvent.SWIPE_RIGHT, onSwipeRight);
			
			view.addEventListener(ViewEvent.ON_VIEW_INIT_COMPLETE, onViewInitComplete);
			view.addEventListener(ViewEvent.ON_VIEW_IN_COMPLETE, onViewInComplete);
			view.addEventListener(ViewEvent.ON_VIEW_OUT_COMPLETE, onViewOutComplete);
			
			view.addEventListener(PluginDragView.TV_IN_DONE, tvInDone);
			view.addEventListener(PluginDragView.TV_OUT_DONE, tvOutDone);
			
			delayTimer = new Timer(1000, 1);
		}
		
		
		private function onViewInitComplete(e:ViewEvent):void
		{
			view.removeEventListener(ViewEvent.ON_VIEW_INIT_COMPLETE, onViewInitComplete);
		}
		
		private function onViewInComplete(e:ViewEvent):void
		{
			view.chromecast.addEventListener(TouchEvent.TOUCH, chromecastTouchHandler);
			view.chromecast.startGlow();			
			
			frames = view.cable.numFrames - 1;
			frameThreshold = ((frames * 0.9) * 0.5) >> 0; // Bitwise round.
			framesPerPixel = frames / dragDist;
			
			view.tvDisplayPlay();
		}
		
		private function tvInDone(e:Event):void 
		{			
			view.chromecastOn();
			view.cableOn();
			view.gradientOn();
			view.gradient.setText("Drag the Chromecast into the HDMI port");
		}
		
		private function tvOutDone(e:Event):void 
		{
			nextView();
		}
		
		private function chromecastTouchHandler(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(view.chromecast, TouchPhase.MOVED);
			
			if (touch)
			{
				var currentPos:Point = touch.getLocation(view);
				var previousPos:Point = touch.getPreviousLocation(view);
				
				if (view.pluginChromecast(currentPos.x - previousPos.x))
				{
					chromecastPluggedIn();
					view.gradient.setText("Well done!");
					
					removeTimerListeners();
					delayTimer.delay = 1000;
					delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, text1);
					delayTimer.start();
				}
			}
		}
		
		private function chromecastPluggedIn():void
		{
			view.chromecast.removeEventListener(TouchEvent.TOUCH, chromecastTouchHandler);
			view.chromecast.stopGlow();
			view.powerpointOn();
			currentFrame = 2;
			view.cable.currentFrame = currentFrame;
			
			view.cable.addEventListener(TouchEvent.TOUCH, cableTouchHandler);
		}
		
		private function cableTouchHandler(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(view.cable, TouchPhase.MOVED);
			
			if (touch)
			{
				if (currentFrame > frameThreshold)
				{
					view.cable.removeEventListener(TouchEvent.TOUCH, cableTouchHandler);
					view.addEventListener(EnterFrameEvent.ENTER_FRAME, cableFinisher);
					view.cablePlay();
				}
				else
				{
					var pixelDif:Number = touch.previousGlobalX - touch.globalX;
					currentFrame += (pixelDif * framesPerPixel);
				}
				
				if (currentFrame < 2)
				{
					currentFrame = 2;
				}
				else
				{
					view.cable.currentFrame = int(currentFrame);
				}
			}
		}
		
		private function cableFinisher(e:EnterFrameEvent):void
		{
			if (view.cable.isComplete)
			{
				view.removeEventListener(EnterFrameEvent.ENTER_FRAME, cableFinisher);
				view.gradient.setText("Good job!");
				
				removeTimerListeners();
				delayTimer.delay = 2000;
				delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, initiateSectionEnd);
				delayTimer.start();
			}
		}
		
		private function text1(e:TimerEvent):void
		{
			removeTimerListeners();
			view.gradient.setText("Now plug it into the power outlet");
		}
		
		private function initiateSectionEnd(e:TimerEvent):void
		{
			removeTimerListeners();
			
			view.tvDisplayPlay(true);			
			view.powerpointOff();
			view.gradient.setText("");
			view.gradientOff();
		}
		
		private function removeTimerListeners():void
		{
			delayTimer.reset();
			
			if (delayTimer.hasEventListener(TimerEvent.TIMER_COMPLETE))
			{
				delayTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, text1);
				delayTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, initiateSectionEnd);				
			}
		}
		
		private function onViewOutComplete(e:ViewEvent):void
		{			
			removeTimerListeners();
			view.reset();
		}
	
	}

}