/**
 * Created by russellmilburn on 14/08/15.
 */
package com.tro.chromecast.models
{

	import com.tro.chromecast.models.vos.BackgroundTaskVo;
	import com.tro.chromecast.models.vos.CastAppsVo;
	import com.tro.chromecast.models.vos.DoMoreAppVo;

	import flash.events.Event;

	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class ContentModel extends AbstractModel
	{
		private static const VIDEO_PATH : String = "assets/videos/";

		private var _castAppsData : Array;
		private var _backgroundTasksData : Array;
		private var _doMoreMenu: Array;
		private var _currentCasAppVo : CastAppsVo;
		private var urlLoader : URLLoader;
		private var loadedXML:XML;
		private var _doMoreApps : Array;

		public function ContentModel()
		{
			super();
		}


		public function initContent() : void
		{
			_castAppsData = new Array();
			_castAppsData.push(getCastAppsVo("btn0", "HowtoCast.mp4", "playStore"));
			_castAppsData.push(getCastAppsVo("btn1", "BigNose.mp4", "youtube"));
			_castAppsData.push(getCastAppsVo("btn2", "Minions.m4v", "netflix"));
			_castAppsData.push(getCastAppsVo("btn3", "Sidekicks.mp4", "stan"));
			_castAppsData.push(getCastAppsVo("btn4", "LaLuna.mp4", "presto"));
//			_castAppsData.push(getCastAppsVo("btn4", "Whiplash.mp4", "playMusic"));
//			_castAppsData.push(getCastAppsVo("btn5", "Love_and_Mercy.mp4", "pandora"));
			_castAppsData.push(getCastAppsVo("btn7", "", "moreApps"));

			_currentCasAppVo = _castAppsData[2];

			_backgroundTasksData = new Array();

			_backgroundTasksData.push(getBackgroundTasksVo("btn0", "weather"));
			_backgroundTasksData.push(getBackgroundTasksVo("btn1", "maps"));
			_backgroundTasksData.push(getBackgroundTasksVo("btn2", "gmail"));
			_backgroundTasksData.push(getBackgroundTasksVo("btn3", "angryBirds"));

			urlLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, onLoadComplete);
			urlLoader.load(new URLRequest("../data/app_data.xml"));



		}

		private function onLoadComplete(event:Event):void
		{
			//logger.info("**************** onLoadComplete: ");
			loadedXML = new XML(urlLoader.data);

			_doMoreApps = new Array();
			for each (var node : XML in loadedXML.children())
			{
				var vo : DoMoreAppVo = new DoMoreAppVo();
				vo.id = node.@id;
				vo.title = node.@title;
				vo.category = node.@category;
				vo.desc = node.child(0).valueOf();
				_doMoreApps.push(vo);
			}
		}


		public function getCastAppsVo(id:String, contentPath:String, appId:String) : CastAppsVo
		{
			var vo : CastAppsVo = new CastAppsVo();
			vo.btnId = id;
			vo.textureId = appId + "AppLogo";
			vo.appId = appId;
			vo.contentPath = VIDEO_PATH + contentPath;
			return vo;
		}

		public function getBackgroundTasksVo(id:String, appId:String) : BackgroundTaskVo
		{
			var vo : BackgroundTaskVo = new BackgroundTaskVo();
			vo.btnId = id;
			vo.textureId = appId + "AppLogo";
			vo.appId = appId;
			vo.contentId = appId + "Screen";
			return vo;
		}


		public function get castAppsData():Array
		{
			return _castAppsData;
		}

		public function set currentCastApp(value:Array):void
		{
			_castAppsData = value;
		}


		public function get backgroundTasksData():Array
		{
			return _backgroundTasksData;
		}

		public function set backgroundTasksData(value:Array):void
		{
			_backgroundTasksData = value;
		}

		public function get currentCasAppVo():CastAppsVo
		{
			return _currentCasAppVo;
		}

		public function set currentCasAppVo(value:CastAppsVo):void
		{
			_currentCasAppVo = value;

			dispatch(new ContentModelEvent(ContentModelEvent.ON_UPDATE_CAST_APP_VO));
		}


		public function get doMoreApps():Array
		{
			return _doMoreApps;
		}

		public function set doMoreApps(value:Array):void
		{
			_doMoreApps = value;
		}

		public function get doMoreMenu():Array
		{
			return _doMoreMenu;
		}

		public function set doMoreMenu(value:Array):void
		{
			_doMoreMenu = value;
		}
	}
}
