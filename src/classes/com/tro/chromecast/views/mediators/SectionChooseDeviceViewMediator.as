/**
 * Created by russellmilburn on 31/07/15.
 */
package com.tro.chromecast.views.mediators
{

	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.models.vos.DeviceTypeVo;
	import com.tro.chromecast.models.vos.ImageMenuButtonVo;
	import com.tro.chromecast.views.SectionChooseDeviceView;
	import com.tro.chromecast.views.ViewEvent;
	import com.tro.chromecast.views.components.imagemenu.ImageMenuEvent;
	import com.tro.chromecast.views.components.SwipeControlEvent;

	public class SectionChooseDeviceViewMediator extends BaseMediator
	{
		[Inject]
		public var view : SectionChooseDeviceView;

		private var dataProvider : Array;

		public function SectionChooseDeviceViewMediator()
		{
			super();
		}

		override public function initialize():void
		{
			super.initialize();

			view.logger = super.logger;
			view.assetManager = assetStore.assetManager;

			dataProvider = new Array();

			view.addEventListener(SwipeControlEvent.SWIPE_LEFT, onSwipeLeft);
			view.addEventListener(SwipeControlEvent.SWIPE_RIGHT, onSwipeRight);

			view.addEventListener(ViewEvent.ON_VIEW_INIT_COMPLETE, onViewInitComplete);
			view.addEventListener(ImageMenuEvent.ON_TAP, onDeviceTapHandler);
		}

		private function onDeviceTapHandler(event:ImageMenuEvent):void
		{
			var evt : AppEvent = new AppEvent(AppEvent.SET_DEVICE_TYPE);
			evt.deviceType = event.vo.btnId;
			dispatch(evt);

			nextView();
		}

		private function onViewInitComplete(event:ViewEvent):void
		{
			dataProvider.push(getImageMenuVo(DeviceTypeVo.LAPTOP, "Device"+ DeviceTypeVo.LAPTOP + "Thumb"));
			dataProvider.push(getImageMenuVo(DeviceTypeVo.TABLET, "Device"+ DeviceTypeVo.TABLET + "Thumb"));
			dataProvider.push(getImageMenuVo(DeviceTypeVo.MOBILE, "Device"+ DeviceTypeVo.MOBILE + "Thumb"));

			view.deviceMenu.dataProvider = dataProvider;
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
