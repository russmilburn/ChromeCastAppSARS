/**
 * Created by russellmilburn on 29/09/15.
 */
package com.tro.chromecast.views.mediators
{

	import com.greensock.TweenMax;
	import com.tro.chromecast.views.GuestModeView;
	import com.tro.chromecast.views.ViewEvent;
	import com.tro.chromecast.views.components.PopUpMagnifierEvent;
	import com.tro.chromecast.views.components.SwipeControlEvent;

	import starling.display.Sprite;

	public class GuestModeViewMediator extends BaseMediator
	{
		[Inject]
		public var view : GuestModeView;

		private var copyText : Array;

		private var index : Number= -1;
		private var currentSlide : Sprite;

		public function GuestModeViewMediator()
		{
			super();
		}


		override public function initialize():void
		{
			super.initialize();

			view.logger = super.logger;
			view.assetManager = assetStore.assetManager;

			copyText = new Array();
			copyText.push("Tap Devices, select your Chromecast.");
			copyText.push("Tap Guest mode.");
			copyText.push("Slide guest mode to on.");
			copyText.push("Guest mode is now on.");

			view.addEventListener(ViewEvent.ON_VIEW_INIT_COMPLETE, onViewInitComplete);
			view.addEventListener(ViewEvent.ON_PREPARE_VIEW_IN, onPrepareViewIn);
			view.addEventListener(ViewEvent.ON_VIEW_OUT_COMPLETE, onViewOutComplete);
			view.addEventListener(ViewEvent.ON_VIEW_IN_COMPLETE, onViewInComplete);

			view.addEventListener(SwipeControlEvent.SWIPE_LEFT, onSwipeLeft);
			view.addEventListener(SwipeControlEvent.SWIPE_RIGHT, onSwipeRight);
		}
		
		
		private function onViewInComplete(e:ViewEvent):void 
		{
			TweenMax.to(view.popUp, 1, { autoAlpha: 1} );
		}
		
		private function onViewInitComplete(event:ViewEvent):void
		{
			view.popUp.addEventListener(PopUpMagnifierEvent.ON_BUTTON_TAP, onPopUpTap);
			nextSlide();
		}
		
		private function onPrepareViewIn(event:ViewEvent):void
		{
			resetView();
		}
		
		private function onViewOutComplete(event:ViewEvent):void
		{
			resetView()
		}
		
		private function onPopUpTap(event:PopUpMagnifierEvent):void
		{
			nextSlide();
		}
		
		private function resetView() : void
		{
			index = -1;
			view.gradient.displaySwipeToContinue = false;
			nextSlide();
		}
		
		private function nextSlide():void
		{
			if (index >= copyText.length-1)
			{
				return;
			}
			index++;
			
			if (currentSlide != null)
			{
				view.slideContainer.removeChild(currentSlide);
			}
			
			switch (index)
			{
				case 0:
					displaySlide1();
					break;
				case 1:
					displaySlide2();
					break;
				case 2:
					displaySlide3();
					break;
				case 3:
					displaySlide4();
					break;
			}
			
			view.slideContainer.addChild(currentSlide);
			view.gradient.setText(copyText[index]);
		}
		
		private function displaySlide1() : void
		{
			currentSlide = view.getTexturesSprite("SlideShow0" );
			view.popUp.setBackgroundImage(view.getTexture("SlideShow0PopUp"));
			view.popUp.x = 400;
			view.popUp.y = 150;
			view.popUp.visible = true;
			view.popUp.alpha = 0;
			
			
		}
		
		private function displaySlide2() : void
		{
			view.popUp.setBackgroundImage(view.getTexture("GuestMode1PopUp"));
			view.popUp.x = 260;
			view.popUp.y = 375;
			currentSlide = view.getTexturesSprite("GuestMode1");
			view.popUp.alpha = 0;
			TweenMax.killTweensOf(view.popUp);
			TweenMax.to(view.popUp, 1, { autoAlpha: 1} );
		}
		
		private function displaySlide3() : void
		{
			view.popUp.setBackgroundImage(view.getTexture("GuestMode2PopUp"));
			view.popUp.x = 1600;
			view.popUp.y = 90;
			currentSlide = view.getTexturesSprite("GuestMode2");
			view.popUp.alpha = 0;
			
			TweenMax.killTweensOf(view.popUp);
			TweenMax.to(view.popUp, 1, { autoAlpha: 1} );
		}
		
		private function displaySlide4() : void
		{
			view.popUp.setBackgroundImage(view.getTexture("GuestMode3PopUp"));
			view.popUp.x = 1600;
			view.popUp.y = 90;
			view.gradient.displaySwipeToContinue = true;
			currentSlide = view.getTexturesSprite("GuestMode3");
		}	
	}
}
