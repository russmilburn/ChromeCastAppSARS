/**
 * Created by russellmilburn on 02/09/15.
 */
package com.tro.chromecast.views
{

	import com.tro.chromecast.models.vos.NavigationBtnVo;
	import com.tro.chromecast.views.components.buttons.ContinueBtn;
	import com.tro.chromecast.views.components.buttons.NavigationBtn;
	import com.tro.chromecast.views.components.buttons.RepeatSectionBtn;
	import com.tro.chromecast.views.components.SwipeControl;
	import com.tro.chromecast.views.components.SwipeToContinue;
	import com.tro.chromecast.views.components.TVDisplay;
	import com.tro.chromecast.views.components.TVDisplayVo;
	import starling.display.Sprite;
	

	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class CastYourOwnContentView extends View
	{
		private var _swipeControl:SwipeControl;
		private var _tvDisplay:TVDisplay;
		
		private var _swipeToContinue:SwipeToContinue;
		private var _plexSprite:Sprite;
		private var _allCastSprite:Sprite;
		
		public function CastYourOwnContentView()
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
			_tvDisplay  = new TVDisplay();
			_tvDisplay.tvDisplayVo = getContentVo();
			_tvDisplay.touchable = false;
			_tvDisplay.x = (stage.stageWidth - _tvDisplay.width) / 2 ;
			_tvDisplay.y = 50;
			_tvDisplay.layout = TVDisplay.ALIGN_TOP;
			
			_plexSprite = getTexturesSprite("plex");
			_plexSprite.x = 641;
			_plexSprite.y = 453;
			_plexSprite.touchable = false;
			
			_allCastSprite =  getTexturesSprite("allcast");
			_allCastSprite.x = 1020;
			_allCastSprite.y = 464;
			_allCastSprite.touchable = false;
			
			_swipeToContinue = new SwipeToContinue();
			_swipeToContinue.titleField.color = 0x000000;
			_swipeToContinue.y = stage.stageHeight - _swipeToContinue.height - 35;
			_swipeToContinue.x = (stage.stageWidth - _swipeToContinue.width) / 2;
			
			
			addChild(_tvDisplay);
			addChild(_plexSprite);
			addChild(_allCastSprite);
			addChild(_swipeToContinue);
			
			
			
			dispatchEvent(new ViewEvent(ViewEvent.ON_VIEW_INIT_COMPLETE));
		}
		
		override protected function getContentVo() : TVDisplayVo
		{
			var vo : TVDisplayVo = super.getContentVo();
			vo.title = "Apps such as Plex and Allcast\nlet you cast your own local content";
			return vo;
		}
		
		public function get tvDisplay():TVDisplay
		{
			return _tvDisplay;
		}
		
		public function set tvDisplay(value:TVDisplay):void
		{
			_tvDisplay = value;
		}
		
		public function get plexImage():Sprite 
		{
			return _plexSprite;
		}
		
		public function set plexImage(value:Sprite):void 
		{
			_plexSprite = value;
		}
		
		public function get allCastImage():Sprite 
		{
			return _allCastSprite;
		}
		
		public function set allCastImage(value:Sprite):void 
		{
			_allCastSprite = value;
		}
	}
}
