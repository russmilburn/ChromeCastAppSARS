/**
 * Created by russellmilburn on 03/09/15.
 */
package com.tro.chromecast.models.away3d
{

	import away3d.animators.SpriteSheetAnimationSet;
	import away3d.animators.SpriteSheetAnimator;
	import away3d.animators.nodes.SpriteSheetClipNode;
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	import away3d.events.LoaderEvent;
	import away3d.library.AssetLibrary;
	import away3d.materials.SpriteSheetMaterial;
	import away3d.materials.TextureMaterial;
	import away3d.textures.Texture2DBase;
	import away3d.textures.VideoTexture;
	import away3d.tools.helpers.SpriteSheetHelper;

	import flash.net.URLRequest;

	public class EntireScene extends Ar3dModel
	{
		public static const ID : String = "EntireScene";

		[Embed(source="../../../../../../assets/embed_assets/StaticMaterial_01.jpg")]
		public static var SpriteSheetA:Class;

		[Embed(source="../../../../../../assets/embed_assets/StaticMaterial_02.jpg")]
		public static var SpriteSheetB:Class;

		public static const TV_STATIC_ANIM_ID : String = "Tv_Static";

		private var _chromeCast:Mesh;
		private var tv : Mesh;
		private var floor : Mesh;
		private var couch : Mesh;
		private var cabinet : Mesh;
		private var _tvDisplay:Mesh;
		private var _loungeContainer : ObjectContainer3D;
		private var _chromeCastContainer : ObjectContainer3D;

		private var tvStaticAnimator : SpriteSheetAnimator;
		private var tvStaticMaterial : SpriteSheetMaterial;
		private var offMaterial : TextureMaterial;
		private var staticA : TextureMaterial;
		private var staticB : TextureMaterial;
		private var rtc : TextureMaterial;
		private var videoTexture : VideoTexture;
		private var castingMaterial : TextureMaterial;


		private var _chromeCastScale : Number;
		private var _chromeCastXPos : Number;
		private var _chromeCastYPos : Number;
		private var _chromeCastZPos : Number;
		private var _chromeCastXRot : Number;
		private var _chromeCastYRot : Number;
		private var _chromeCastZRot : Number;
		private var _iconContainer:ObjectContainer3D;




		public function EntireScene()
		{
			id = ID;
			super();
		}

		override public function load() : void
		{
			loader3D.load(new URLRequest("/models/EntireScene4.awd"));
//			loader3D.loadData(new ChromeCastAWD());
		}


		override protected function onResourceComplete(event:LoaderEvent):void
		{
			_chromeCast = Mesh(AssetLibrary.getAsset("Chromecast"));
			_chromeCastScale = _chromeCast.scaleX;
			_chromeCastXPos = _chromeCast.x;
			_chromeCastYPos = _chromeCast.y;
			_chromeCastZPos = _chromeCast.z;
			_chromeCastXRot = _chromeCast.rotationX;
			_chromeCastYRot = _chromeCast.rotationY;
			_chromeCastZRot = _chromeCast.rotationZ;

			//logger.info("_chromeCastScale:" +_chromeCastScale);

			_tvDisplay  = Mesh(AssetLibrary.getAsset("TV_Screen_Only_RTC"));
			_tvDisplay.moveBackward(1);

			staticA = TextureMaterial(AssetLibrary.getAsset("Static_1"));
			staticB = TextureMaterial( AssetLibrary.getAsset("Static_2"));
			rtc = TextureMaterial(AssetLibrary.getAsset("RTC"));

			tv = Mesh(AssetLibrary.getAsset("TV_G"));
			floor = Mesh(AssetLibrary.getAsset("Floor_G"));
			couch = Mesh(AssetLibrary.getAsset("New_Couch_G"));
			cabinet = Mesh(AssetLibrary.getAsset("TV_Unit_G"));


			var qf: Mesh = Mesh(AssetLibrary.getAsset("QUICKFLIX_ICON_G"));
			var stan: Mesh = Mesh(AssetLibrary.getAsset("STAN_ICON_G"));
			var play: Mesh = Mesh(AssetLibrary.getAsset("PLAY_ICON_G"));
			var nf: Mesh = Mesh(AssetLibrary.getAsset("NETFLIX_ICON_G"));
			var youtube: Mesh = Mesh(AssetLibrary.getAsset("YOUTUBE ICON_G"));
			var presto: Mesh = Mesh(AssetLibrary.getAsset("PRESTO ICON_G"));
			var chrome: Mesh = Mesh(AssetLibrary.getAsset("CHROME ICON_G"));
			var pandora: Mesh = Mesh(AssetLibrary.getAsset("PANDORA_ICON_G"));

			_iconContainer = new ObjectContainer3D();
			_iconContainer.addChild(qf);
			_iconContainer.addChild(stan);
			_iconContainer.addChild(play);
			_iconContainer.addChild(nf);
			_iconContainer.addChild(youtube);
			_iconContainer.addChild(presto);
			_iconContainer.addChild(chrome);
			_iconContainer.addChild(pandora);
			//iconContainer.visible = false;

			_loungeContainer = new ObjectContainer3D();
			_chromeCastContainer = new ObjectContainer3D();

			_chromeCastContainer.rotationX = 90;
			_loungeContainer.rotationX = 90;
			_loungeContainer.rotationX = 90;


			_loungeContainer.addChild(tv);
			_loungeContainer.addChild(floor);
			_loungeContainer.addChild(couch);
			_loungeContainer.addChild(cabinet);
			_loungeContainer.addChild(_tvDisplay);

			_chromeCastContainer.addChild(_chromeCast);
			_chromeCastContainer.addChild(_iconContainer);

			prepareStaticForTV();

			//initTVDisplayMaterial();

			super.onResourceComplete(event);
		}

		private function prepareStaticForTV() : void
		{
			var diffuses:Vector.<Texture2DBase> = Vector.<Texture2DBase>([staticA.texture, staticB.texture]);
			tvStaticMaterial = new SpriteSheetMaterial(diffuses, null, null, true, true, false);

			var spriteSheetHelper:SpriteSheetHelper = new SpriteSheetHelper();

			var spriteSheetAnimationSet:SpriteSheetAnimationSet = new SpriteSheetAnimationSet();

			var spriteSheetClipNode:SpriteSheetClipNode = spriteSheetHelper.generateSpriteSheetClipNode(TV_STATIC_ANIM_ID, 1, 1, 2);


			spriteSheetAnimationSet.addAnimation(spriteSheetClipNode);
			tvStaticAnimator = new SpriteSheetAnimator(spriteSheetAnimationSet);

			_tvDisplay.visible = true;
			_tvDisplay.material = tvStaticMaterial;
			_tvDisplay.animator = tvStaticAnimator;
			tvStaticAnimator.fps = 10;
			tvStaticAnimator.backAndForth = true;

		}

		public function resetEntireScene() : void
		{
			_chromeCast.scaleX = _chromeCastScale;
			_chromeCast.scaleY = _chromeCastScale;
			_chromeCast.scaleZ = _chromeCastScale;
			_chromeCast.x = _chromeCastXPos;
			_chromeCast.y =_chromeCastYPos;
			_chromeCast.z = _chromeCastZPos;
			_chromeCast.rotationX = _chromeCastXRot;
			_chromeCast.rotationY =_chromeCastYRot;
			_chromeCast.rotationZ = _chromeCastZRot;

			_loungeContainer.y = 500;
			_loungeContainer.visible = false;
			_chromeCastContainer.visible = false;

			_iconContainer.rotationX = 0;
			_iconContainer.rotationY = 0;
			_iconContainer.scaleX = 5;
			_iconContainer.scaleY = 5;
			_iconContainer.scaleZ = 5;
			_iconContainer.visible = false;


		}

		public function playStatic() : void
		{
			tvStaticAnimator.reset(TV_STATIC_ANIM_ID, 0);
			_tvDisplay.material = tvStaticMaterial;
			tvStaticAnimator.fps = 10;
			tvStaticAnimator.backAndForth = true;

//			start play the animation
			tvStaticAnimator.play(TV_STATIC_ANIM_ID);
		}

		private function initTVDisplayMaterial() : void
		{
			videoTexture = new VideoTexture("/assets/videos/Minions.m4v", 1024, 1024);
			castingMaterial = new TextureMaterial(videoTexture);
			castingMaterial.repeat = false;

		}

		public function readyToCast() : void
		{
			_tvDisplay.material = null;
			_tvDisplay.material = rtc;
		}

		public function castVideo() : void
		{
			_tvDisplay.material = castingMaterial;
			videoTexture.player.loop = false;
			videoTexture.player.play();
			_tvDisplay.geometry.scaleUV(1, 1);
		}


		public function get loungeContainer():ObjectContainer3D
		{
			return _loungeContainer;
		}

		public function set loungeContainer(value:ObjectContainer3D):void
		{
			_loungeContainer = value;
		}


		public function get tvDisplay():Mesh
		{
			return _tvDisplay;
		}

		public function set tvDisplay(value:Mesh):void
		{
			_tvDisplay = value;
		}

		public function get chromeCast():Mesh
		{
			return _chromeCast;
		}

		public function set chromeCast(value:Mesh):void
		{
			_chromeCast = value;
		}

		public function get chromeCastContainer():ObjectContainer3D
		{
			return _chromeCastContainer;
		}

		public function set chromeCastContainer(value:ObjectContainer3D):void
		{
			_chromeCastContainer = value;
		}


		public function get iconContainer():ObjectContainer3D
		{
			return _iconContainer;
		}

		public function set iconContainer(value:ObjectContainer3D):void
		{
			_iconContainer = value;
		}
	}
}
