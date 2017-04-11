/**
 * Created by russellmilburn on 14/09/15.
 */
package com.tro.chromecast.views.mediators
{
	
	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.models.ApplicationModel;
	import com.tro.chromecast.models.ApplicationModelEvent;
	import com.tro.chromecast.models.states.section.SectionList;
	import com.tro.chromecast.models.vos.DeviceTypeVo;
	import com.tro.chromecast.models.vos.DeviceTypeVo;
	import com.tro.chromecast.models.vos.ImageMenuButtonVo;
	import com.tro.chromecast.views.ChooseDeviceView;
	import com.tro.chromecast.views.ViewEvent;
	import com.tro.chromecast.views.components.SwipeControlEvent;
	import com.tro.chromecast.views.components.devicedisplay.Laptop;
	import com.tro.chromecast.views.components.imagemenu.ImageMenuEvent;
	
	public class ChooseYourDeviceMediator extends BaseMediator
	{
		[Inject]
		public var view:ChooseDeviceView;
		
		[Inject]
		public var appModel:ApplicationModel;
		
		private var dataProvider:Array;
		private var isInit:Boolean = true;
		
		public function ChooseYourDeviceMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			view.logger = super.logger;
			view.assetManager = assetStore.assetManager;
			
			dataProvider = new Array();
			
			addContextListener(ApplicationModelEvent.ON_UPDATE_DEVICE, onUpdateDevice);
			
			view.addEventListener(SwipeControlEvent.SWIPE_LEFT, onSwipeLeft);
			view.addEventListener(SwipeControlEvent.SWIPE_RIGHT, onSwipeRight);
			
			view.addEventListener(ViewEvent.ON_VIEW_INIT_COMPLETE, onViewInitComplete);
			view.addEventListener(ImageMenuEvent.ON_TAP, onDeviceTapHandler);
		}
		
		private function onUpdateDevice(event:ApplicationModelEvent):void
		{
			if (event.device == DeviceTypeVo.LAPTOP)
			{
				view.titleField.text = "System requirements:";
				view.bodyCopyField.y = view.titleField.y + view.titleField.height + 25;
				view.bodyCopyField.text = "\nWindows 7 or later, Mac OS X 10.7 or later or Chrome OS. "
						+ "Mirroring web video requires a recent laptop with "
						+ "above OS release or later and strong Wi-Fi.\n"
						+ "Silverlight, Quicktime and some other video "
						+ "\nplugins not supported.";
						
				view.swipeToContinue.x = view.stage.stageWidth / 2 - view.swipeToContinue.width/2;
				view.swipeToContinue.y = view.bodyCopyField.y + view.bodyCopyField.height + 25;
				
				view.titleField.visible = true;
				view.iconContainer.visible = false;
				view.bodyCopyField.visible = true;
			}
			else
			{
				view.titleField.text = "Compatible with:";
				view.iconContainer.y = view.titleField.y + view.titleField.height + 25;
				view.iconContainer.visible = true;
				view.bodyCopyField.text = "Android phone/tablet with Android 2.3 or later. "
						+ "iPhone/iPad/iPod Touch with iOS 7.0 or later. "
						+ "Casting from Chrome for Mobile not currently supported.";
				view.bodyCopyField.y = view.iconContainer.y + view.iconContainer.height + 25;
				
				view.swipeToContinue.x = (view.stage.stageWidth - view.swipeToContinue.width)/2;
				view.swipeToContinue.y = view.bodyCopyField.y + view.bodyCopyField.height + 25;
				
				view.titleField.visible = true;
				view.iconContainer.visible = true;
				view.bodyCopyField.visible = true;
			}
		}
		
		private function onDeviceTapHandler(event:ImageMenuEvent):void
		{
			var evt:AppEvent = new AppEvent(AppEvent.SET_DEVICE_TYPE);
			evt.deviceType = event.vo.btnId;
			dispatch(evt);
			
			view.tvDisplay.bodyCopyText = "";
			view.tvDisplay.titleText = "";
			view.swipeToContinue.visible = true;
		}
		
		private function onViewInitComplete(event:ViewEvent):void
		{
			dataProvider.push(getImageMenuVo(DeviceTypeVo.LAPTOP, "Device" + DeviceTypeVo.LAPTOP + "Thumb"));
			dataProvider.push(getImageMenuVo(DeviceTypeVo.TABLET, "Device" + DeviceTypeVo.TABLET + "Thumb"));
			dataProvider.push(getImageMenuVo(DeviceTypeVo.MOBILE, "Device" + DeviceTypeVo.MOBILE + "Thumb"));
			
			view.deviceMenu.dataProvider = dataProvider;
		}
		
		override protected function onSwipeRight(event:SwipeControlEvent):void
		{
			
			event.stopPropagation();
			
			if (appModel.newSection.sectionName == SectionList.CONNECT_SECTION)
			{
				logger.info("dispatch(new ApplicationModelEvent(ApplicationModelEvent.OPEN_MENU));");
				dispatch(new ApplicationModelEvent(ApplicationModelEvent.OPEN_MENU));
				return;
			}
			
			prevView();
		}
		
		public function getImageMenuVo(id:String, textureId:String):ImageMenuButtonVo
		{
			var vo:ImageMenuButtonVo = new ImageMenuButtonVo();
			vo.btnId = id;
			vo.texture = view.assetManager.getTexture(textureId);
			return vo;
		}
	}
}
