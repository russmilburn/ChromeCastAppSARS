/**
 * Created by russellmilburn on 22/07/15.
 */
package com.tro.chromecast.views
{

	import away3d.cameras.Camera3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.core.managers.Stage3DManager;
	import away3d.core.managers.Stage3DProxy;
	import away3d.debug.AwayStats;
	import away3d.events.Stage3DEvent;
	import away3d.loaders.parsers.Parsers;

	import com.tro.chromecast.Config;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;

	import org.gestouch.core.Gestouch;
	import org.gestouch.extensions.starling.StarlingDisplayListAdapter;
	import org.gestouch.extensions.starling.StarlingTouchHitTester;
	import org.gestouch.input.NativeInputAdapter;

	import robotlegs.bender.bundles.SARSBundle;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.sarsIntegration.api.StarlingCollection;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.LogLevel;
	import robotlegs.bender.framework.impl.Context;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.ResizeEvent;

	public class ViewRoot extends Sprite
	{
		// Away 3D Varibles

		private var _view : View3D;
		private var _camera : Camera3D;
		private var _scene : Scene3D;
		private var _stats : AwayStats;
		private var _3dContainer : Sprite;

		// Starling Varilbles
		private var _starlingUI : Starling;
		private var _starlingBackground : Starling;

		// Common Varibles

		private var _stage3DManager : Stage3DManager;
		private var _stage3DProxy : Stage3DProxy;

		private var _context : IContext;
		private var shapeScaler:Shape;

		public function ViewRoot()
		{
			super();

			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

			_stage3DManager = Stage3DManager.getInstance(stage);

			_stage3DProxy = _stage3DManager.getFreeStage3DProxy();
			_stage3DProxy.antiAlias = 0;
			_stage3DProxy.color = 0xf;

			_stage3DProxy.addEventListener(Stage3DEvent.CONTEXT3D_CREATED, onCreate);

			_3dContainer = new Sprite();
			_3dContainer.name = "_3dContainer";
			_3dContainer.x = 0;
			_3dContainer.y = 0;

			addChild(_3dContainer);


		}

		private function onCreate(event:Stage3DEvent):void
		{

			initStarling();
			initAway3D();




			_context = new Context();


			_context.logLevel = LogLevel.DEBUG;
			//_context.addLogTarget(new TraceLogTarget(_context));

			var starlingCollection : StarlingCollection = new StarlingCollection();
			starlingCollection.addItem(_starlingBackground, "background");
			starlingCollection.addItem(_starlingUI, "ui");



			_context.install(SARSBundle).configure(_view, starlingCollection, Config, new ContextView(this));

			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}


		private function initAway3D():void
		{

			// Setup Scene
			_scene = new Scene3D();

			Parsers.enableAllBundled();

			_camera = new Camera3D();
			_camera.z = -600;
			//_camera.x = 1000;

			_camera.lens.far = 5000;
			_camera.position = new Vector3D(0,0,0);


			//Setup view;
			_view = new View3D();
			_view.width = stage.stageWidth;
			_view.height = stage.stageWidth * (9/16);
			_view.camera = _camera;
			_view.scene = _scene;
			_view.stage3DProxy = _stage3DProxy;
			_view.stage3DProxy.y = (stage.stageHeight - _view.height) * 0.5;
			_view.shareContext = true;

			_3dContainer.addChild(_view);
			_3dContainer.mouseChildren = false;
			_3dContainer.mouseEnabled = false;
			_3dContainer.buttonMode = false;

			_3dContainer.x = 0;

			
			//Set up hover camera
			//_cameraController = new HoverController(_camera, null, 150, 10, 2000);

			//Show away 3d Stats
			_stats = new AwayStats(_view, true);
			_stats.scaleX = 3;
			_stats.scaleY = 3;
			_stats.mouseEnabled = true;
			_stats.x = 5;
			_stats.y = stage.stageHeight - _stats.height;
			//this.addChild(_stats);


		}

		private function initStarling():void
		{
			trace("initStarling");
			var viewPort : Rectangle = new Rectangle(0, 0, 1920, 1080);

			Starling.handleLostContext = true;
			_starlingBackground = new Starling(BackgroundStarlingView, stage, viewPort, _stage3DProxy.stage3D);
			_starlingBackground.simulateMultitouch = false;
			_starlingBackground.antiAliasing = 0;
			_starlingBackground.start();

			_starlingUI = new Starling(StarlingViewContainer, stage, viewPort, _stage3DProxy.stage3D);
			_starlingUI.simulateMultitouch = true;
			_starlingUI.antiAliasing = 0;
			_starlingUI.start();


			//_starlingUI.showStats = true;

			//TODO: Move Gesture touch framework code to start up command or application model

			// Gestouch initialization step 1 of 3:
			// Initialize native (default) input adapter. Needed for non-DisplayList usage.
			Gestouch.inputAdapter = new NativeInputAdapter(_starlingUI.nativeStage, true, true);

			// Gestouch initialization step 2 of 3:
			// Register instance of StarlingDisplayListAdapter to be used for objects of type starling.display.DisplayObject.
			// What it does: helps to build hierarchy (chain of parents) for any Starling display object and
			// acts as a adapter for gesture target to provide strong-typed access to methods like globalToLocal() and contains().
			Gestouch.addDisplayListAdapter(DisplayObject, new StarlingDisplayListAdapter());

			// Gestouch initialization step 3 of 3:
			// Initialize and register StarlingTouchHitTester.
			// What it does: finds appropriate target for the new touches (uses Starling Stage#hitTest() method)
			// What does “-1” mean: priority for this hit-tester. Since Stage3D layer sits behind native DisplayList
			// we give it lower priority in the sense of interactivity.
			Gestouch.addTouchHitTester(new StarlingTouchHitTester(_starlingUI), -1);


			shapeScaler = new Shape();
			shapeScaler.graphics.beginFill(0);
			shapeScaler.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			shapeScaler.graphics.endFill();

			_starlingUI.stage.addEventListener(ResizeEvent.RESIZE, starlingStageResizeListener);
			_starlingBackground.stage.addEventListener(ResizeEvent.RESIZE, starlingStageResizeListener);

			stage.displayState = StageDisplayState.FULL_SCREEN;

			starlingStageResize(shapeScaler.width, shapeScaler.height);

		}

		private function starlingStageResizeListener(event:ResizeEvent):void
		{
			starlingStageResize(event.width, event.height);
		}

		private function starlingStageResize(width:int, height:int):void
		{
			var appHeight: Number = width * (9/16);
			var xPos: Number = (stage.stageHeight - appHeight) * 0.5;
			trace(xPos);

			var viewPort:Rectangle = new Rectangle(0, xPos , width, appHeight);

			_starlingUI.viewPort = viewPort;
			_starlingBackground.viewPort = viewPort;

		}

		private function onResize(event:ResizeEvent):void
		{
			//trace("onResize");
		}

		private function onEnterFrame(event:Event):void
		{
			_stage3DProxy.clear();

			_starlingBackground.nextFrame();

			_view.render();

			_starlingUI.nextFrame();

			_stage3DProxy.present();
		}


		public function get starlingUI():Starling
		{
			return _starlingUI;
		}

		public function set starlingUI(value:Starling):void
		{
			_starlingUI = value;
		}


		public function get stage3DProxy():Stage3DProxy
		{
			return _stage3DProxy;
		}

		public function set stage3DProxy(value:Stage3DProxy):void
		{
			_stage3DProxy = value;
		}
	}
}
