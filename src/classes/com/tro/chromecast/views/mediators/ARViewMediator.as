/**
 * Created by russellmilburn on 22/07/15.
 */
package com.tro.chromecast.views.mediators
{

	import away3d.cameras.Camera3D;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.View3D;
	import away3d.core.managers.Stage3DProxy;
	import away3d.entities.Mesh;

	import com.greensock.TweenMax;
	import com.greensock.easing.Cubic;
	import com.greensock.easing.Linear;
	import com.greensock.easing.Power1;
	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.models.ARModelEvent;
	import com.tro.chromecast.models.ApplicationModelEvent;
	import com.tro.chromecast.models.AssetStorage;
	import com.tro.chromecast.models.AssetStorageEvent;
	import com.tro.chromecast.models.augreality.IARModel;
	import com.tro.chromecast.models.away3d.Ar3dModelEvent;
	import com.tro.chromecast.models.away3d.EntireScene;
	import com.tro.chromecast.views.ARView;
	import com.tro.chromecast.views.AugRealityUiView;
	import com.tro.chromecast.views.ViewRoot;
	import com.tro.chromecast.views.components.away3d.Away3DContainer;

	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Vector3D;

	import robotlegs.bender.extensions.contextView.ContextView;

	import starling.display.DisplayObjectContainer;
	import starling.display.Image;

	public class ARViewMediator extends BaseMediator
	{
		[Inject]
		public var view:ARView;

		[Inject]
		public var contextView : ContextView;

		[Inject]
		public var view3D:View3D;

		[Inject(name="ui")]
		public var starlingUi : DisplayObjectContainer;

		[Inject(name="background")]
		public var background : DisplayObjectContainer;

		[Inject]
		public var arModel:IARModel;

		[Inject]
		public var modelStorage:AssetStorage;

		private var _3dContainer : Sprite;
		private var modelContainer:Away3DContainer;

		private var isInit:Boolean = true;
		private var isFirstRender:Boolean = true;
//		private var _trident:Trident;
		private var transitionBitmap : Bitmap;
		private var uiView : AugRealityUiView;


		private var _3dCamera : Camera3D;
		private var _chromeCast : Mesh;
		private var entireScene : EntireScene;
		private var _loungeContainer : ObjectContainer3D;
		private var _chromeCastContainer : ObjectContainer3D;
		private var _iconContainer : ObjectContainer3D;

		private var stage3DProxy : Stage3DProxy;
		private var videoImage : Image;

		private var spinTween : TweenMax;
		private var loungIntroTween : TweenMax;
		private var chromeRototeToDefaultPos : TweenMax;
		private var chromeHorizontalTween : TweenMax;
		private var chromeScaleATween : TweenMax;
		private var chromeScaleBTween : TweenMax;
		private var moveToTVTween : TweenMax;
		private var logoRotationTween : TweenMax;
		private var wobbleTween:TweenMax;
		private var scaleIconDown:TweenMax;
		private var scaleIconUp:TweenMax;


		public function ARViewMediator()
		{
			super();
		}


		override public function initialize():void
		{
			super.initialize();

			_3dContainer = Sprite(contextView.view.getChildByName("_3dContainer"));

			_3dCamera = view3D.camera;

			view.width = view.stage.width;
			view.height = view.stage.height;

			view.mouseEnabled = false;


			stage3DProxy = ViewRoot(contextView.view).stage3DProxy;


			addContextListener(ARModelEvent.ON_INIT_AUG_REALITY, onInitAugReality);
			addContextListener(ARModelEvent.ON_DESTROY_AUG_REALITY, onDestroyAugReality);

			addContextListener(ApplicationModelEvent.ON_PREPARE_AUG_REALITY_VIEW, onPrepareViewIn);
			addContextListener(ApplicationModelEvent.ON_DISPOSE_AUG_REALITY_VIEW, onPrepareViewOut);

			addContextListener(ARModelEvent.ON_MARKER_DETECTED, onMarkerDetected);
			addContextListener(ARModelEvent.ON_MARKER_LOST, onMarkerLost);
			addContextListener(ARModelEvent.ON_MARKER_UPDATE, onMarkerUpdate);

			addContextListener(AssetStorageEvent.ON_MODEL_LOADED, onModelsLoaded);
			addContextListener(AppEvent.START_UP_COMPLETE, onStartUpComplete);
			addContextListener(AppEvent.CAST_IN_AR, onCastInAurRealityHandler);
			addContextListener(Ar3dModelEvent.ON_USER_INTERACTION, onUserInteraction);
		}


		private function onModelsLoaded(event:AssetStorageEvent):void
		{
			modelContainer = new Away3DContainer();
			modelContainer.x = 0;
			modelContainer.y = 0;
			modelContainer.z = 0;

			entireScene = EntireScene(modelStorage.modelDictionary[EntireScene.ID]);

			_chromeCast = EntireScene(modelStorage.modelDictionary[EntireScene.ID]).chromeCast;
			_loungeContainer = EntireScene(modelStorage.modelDictionary[EntireScene.ID]).loungeContainer;
			_chromeCastContainer = EntireScene(modelStorage.modelDictionary[EntireScene.ID]).chromeCastContainer;
			_iconContainer = EntireScene(modelStorage.modelDictionary[EntireScene.ID]).iconContainer;

			modelContainer.addChild(_loungeContainer);
			modelContainer.addChild(_chromeCastContainer);

			entireScene.resetEntireScene();

			modelContainer.visible = true;
			_loungeContainer.visible = false;
			_chromeCast.visible = true;
			_loungeContainer.visible = true;
			_chromeCastContainer.visible = true;
			_iconContainer.visible = true;

			view3D.scene.addChild(modelContainer);
			modelContainer.scale(0.5);
			modelContainer.z = 500;
		}


		private function onMarkerDetected(event : ARModelEvent):void
		{
			modelContainer.visible = true;
			uiView.visible = true;
			uiView.uiContainer.visible = true;
			_iconContainer.visible = true;
			startChromeCastAnimation();
		}

		private function onMarkerUpdate(event : ARModelEvent):void
		{
			modelContainer.in2arTransform(event.ref.rotationMatrix, event.ref.translationVector, 0.8, false);
		}

		private function onMarkerLost(event : ARModelEvent):void
		{

			modelContainer.visible = false;

			stopTween(spinTween);
			stopTween(loungIntroTween);
			stopTween(chromeRototeToDefaultPos);
			stopTween(chromeHorizontalTween);
			stopTween(chromeScaleATween);
			stopTween(chromeScaleBTween);
			stopTween(moveToTVTween);
			stopTween(logoRotationTween);
			stopTween(wobbleTween);
			stopTween(scaleIconDown);
			stopTween(scaleIconUp);

			EntireScene(modelStorage.modelDictionary[EntireScene.ID]).resetEntireScene();


			logger.info("***********************  onMarkerLost");

			dispatch(new Ar3dModelEvent(Ar3dModelEvent.DISABLE_INTERACTION));
		}


		//1. start anim
		private function startChromeCastAnimation():void
		{
			_chromeCastContainer.visible = true;
			dispatch(new Ar3dModelEvent(Ar3dModelEvent.WAITING_FOR_INTERACTION));
			spinTween = TweenMax.to(_chromeCast, 3, {rotationY: 360, repeat: -1, ease:Linear.easeNone});
			logoRotationTween = TweenMax.to(_iconContainer, 5 , {rotationY: 360, repeat: -1, ease:Linear.easeNone});
			wobbleTween = TweenMax.to(_iconContainer, 7, {rotationX:10, repeat:-1, yoyo: true, ease:Linear.easeNone});
			scaleIconDown = TweenMax.to(_iconContainer, 2, { scaleX:1, scaleZ:1,scaleY:1} );

		}

		//2. after user has clicked
		private function onUserInteraction(event : Ar3dModelEvent):void
		{
			chromeCastIntoTVAnim();
		}

		// 3. start toward tv
		private function chromeCastIntoTVAnim():void
		{
			_loungeContainer.y = 500;
			_loungeContainer.visible = true;
			
			loungIntroTween = TweenMax.to(_loungeContainer, 1, { y:0 } );
			scaleIconUp = TweenMax.to(_iconContainer, 10, { scaleX:5, scaleZ:5,scaleY:5, onComplete:onIconsOutComplete} );

			entireScene.playStatic();


			_chromeCast.x = 0;
			_chromeCast.y = 0;
			_chromeCast.y = 0;

			var pointA: Vector3D = new Vector3D(178, 246, 86);
			var pointB: Vector3D = new Vector3D(-276, 248 , 193);
			var pointC: Vector3D = new Vector3D(-110, 248, 210);

			chromeRototeToDefaultPos = TweenMax.to(_chromeCast, 1, {rotationX: -180, rotationY: 90, rotationZ: 0});
			chromeHorizontalTween = TweenMax.to(_chromeCast, 1, {delay:1, rotationX: -90, rotationY: -90, rotationZ: 0});
			chromeScaleATween = TweenMax.to(_chromeCast, 1, {delay:2, scaleX: 0.63, scaleY: 0.63, scaleZ: 0.63});
			chromeScaleBTween =TweenMax.to(_chromeCast, 1, {delay:3, scaleX: 0.11, scaleY: 0.11, scaleZ: 0.11});

			moveToTVTween = TweenMax.to(_chromeCast, 5, {bezier:{curviness:1.25, values:[
				{x:pointA.x, y:pointA.y, z:pointA.z},
				{x:pointB.x, y:pointB.y, z:pointB.z},
				{x:pointC.x, y:pointC.y, z:pointC.z}]
				, ease:Power1.easeInOut}, onComplete:onChromeIntoTvComplete});
		}

		private function onIconsOutComplete():void
		{
			_iconContainer.visible = false;
		}

		// 4.  chrome cast in tv lock AR and zoom into tv
		private function onChromeIntoTvComplete():void
		{
			entireScene.readyToCast();
			
			dispatch(new Ar3dModelEvent(Ar3dModelEvent.ON_CC_INTO_TV_COMPLETE));
		}

		// 5. zoom to tv complete
		private function onZoomToTVComplete():void
		{
			uiView.uiContainer.touchable = true;
			TweenMax.to(uiView.uiContainer, 1, {autoAlpha:1});
		}

		private function onCastInAurRealityHandler(event: AppEvent):void
		{
			uiView.uiContainer.touchable = false;
			entireScene.castVideo();
		}

		private function onInitAugReality(event:ARModelEvent):void
		{
			if (isInit)
			{
				initAway3D();
				isInit = false;
			}
			initCamera();
			startRendering();
		}

		private function onDestroyAugReality(event : ARModelEvent):void
		{
			stopRendering();
			isFirstRender = true;
		}

		private function initAway3D():void
		{
			view3D.camera.lens.far = 5000;
		}

		private function render(event:Event = null) : void
		{
			if (isFirstRender)
			{
				isFirstRender = false;
				augRealityInitComplete();
			}
		}

		private function onPrepareViewIn(event : ApplicationModelEvent):void
		{
			logger.info("onPrepareViewIn");

			_3dContainer.x = view.stage.stageWidth;
			uiView.uiContainer.visible = false;
			uiView.swipeToContinue.visible = false;
			TweenMax.to(uiView, 0.5, {autoAlpha:1});
			TweenMax.to(_3dContainer, 0.5, {x:0, ease:Cubic.easeOut, onComplete:augRealityInitComplete});
			startRendering();
			dispatch(new AppEvent(AppEvent.INIT_AUG_REALTY));

		}


		private function onPrepareViewOut(event : ApplicationModelEvent):void
		{
			logger.info("onPrepareViewOut");

			transitionBitmap = new Bitmap(arModel.cameraBuffer.clone());
			transitionBitmap.width = view.stage.stageWidth;
			transitionBitmap.height = view.stage.stageHeight;
			_3dContainer.addChild(transitionBitmap);

			TweenMax.to(uiView, 0.5, {autoAlpha:0});
			TweenMax.to(_3dContainer, 0.5, {x:0-view.stage.stageWidth, ease:Cubic.easeOut, onComplete:onViewOutComplete});
			stopRendering();

			view3D.background = null;
		}

		private function onViewOutComplete():void
		{
			entireScene.resetEntireScene();

			modelContainer.x = 0;
			modelContainer.y = 0;
			modelContainer.z = 0;
			
			uiView.swipeToContinue.visible = false;
			
			background.removeChild(videoImage);
			videoImage.dispose();
			_3dContainer.removeChild(transitionBitmap);
			dispatch(new AppEvent(AppEvent.DESTROY_AUG_REALTY));
		}

		private function augRealityInitComplete():void
		{
			uiView.visible = true;
		}

		private function initCamera():void
		{

			videoImage = new Image(arModel.cTexture);
			_3dCamera.lens = arModel.lens;

			videoImage.scaleX = 2.8;
			videoImage.scaleY = 2.8;

			background.addChild(videoImage);

			dispatch(new AppEvent(AppEvent.HIDE_USER_FEEDBACK_VIEW));
		}

		private function onStartUpComplete(event : AppEvent):void
		{
			uiView = new AugRealityUiView();
			uiView.visible = false;
			modelContainer.visible = true;

			entireScene.resetEntireScene();

			starlingUi.addChildAt(uiView, starlingUi.numChildren - 2);
		}

		private function stopTween(value:TweenMax) : void
		{
			try
			{
				value.pause();
			}
			catch(error: Error)
			{
				logger.info("Tween Does not exist");
			}
		}


		private function startRendering() : void
		{
			view.addEventListener(Event.ENTER_FRAME, render);
		}

		private function stopRendering() : void
		{
			view.removeEventListener(Event.ENTER_FRAME, render);
		}
	}
}
