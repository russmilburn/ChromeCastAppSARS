/**
 * Created by russellmilburn on 19/08/15.
 */
package com.tro.chromecast.models.away3d
{

	import away3d.animators.AnimationSetBase;

	import com.tro.chromecast.models.*;

	import away3d.animators.VertexAnimationSet;
	import away3d.animators.VertexAnimator;
	import away3d.animators.nodes.VertexClipNode;
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.events.LoaderEvent;
	import away3d.library.assets.AssetType;
	import away3d.loaders.Loader3D;
	import away3d.materials.TextureMaterial;

	import flash.events.EventDispatcher;

	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	import robotlegs.bender.framework.api.ILogger;


	public class Ar3dModel extends EventDispatcher
	{
		[Inject]
		public var logger : ILogger;

		public static const PLAYBACK_SPEED : Number = 1;

		private var _id : String;
		protected var loader3D : Loader3D;
		protected var animationNodes:Dictionary;
		protected var animSets:Dictionary;
		protected var animators:Dictionary;

		protected var clipCompleteCount : int = 0;


		public function Ar3dModel()
		{
			animationNodes = new Dictionary();
			animSets = new Dictionary();
			animators = new Dictionary();

			loader3D = new Loader3D(true, null);

			loader3D.addEventListener(AssetEvent.ASSET_COMPLETE, onAssetComplete);
			loader3D.addEventListener(AssetEvent.ANIMATION_NODE_COMPLETE, onAnimNodeLoadComplete);
			loader3D.addEventListener(AssetEvent.ANIMATION_SET_COMPLETE, onAnimSetLoadComplete);
			loader3D.addEventListener(AssetEvent.ANIMATION_STATE_COMPLETE, onAnimationStateComplete);
			loader3D.addEventListener(AssetEvent.MATERIAL_COMPLETE, onLoadMaterialComplete);
			loader3D.addEventListener(AssetEvent.TEXTURE_COMPLETE, onLoadMaterialComplete);
			loader3D.addEventListener(LoaderEvent.RESOURCE_COMPLETE, onResourceComplete);
			loader3D.addEventListener(LoaderEvent.LOAD_ERROR, onLoadError);


		}

		private function onAnimationStateComplete(event:AssetEvent):void
		{
			if (event.asset.assetType == AssetType.ANIMATION_STATE)
			{
				//logger.debug("ANIMATION_STATE: " + event.asset.name);
//				animationNodes[event.asset.name] = event.asset as AnimationSetBase;
			}
		}

		public function load() : void
		{

		}

		protected function onLoadError(event:LoaderEvent):void
		{
			//logger.info(event.message);
		}

		protected function onAnimNodeLoadComplete(event:AssetEvent):void
		{
			if (event.asset.assetType == AssetType.ANIMATION_NODE)
			{
				//logger.debug("ANIMATION_NODE: " + event.asset.name);
				animationNodes[event.asset.name] = event.asset as VertexClipNode;
			}
		}


		protected function onAnimSetLoadComplete(event:AssetEvent):void
		{
			if (event.asset.assetType == AssetType.ANIMATION_SET)
			{
				//logger.debug("ANIMATION_SET: " + event.asset.name);
				animSets[event.asset.name] = event.asset as VertexAnimationSet;
			}
		}

		protected function onLoadMaterialComplete(event:AssetEvent):void
		{

			if (event.asset.assetType == AssetType.TEXTURE)
			{
				//logger.info("TEXTURE " + event.asset.name);
			}
		}

		protected function onAssetComplete(event:AssetEvent):void
		{

			if (event.asset.assetType == AssetType.ANIMATOR)
			{
				//logger.debug("ANIMATOR: " + event.asset.name);
				animators[event.asset.name] = event.asset as VertexAnimator;
			}

			//logger.debug("ASSET: " + event.asset.name + " ASSET TYPE: " + event.asset.assetType);
		}

		protected function onResourceComplete(event:LoaderEvent):void
		{
			dispatchEvent(new Ar3dModelEvent(Ar3dModelEvent.ON_3D_MODEL_READY));
		}


		public function get model():Loader3D
		{
			return loader3D;
		}

		public function set model(value:Loader3D):void
		{
			loader3D = value;
		}


		public function getAnimNode(animId : String ) : VertexClipNode
		{
			return animationNodes[animId];
		}

		public function getAnimator(animatorId : String ) : VertexAnimator
		{
			return animators[animatorId];
		}

		public function get id():String
		{
			return _id;
		}

		public function set id(value:String):void
		{
			_id = value;
		}

		protected function play3DAnimation(animatorId : String, animationId : String) : void
		{
			getAnimator(animatorId).playbackSpeed = PLAYBACK_SPEED;
			getAnimator(animatorId).play(animationId, null, 0);

		}

		protected function stop3DAnimation(animatorId : String) : void
		{
			getAnimator(animatorId).stop();
		}

		protected function reset3DAnimation( animatorId : String, animationId : String) : void
		{

			getAnimator(animatorId).reset(animationId, 0);
		}

	}
}
