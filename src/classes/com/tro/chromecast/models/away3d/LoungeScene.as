/**
 * Created by russellmilburn on 24/08/15.
 */
package com.tro.chromecast.models.away3d
{

	import away3d.animators.SpriteSheetAnimationSet;
	import away3d.animators.SpriteSheetAnimator;
	import away3d.animators.VertexAnimator;
	import away3d.animators.nodes.SpriteSheetClipNode;
	import away3d.animators.nodes.VertexClipNode;
	import away3d.entities.Mesh;
	import away3d.events.AnimationStateEvent;
	import away3d.events.LoaderEvent;
	import away3d.library.AssetLibrary;
	import away3d.materials.MaterialBase;
	import away3d.materials.SpriteSheetMaterial;
	import away3d.materials.TextureMaterial;
	import away3d.textures.BitmapTexture;
	import away3d.textures.Texture2DBase;
	import away3d.textures.VideoTexture;
	import away3d.tools.helpers.SpriteSheetHelper;

	import com.greensock.TweenMax;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.net.URLRequest;

	public class LoungeScene extends Ar3dModel
	{
//		[Embed(source="../../../../../../assets/embed_assets/StaticMaterial_01.jpg")]
//		public static var SpriteSheetA:Class;
//
//		[Embed(source="../../../../../../assets/embed_assets/StaticMaterial_02.jpg")]
//		public static var SpriteSheetB:Class;
//
//		[Embed(source="../../../../../../assets/embed_assets/Ready-to-cast.jpg")]
//		public static var ReadyToCast:Class;
//
//		[Embed(source="/../content/models/LoungeAssets.awd", mimeType="application/octet-stream")]
//		private var LoungeAssetsAWD : Class;


		public static const ID : String = "lounge";

		public static const COUCH_ANIM_NODE_ID : String = "AWDAnimationClip_Couch";
		public static const UNIT_ANIM_NODE_ID : String = "AWDAnimationClip_Unit";
		public static const FLOOR_ANIM_NODE_ID : String = "AWDAnimationClip_Floor";
		public static const TV_ANIM_NODE_ID : String = "AWDAnimationClip_TV";
		public static const TV_STATIC_ANIM_ID : String = "Tv_Static";

		public static const COUCH_ANIMATOR_ID : String = "AWD Animator_Couch";
		public static const UNIT_ANIMATOR_ID : String = "AWD Animator_Unit";
		public static const FLOOR_ANIMATOR_ID : String = "AWD Animator_Floor";
		public static const TV_ANIMATOR_ID : String = "AWD Animator_TV";


		private var loungeAnimatorIds : Array;
		private var loungeClipIds : Array;
		private var tv : Mesh;
		private var display : Mesh;
		private var tvStaticAnimator : SpriteSheetAnimator;
		private var tvStaticMaterial : SpriteSheetMaterial;
		private var readyToCastMaterial : TextureMaterial;
		private var offMaterial : MaterialBase;
		private var videoTexture : VideoTexture;
		private var castingMaterial : TextureMaterial;


		public function LoungeScene()
		{
			super();
			id = ID;

			loungeAnimatorIds = new Array();
			loungeClipIds = new Array();

			loungeClipIds.push(COUCH_ANIM_NODE_ID);
			loungeClipIds.push(UNIT_ANIM_NODE_ID);
			loungeClipIds.push(FLOOR_ANIM_NODE_ID);
			loungeClipIds.push(TV_ANIM_NODE_ID);

			loungeAnimatorIds.push(COUCH_ANIMATOR_ID);
			loungeAnimatorIds.push(UNIT_ANIMATOR_ID);
			loungeAnimatorIds.push(FLOOR_ANIMATOR_ID);
			loungeAnimatorIds.push(TV_ANIMATOR_ID);

		}

		override public function load() : void
		{
			//loader3D.load(new URLRequest("/models/LoungeAssets.awd"));
			//loader3D.loadData(new LoungeAssetsAWD());
		}

		override protected function onResourceComplete(event:LoaderEvent):void
		{
			display = Mesh(AssetLibrary.getAsset("TV_Screen_Only_G"));
			display.visible = true;
			display.z = display.z - 1;

			prepareStaticForTV();
			initTVDisplayMaterial();

			display.material = offMaterial;
			model.visible = false;

			super.onResourceComplete(event);

		}

		public function playLoungeIntro() : void
		{
			clipCompleteCount = 0;

			for(var i:int= 0; i < loungeClipIds.length; i++)
			{
				var animationNodeId : String = loungeClipIds[i];
				var animatorId : String = loungeAnimatorIds[i];
				//logger.info("ICON_ID: " + animationNodeId + ", ANIMATOR_ID: " + animatorId);
				reset3DAnimation(animatorId, animationNodeId);
				var clip:VertexClipNode = super.animationNodes[animationNodeId];
				clip.looping = false;
				clip.addEventListener(AnimationStateEvent.PLAYBACK_COMPLETE, onLoungeIntroComplete);
				play3DAnimation(animatorId, animationNodeId);
			}



//			TweenMax.to(model, 1, {scaleX:1, scaleY:1, scaleZ:1, onComplete:onLoungeScaleComplete});
			model.visible = true;
			logger.info(model.visible);
			logger.info(model.scaleX, [model.scaleX, model.scaleY, model.scaleZ]);

		}

		private function onLoungeScaleComplete():void
		{

		}

		private function onLoungeIntroComplete(event:AnimationStateEvent):void
		{
			var animator : VertexAnimator = VertexAnimator(event.animator);
			stop3DAnimation(animator.name);

			var node: VertexClipNode = VertexClipNode(event.animationNode);

			node.removeEventListener(AnimationStateEvent.PLAYBACK_COMPLETE, onLoungeIntroComplete);

			clipCompleteCount ++;
			if (clipCompleteCount == 4)
			{
				logger.info("onLoungeIntroComplete");
				logger.info(model.scaleX + " " + model.scaleY + " " + model.scaleZ);
				dispatchEvent(new Ar3dModelEvent(Ar3dModelEvent.ON_LOUNGE_INTRO_COMPLETE));
			}
		}

		public function reset() : void
		{
			model.visible = false;
			for(var i:int= 0; i < loungeClipIds.length; i++)
			{
				var animationNodeId : String = loungeClipIds[i];
				var animatorId : String = loungeAnimatorIds[i];
				reset3DAnimation(animatorId, animationNodeId);
			}

			display.animator = null;
			display.material = offMaterial;
			videoTexture.player.stop();

//			model.scaleX = 0;
//			model.scaleY = 0;
//			model.scaleZ = 0;


		}


		private function prepareStaticForTV() : void
		{
//			var bmd1:BitmapData = Bitmap(new SpriteSheetA()).bitmapData;
//			var texture1:BitmapTexture = new BitmapTexture(bmd1);

			//the rest of teh animation
//			var bmd2:BitmapData = Bitmap(new SpriteSheetB()).bitmapData;
//			var texture2:BitmapTexture = new BitmapTexture(bmd2);

//			var diffuses:Vector.<Texture2DBase> = Vector.<Texture2DBase>([texture1, texture2]);
//			tvStaticMaterial = new SpriteSheetMaterial(diffuses);
//
//			var spriteSheetHelper:SpriteSheetHelper = new SpriteSheetHelper();

//			var spriteSheetAnimationSet:SpriteSheetAnimationSet = new SpriteSheetAnimationSet();

//			var spriteSheetClipNode:SpriteSheetClipNode = spriteSheetHelper.generateSpriteSheetClipNode(TV_STATIC_ANIM_ID, 2, 2, 2);

//			spriteSheetAnimationSet.addAnimation(spriteSheetClipNode);
//			tvStaticAnimator = new SpriteSheetAnimator(spriteSheetAnimationSet);
		}


		private function initTVDisplayMaterial() : void
		{
//			var bmd:BitmapData = Bitmap(new ReadyToCast()).bitmapData;
			var readyTexture : BitmapTexture = BitmapTexture(AssetLibrary.getAsset("Map #13"));
			readyToCastMaterial = new TextureMaterial(readyTexture);

			var offTexture : BitmapTexture = BitmapTexture(AssetLibrary.getAsset("Map #4"));
			readyToCastMaterial = new TextureMaterial(offTexture);

			videoTexture = new VideoTexture("/assets/videos/Ex_Machina.mp4", 512, 512);
			castingMaterial = new TextureMaterial(videoTexture);
			castingMaterial.repeat = false;

		}


		public function playTVStatic():  void
		{

			display.visible = true;
			display.material = null;
			display.material = tvStaticMaterial;
			display.animator = tvStaticAnimator;
			tvStaticAnimator.fps = 10;
			tvStaticAnimator.backAndForth = true;

			//start play the animation
			tvStaticAnimator.play(TV_STATIC_ANIM_ID);
		}

		public function readyToCast() : void
		{
			tvStaticAnimator.stop();
			display.animator = null;
			display.material = readyToCastMaterial;


		}

		public function castVideo() : void
		{
			display.animator = null;
			display.material = castingMaterial;

			videoTexture.player.loop = true;
			videoTexture.player.play();

			display.geometry.scaleUV(0.75, 0.75);
		}

	}
}
