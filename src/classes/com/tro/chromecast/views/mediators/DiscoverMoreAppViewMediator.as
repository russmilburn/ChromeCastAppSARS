/**
 * Created by russellmilburn on 21/09/15.
 */
package com.tro.chromecast.views.mediators
{

	import com.tro.chromecast.models.ContentModel;
	import com.tro.chromecast.models.vos.DoMoreAppVo;
	import com.tro.chromecast.views.DiscoverMoreAppView;
	import com.tro.chromecast.views.ViewEvent;
	import com.tro.chromecast.views.components.GridButtonEvent;
	import com.tro.chromecast.views.components.SwipeControlEvent;
	import com.tro.chromecast.views.components.tabs.TabMenuEvent;

	public class DiscoverMoreAppViewMediator extends BaseMediator
	{
		[Inject]
		public var view : DiscoverMoreAppView;
		
		[Inject]
		public var content : ContentModel;
		
		private var dataProvider : Array;
		
		private var currentHighlightedTab : String;
		
		public function DiscoverMoreAppViewMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			view.logger = super.logger;
			view.assetManager = assetStore.assetManager;
			
			view.addEventListener(ViewEvent.ON_VIEW_INIT_COMPLETE, onViewInitComplete);
			view.addEventListener(TabMenuEvent.ON_TAB_MENU_TAP, onTabMenuTap);
			view.addEventListener(GridButtonEvent.ON_APP_TAP, onAppTapHandler);
			
			view.addEventListener(SwipeControlEvent.SWIPE_LEFT, onSwipeLeft);
			view.addEventListener(SwipeControlEvent.SWIPE_RIGHT, onSwipeRight);
			
			view.addEventListener(ViewEvent.ON_VIEW_IN_COMPLETE, onViewInComplete);
			view.addEventListener(ViewEvent.ON_VIEW_OUT_COMPLETE, onViewOutComplete);
		}
		
		private function onViewOutComplete(e:ViewEvent):void 
		{
			dataProvider = content.doMoreApps.filter(getWatchData);
			view.dataProvider = dataProvider;
			view.contentBox.visible = false;
			view.hideGrid();
		}
		
		private function onViewInComplete(e:ViewEvent):void 
		{
			view.contentBox.visible = false;
			view.animateGrid();
		}
		
		private function onViewInitComplete(event:ViewEvent):void
		{
			dataProvider = content.doMoreApps.filter(getWatchData);
			view.dataProvider = dataProvider;
		}
		
		private function onTabMenuTap(event:TabMenuEvent):void
		{
			event.stopPropagation();
			
			if (currentHighlightedTab == event.id)
			{
				return;
			}
			
			if (event.id == "Watch")
			{
				view.tabMenu.watchBtn.isSelected = true;
				view.tabMenu.listenBtn.isSelected = false;
				view.tabMenu.playBtn.isSelected = false;
				view.dataProvider = content.doMoreApps.filter(getWatchData);
				currentHighlightedTab = event.id;
			}
			
			else if (event.id == "Play")
			{
				view.tabMenu.watchBtn.isSelected = false;
				view.tabMenu.listenBtn.isSelected = false;
				view.tabMenu.playBtn.isSelected = true;
				view.dataProvider = content.doMoreApps.filter(getPlayData);
				currentHighlightedTab = event.id;
			}
			
			else if (event.id == "Listen")
			{
				view.tabMenu.watchBtn.isSelected = false;
				view.tabMenu.listenBtn.isSelected = true;
				view.tabMenu.playBtn.isSelected = false;
				view.dataProvider = content.doMoreApps.filter(getListenData);
				currentHighlightedTab = event.id;
				
			}
			
			view.hideGrid();
			view.animateGrid();
			view.contentBox.visible = false;
		}
		
		private function onAppTapHandler(event:GridButtonEvent):void
		{
			event.stopPropagation();
			
			view.contentBox.x = view.localToGlobal(event.location).x - (view.contentBox.width / 2);
			view.contentBox.y = view.localToGlobal(event.location).y - (view.contentBox.height / 2);
			view.contentBox.data = event.vo;
			view.contentBox.visible = true;
		}
		
		private function getWatchData(element:*, index:int, arr:Array):Boolean
		{
			if (DoMoreAppVo(element).category == "watch")
			{
				return true
			}
			return false;
		}
		
		private function getPlayData(element:*, index:int, arr:Array):Boolean
		{
			if (DoMoreAppVo(element).category == "play")
			{
				return true
			}
			return false;
		}
		
		private function getListenData(element:*, index:int, arr:Array):Boolean
		{
			if (DoMoreAppVo(element).category == "listen")
			{
				return true
			}
			return false;
		}
	}
}