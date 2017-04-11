/**
 * Created by russellmilburn on 31/08/15.
 */
package com.tro.chromecast.views.mediators
{

	import com.greensock.TweenMax;
	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.models.ARModelEvent;
	import com.tro.chromecast.models.ApplicationModelEvent;
	import com.tro.chromecast.models.away3d.Ar3dModelEvent;
	import com.tro.chromecast.models.away3d.Ar3dModelEvent;
	import com.tro.chromecast.models.vos.DeviceTypeVo;
	import com.tro.chromecast.models.vos.ImageMenuButtonVo;
	import com.tro.chromecast.views.AugRealityUiView;
	import com.tro.chromecast.views.ViewEvent;
	import com.tro.chromecast.views.components.PopUpMagnifierEvent;
	import com.tro.chromecast.views.components.SwipeControlEvent;
	import com.tro.chromecast.views.components.imagemenu.ImageMenuEvent;

	import mx.effects.Tween;

	public class AugRealityUiViewMediator extends BaseMediator
	{
		[Inject]
		public var view : AugRealityUiView;

		private var dataProvider : Array;
		private var selectedDevice : String;

		public function AugRealityUiViewMediator()
		{
			super();
		}

		override public function initialize():void
		{
			super.initialize();

			view.assetManager = assetStore.assetManager;

			addContextListener(Ar3dModelEvent.WAITING_FOR_INTERACTION, onWaitingForInteraction);
			addContextListener(Ar3dModelEvent.DISABLE_INTERACTION, onDisableInteraction);
			addContextListener(Ar3dModelEvent.ON_CC_INTO_TV_COMPLETE, onIntroIntoTVComplete);

			addContextListener(ARModelEvent.ON_MARKER_DETECTED, onMarkerDetected);
			addContextListener(ARModelEvent.ON_MARKER_LOST, onMarkerLost);

			view.addEventListener(SwipeControlEvent.SWIPE_LEFT, onSwipeLeft);
		}

		private function onIntroIntoTVComplete(event :Ar3dModelEvent):void
		{
			view.gradient.setText("");
			
			TweenMax.to(view.swipeToContinue, 0.5, {autoAlpha:1});
			TweenMax.to(view.gradient, 0.5, {autoAlpha:1});
		}

		private function onMarkerLost(event : ARModelEvent):void
		{
			TweenMax.to(view.gradient, 0.5, { autoAlpha:0 } );
			TweenMax.to(view.swipeToContinue, 0.5, {autoAlpha:0});
		}

		private function onMarkerDetected(event : ARModelEvent):void
		{
			view.gradient.setText("Touch the Chromecast to learn how easy\ncasting is in just 30 seconds.");
			TweenMax.to(view.gradient, 0.5, {autoAlpha:1});
		}

		private function onDisableInteraction(event: Ar3dModelEvent):void
		{
			view.swipeControl.disableTap();
			view.swipeControl.removeEventListener(SwipeControlEvent.ON_TAP, onUserTapScreen);
		}

		private function onWaitingForInteraction(event: Ar3dModelEvent):void
		{
			view.swipeControl.enableTap();
			view.swipeControl.addEventListener(SwipeControlEvent.ON_TAP, onUserTapScreen)
		}

		private function onUserTapScreen(event:SwipeControlEvent):void
		{
			event.stopPropagation();
			TweenMax.to(view.gradient, 0.5, {autoAlpha:0});
			view.swipeControl.disableTap();
			view.swipeControl.removeEventListener(SwipeControlEvent.ON_TAP, onUserTapScreen);
			dispatch(new Ar3dModelEvent(Ar3dModelEvent.ON_USER_INTERACTION));
		}




		

		public function getImageMenuVo(id:String, textureId:String) : ImageMenuButtonVo
		{
			var vo : ImageMenuButtonVo = new ImageMenuButtonVo();
			vo.btnId = id;
			vo.texture = view.assetManager.getTexture(textureId);
			return vo;
		}
	}
}
