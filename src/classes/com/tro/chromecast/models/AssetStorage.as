/**
 * Created by russellmilburn on 23/07/15.
 */
package com.tro.chromecast.models
{

	import away3d.animators.VertexAnimationSet;
	import away3d.animators.VertexAnimator;
	import away3d.animators.nodes.VertexClipNode;
	import away3d.containers.View3D;
	import away3d.events.LoaderEvent;
	import away3d.loaders.AssetLoader;
	import away3d.loaders.Loader3D;
	import away3d.loaders.parsers.AWD2Parser;
	import away3d.materials.TextureMaterial;

	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.models.away3d.Ar3dModel;
	import com.tro.chromecast.models.away3d.Ar3dModelEvent;
	import com.tro.chromecast.models.away3d.ChromeCast;
	import com.tro.chromecast.models.away3d.EntireScene;
	import com.tro.chromecast.models.away3d.LoungeScene;

	import flash.utils.Dictionary;

	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.utils.AssetManager;

	public class AssetStorage extends AbstractModel
	{

		[Inject]
		public var view3D : View3D;

		private var _assetManager : AssetManager;

		private var _modelDictionary : Dictionary;

		private var _animator : VertexAnimator;

		private var modelArray : Array;
		private var noOf3dModelLoaded : int = 0;
		private var current3dModel : Ar3dModel;

		public function AssetStorage()
		{
			super();

			_modelDictionary = new Dictionary();
		}
		
		public function loadModels() : void
		{
			dispatch(new AssetStorageEvent(AssetStorageEvent.ON_LOADING_MODELS));
			AssetLoader.enableParser(AWD2Parser);
			logger.info("[START UP 2]: load 3D Models");


			//var lounge : LoungeScene = injector.getOrCreateNewInstance(LoungeScene);
			//var chromeCast : ChromeCast = injector.getOrCreateNewInstance(ChromeCast);
			var entireScene : EntireScene = injector.getOrCreateNewInstance(EntireScene);

			modelArray = new Array();


			modelArray.push(entireScene);
			//modelArray.push(chromeCast);

			load3dModels();
			//on3dModelsLoaded();
		}

		private function load3dModels() : void
		{
			current3dModel = Ar3dModel(modelArray[noOf3dModelLoaded]);
			current3dModel.addEventListener(Ar3dModelEvent.ON_3D_MODEL_READY, onModelReady);
			current3dModel.load();

		}

		private function onModelReady(event:Ar3dModelEvent):void
		{
			_modelDictionary[current3dModel.id] = current3dModel;
			noOf3dModelLoaded ++;

			if (noOf3dModelLoaded < modelArray.length)
			{
				load3dModels();
			}
			else
			{
				on3dModelsLoaded();
			}

		}

		private function onLoadError(event:LoaderEvent):void
		{
			//logger.info(event.message);
		}

		private function on3dModelsLoaded():void
		{

			logger.info("[START UP 3]: 3D Models Complete");

			dispatch(new AssetStorageEvent(AssetStorageEvent.ON_MODEL_LOADED));

			dispatch(new AppEvent(AppEvent.LOAD_ASSET_LIB));

		}

		public function loadAssets():void
		{
			dispatch(new AssetStorageEvent(AssetStorageEvent.ON_LOADING_ASSETS));

			_assetManager = new AssetManager();
			_assetManager.enqueue("/assets/fonts/Roboto.fnt");
			_assetManager.enqueue("/assets/fonts/Roboto.png");
			_assetManager.enqueue("/assets/textures/AssetLibrary0.atf");
			_assetManager.enqueue("/assets/textures/AssetLibrary1.atf");
			_assetManager.enqueue("/assets/textures/AssetLibrary2.atf");
			_assetManager.enqueue("/assets/textures/AssetLibrary3.atf");
			_assetManager.enqueue("/assets/textures/AssetLibrary4.atf");
			_assetManager.enqueue("/assets/textures/AssetLibrary5.atf");
			_assetManager.enqueue("/assets/textures/AssetLibrary6.atf");
			_assetManager.enqueue("/assets/textures/AssetLibrary7.atf");
			_assetManager.enqueue("/assets/textures/AssetLibrary8.atf");
			_assetManager.enqueue("/assets/textures/AssetLibrary9.atf");
			_assetManager.enqueue("/assets/textures/AssetLibrary10.atf");
			_assetManager.enqueue("/assets/textures/AssetLibrary11.atf");
			_assetManager.enqueue("/assets/textures/AssetLibrary12.atf");
			_assetManager.enqueue("/assets/textures/AssetLibrary13.atf");
			_assetManager.enqueue("/assets/textures/AssetLibrary14.atf");
			_assetManager.enqueue("/assets/textures/AssetLibrary0.xml");
			_assetManager.enqueue("/assets/textures/AssetLibrary1.xml");
			_assetManager.enqueue("/assets/textures/AssetLibrary2.xml");
			_assetManager.enqueue("/assets/textures/AssetLibrary3.xml");
			_assetManager.enqueue("/assets/textures/AssetLibrary4.xml");
			_assetManager.enqueue("/assets/textures/AssetLibrary5.xml");
			_assetManager.enqueue("/assets/textures/AssetLibrary6.xml");
			_assetManager.enqueue("/assets/textures/AssetLibrary7.xml");
			_assetManager.enqueue("/assets/textures/AssetLibrary8.xml");
			_assetManager.enqueue("/assets/textures/AssetLibrary9.xml");
			_assetManager.enqueue("/assets/textures/AssetLibrary10.xml");
			_assetManager.enqueue("/assets/textures/AssetLibrary11.xml");
			_assetManager.enqueue("/assets/textures/AssetLibrary12.xml");
			_assetManager.enqueue("/assets/textures/AssetLibrary13.xml");
			_assetManager.enqueue("/assets/textures/AssetLibrary14.xml");
			_assetManager.loadQueue(onLoadProgress);
		}

		private function onLoadProgress(ratio : Number):void
		{
			//logger.info("onLoadProgress: " + ratio);
			if (ratio == 1.0)
			{
				registerFont();
			}
		}

		protected function registerFont() : void
		{
			if(TextField.getBitmapFont("Roboto") == null)
			{
				var font : BitmapFont = new BitmapFont(_assetManager.getTexture("Roboto"), _assetManager.getXml("Roboto"));
				TextField.registerBitmapFont(font, "Roboto");
			}
			logger.info("[START UP 5]: LOAD Assets Complete");
			dispatch(new AppEvent(AppEvent.INIT_VIEWS));
		}




		public function get modelDictionary():Dictionary
		{
			return _modelDictionary;
		}

		public function set modelDictionary(value:Dictionary):void
		{
			_modelDictionary = value;
		}


		public function get animator():VertexAnimator
		{
			return _animator;
		}

		public function set animator(value:VertexAnimator):void
		{
			_animator = value;
		}


		public function get assetManager():AssetManager
		{
			return _assetManager;
		}

		public function set assetManager(value:AssetManager):void
		{
			_assetManager = value;
		}
	}
}
