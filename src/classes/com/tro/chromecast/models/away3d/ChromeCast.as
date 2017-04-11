/**
 * Created by russellmilburn on 24/08/15.
 */
package com.tro.chromecast.models.away3d
{

	import away3d.animators.VertexAnimator;
	import away3d.animators.nodes.VertexClipNode;
	import away3d.animators.nodes.VertexClipNode;
	import away3d.animators.states.VertexClipState;
	import away3d.cameras.Camera3D;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.View3D;
	import away3d.entities.Mesh;
	import away3d.events.AnimationStateEvent;
	import away3d.events.LoaderEvent;
	import away3d.library.AssetLibrary;

	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;

	import flash.net.URLRequest;

	public class ChromeCast extends Ar3dModel
	{
//		[Embed(source="/../content/models/Chromecast_NoAnim_v1.awd", mimeType="application/octet-stream")]
//		//[Embed(source="/../content/models/Chromecast_Icons_Combined_v4.awd", mimeType="application/octet-stream")]
//		private var ChromeCastAWD : Class;

		public static const ID : String = "Chromecast";
		public static const CC_INTRO_ANIM_NODE_ID : String = "AWDAnimationClip_CCast_Intro";
		public static const CC_INTO_TV_ANIM_NODE_ID : String = "AWDAnimationClip_CC_TV";
		public static const CC_TV_ANIM_NODE_ID : String = "AWDAnimationClip_CC_Static_in_TV";

		public static const CC_ANIMATOR_ID : String = "AWD Animator_CCast";
		public static const CHROME_ANIMATOR_ID : String = "AWD Animator_Chrome";
		public static const PRESTO_ANIMATOR_ID : String = "AWD Animator_Presto";
		public static const YOU_TUBE_ANIMATOR_ID : String = "AWD Animator_YT";
		public static const NETFLIXS_ANIMATOR_ID : String = "AWD Animator_NF";
		public static const PLAYSTORE_ANIMATOR_ID : String = "AWD Animator_Icons";
		public static const PANDORA_ANIMATOR_ID : String = "AWD Animator_Pandora";
		public static const STAN_ANIMATOR_ID : String = "AWD Animator_Stan";
		public static const QUICKFLIX_ANIMATOR_ID : String = "AWD AnimatorQF";

		public static const CLIP_CHROME : String = "AWDAnimationClip_Chrome";
		public static const CLIP_PRESTO : String = "AWDAnimationClip_Presto";
		public static const CLIP_YOU_TUBE : String = "AWDAnimationClip_YT";
		public static const CLIP_NETFLIXS : String = "AWDAnimationClip_NF";
		public static const CLIP_PLAYSTORE : String = "AWDAnimationClip_Play";
		public static const CLIP_PANDORA : String = "AWDAnimationClip_Pandora";
		public static const CLIP_STAN : String = "AWDAnimationClip_Stan";
		public static const CLIP_QUICKFLIX : String = "AWDAnimationClip_QF";

		private static const ENTER : String = "Enter";
		private static const SPIN : String = "Spin";
		private static const EXIT : String = "Exit";

		protected var iconClipIds: Array;
		protected var iconClipAnimatorIds : Array;
		protected var iconIndex : int = 0;
		public var iconContainer : ObjectContainer3D;
		protected var chromeCast : ObjectContainer3D;
		protected var hasIconCycleCompleted : Boolean = false;
		protected var hasCcCycleCompleted : Boolean = false;

		private var statesToReset: Array;
		private var spinTween:TweenMax;
		private var wobbleTween:TweenMax;


		public function ChromeCast()
		{
			id = ID;

			iconClipIds = new Array();
			iconClipAnimatorIds = new Array();

			iconClipIds.push(CLIP_CHROME);
			iconClipIds.push(CLIP_PRESTO);
			iconClipIds.push(CLIP_YOU_TUBE);
			iconClipIds.push(CLIP_NETFLIXS);
			iconClipIds.push(CLIP_PLAYSTORE);
			iconClipIds.push(CLIP_PANDORA);
			iconClipIds.push(CLIP_STAN);
			iconClipIds.push(CLIP_QUICKFLIX);

			iconClipAnimatorIds.push(CHROME_ANIMATOR_ID);
			iconClipAnimatorIds.push(PRESTO_ANIMATOR_ID);
			iconClipAnimatorIds.push(YOU_TUBE_ANIMATOR_ID);
			iconClipAnimatorIds.push(NETFLIXS_ANIMATOR_ID);
			iconClipAnimatorIds.push(PLAYSTORE_ANIMATOR_ID);
			iconClipAnimatorIds.push(PANDORA_ANIMATOR_ID);
			iconClipAnimatorIds.push(STAN_ANIMATOR_ID);
			iconClipAnimatorIds.push(QUICKFLIX_ANIMATOR_ID);

			statesToReset = new Array();

		}

		override public function load() : void
		{
			//loader3D.load(new URLRequest("/models/Chromecast_Icons_Combined_v4.awd"));
			//loader3D.loadData(new ChromeCastAWD());
		}

		override protected function onResourceComplete(event:LoaderEvent):void
		{
			chromeCast = Mesh(AssetLibrary.getAsset("Chromecast"));
			chromeCast.visible = false;
//			chromeCast.z = chromeCast.z + 1;
			logger.info(chromeCast.scaleX + " " + chromeCast.scaleY + " " + chromeCast.scaleZ);

			var qf: Mesh = Mesh(AssetLibrary.getAsset("QUICKFLIX_ICON_G"));
			var stan: Mesh = Mesh(AssetLibrary.getAsset("STAN_ICON_G"));
			var play: Mesh = Mesh(AssetLibrary.getAsset("PLAY_ICON_G"));
			var nf: Mesh = Mesh(AssetLibrary.getAsset("NETFLIX_ICON_G"));
			var youtube: Mesh = Mesh(AssetLibrary.getAsset("YOUTUBE ICON_G"));
			var presto: Mesh = Mesh(AssetLibrary.getAsset("PRESTO ICON_G"));
			var chrome: Mesh = Mesh(AssetLibrary.getAsset("CHROME ICON_G"));
			var pandora: Mesh = Mesh(AssetLibrary.getAsset("PANDORA_ICON_G"));

			iconContainer = new ObjectContainer3D();
			iconContainer.addChild(qf);
			iconContainer.addChild(stan);
			iconContainer.addChild(play);
			iconContainer.addChild(nf);
			iconContainer.addChild(youtube);
			iconContainer.addChild(presto);
			iconContainer.addChild(chrome);
			iconContainer.addChild(pandora);
			iconContainer.visible = false;

			super.onResourceComplete(event);

		}


		// 1. START intro chrome cast
		public function playChromeCastIntro() : void
		{
			logger.info("[1] START intro chrome cast");
			chromeCast.visible = true;
			chromeCast.x = 20;
//			getAnimator(ChromeCast.CC_ANIMATOR_ID).play(ChromeCast.CC_INTRO_ANIM_NODE_ID, null, 0);
//			TweenMax.to(chromeCast, 0.5, {scaleX:1.4353748065344207, scaleY:1.4353752920051577, scaleZ: 1.435374858745163, onComplete:onScaleComplete});
			TweenMax.to(chromeCast, 0.5, {scaleX:1.5, scaleY:1.5, scaleZ: 1.5, onComplete:onScaleComplete});
		}

		// 2. Chrome cast intro complete play icon intro
		private function onScaleComplete():void
		{
			logger.info("[2] Chrome cast intro complete play icon intro");
			dispatchEvent(new Ar3dModelEvent(Ar3dModelEvent.ON_CC_INTRO_COMPLETE));
			playIconsIntro();
		}

		// 3. intro icons start to play
		public function playIconsIntro() : void
		{
			logger.info("[3] intro icons start to play");

			iconIndex = 0;
			for(var i:int= 0; i < iconClipIds.length; i++)
			{
				var animationNodeId : String = iconClipIds[i];
				var animatorId : String = iconClipAnimatorIds[i];
				var animator : VertexAnimator = animators[animatorId];
				var clip:VertexClipNode = super.animationNodes[animationNodeId + ENTER];
				clip.looping = false;
				clip.addEventListener(AnimationStateEvent.PLAYBACK_COMPLETE, onIconsIntroPlayBackComplete);
				play3DAnimation(animatorId, animationNodeId + ENTER);

			}
			TweenMax.to(iconContainer, 0.1, {visible:true});
		}

		// 4. intro icons have finished
		private function onIconsIntroPlayBackComplete(event:AnimationStateEvent):void
		{
//			var animator : VertexAnimator = VertexAnimator(event.animator);
//			stop3DAnimation(animator.name);
			//statesToReset.push(animator.activeState);


			var node: VertexClipNode = VertexClipNode(event.animationNode);
			node.removeEventListener(AnimationStateEvent.PLAYBACK_COMPLETE, onIconsIntroPlayBackComplete);

			iconIndex ++;
			if (iconIndex == 8)
			{
				logger.info("[4] intro icons have finished");
				dispatchEvent(new Ar3dModelEvent(Ar3dModelEvent.ON_ICONS_INTRO_COMPLETE));
				dispatchEvent(new Ar3dModelEvent(Ar3dModelEvent.WAITING_FOR_INTERACTION));
			}
		}

		// 5. play icons spin until the interaction has happened
		public function playIconsSpin() : void
		{
			logger.info("[5] play icons spin until the interaction has happened");
			spinTween = TweenMax.to(iconContainer, 7, {rotationY:360, repeat:-1, ease:Linear.easeNone, onComplete:onIconsSpinComplete});
			wobbleTween = TweenMax.to(iconContainer, 7, {rotationX:10, repeat:-1, yoyo: true, ease:Linear.easeNone});
		}

		// 6. continue to loop until interaction has happened
		private function onIconsSpinComplete():void
		{
			logger.info("[6] continue to loop until interaction has happened");
//			TweenMax.to(iconContainer, 7, {rotationY:360, ease:Linear.easeNone, onComplete:onIconsSpinComplete});
//			TweenMax.to(iconContainer, 7, {rotationX:10, ease:Linear.easeNone});


//			var animator : VertexAnimator = VertexAnimator(event.animator);
//			stop3DAnimation(animator.name);
//
//			var node: VertexClipNode = VertexClipNode(event.animationNode);
//			node.removeEventListener(AnimationStateEvent.PLAYBACK_COMPLETE, onIconsSpinComplete);
//
//			iconIndex ++;
//			if (iconIndex == 8)
//			{
//				logger.info("onIconsSpinComplete");
//				dispatchEvent(new Ar3dModelEvent(Ar3dModelEvent.ON_ICONS_SPIN_COMPLETE));
//
//				//playIconsExit();
//			}
		}

		// 7. user interaction has happened complete the spin cycle at speed
		public function completeSpinCycle() : void
		{
			logger.info("[7] user interaction has happened complete the spin cycle at speed");
			//var node : VertexClipNode = animationNodes[ChromeCast.CC_INTRO_ANIM_NODE_ID];
			//node.addEventListener(AnimationStateEvent.PLAYBACK_COMPLETE, onCcSpinCycleComplete);

			//var animator : VertexAnimator = animators[ChromeCast.CC_ANIMATOR_ID];
			//animator.playbackSpeed = 10;

			TweenMax.killTweensOf(iconContainer);
			spinTween = TweenMax.to(iconContainer, 1.5, {rotationY:360, ease:Linear.easeNone, onComplete:onIconsSpinCycleComplete});
			wobbleTween =TweenMax.to(iconContainer, 1.5, {rotationX:0, ease:Linear.easeNone});
		}

		// 8. Icon spin cycle is complete
		private function onIconsSpinCycleComplete():void
		{
			logger.info("[8] Icon spin cycle is complete");
			hasIconCycleCompleted = true;

			if (areModelsInCorrectPosition())
			{
				playIconsExit();
				playChromeCastIntoTV();
				logger.info("[8] dispatch display lounge");
				dispatchEvent(new Ar3dModelEvent(Ar3dModelEvent.DISPLAY_LOUNGE));
			}

		}

		// 8. Chrome cast spin cycle is complete.
		private function onCcSpinCycleComplete(event:AnimationStateEvent):void
		{
			logger.info("[8] Chrome cast spin cycle is complete");
			var node : VertexClipNode = animationNodes[ChromeCast.CC_INTRO_ANIM_NODE_ID];
			node.removeEventListener(AnimationStateEvent.PLAYBACK_COMPLETE, onCcSpinCycleComplete);
			var animator : VertexAnimator = animators[ChromeCast.CC_ANIMATOR_ID];
			animator.playbackSpeed = 1;

			hasCcCycleCompleted = true;

			if (areModelsInCorrectPosition())
			{
				playIconsExit();
				playChromeCastIntoTV();
				logger.info("[8] dispatch display lounge");
				dispatchEvent(new Ar3dModelEvent(Ar3dModelEvent.DISPLAY_LOUNGE));
			}
		}

		// 9. start the icons to exit
		public function playIconsExit() : void
		{
			logger.info("[9] start the icons to exit");
			iconIndex = 0;
			for(var i:int= 0; i < iconClipIds.length; i++)
			{
				var animationNodeId : String = iconClipIds[i];
				var animatorId : String = iconClipAnimatorIds[i];
				logger.info("ICON_ID: " + animationNodeId + ", ANIMATOR_ID: " + animatorId);
//				reset3DAnimation(animatorId, animationNodeId + EXIT);
				var clip:VertexClipNode = super.animationNodes[animationNodeId + EXIT];
				clip.looping = false;
				clip.addEventListener(AnimationStateEvent.PLAYBACK_COMPLETE, onIconExitComplete);
				play3DAnimation(animatorId, animationNodeId +EXIT);
			}
		}

		// 9. start chrome cast into TV
		public function playChromeCastIntoTV() : void
		{
			logger.info("[9] start chrome cast in to TV");
			var clip : VertexClipNode = animationNodes[CC_INTO_TV_ANIM_NODE_ID];
			clip.addEventListener(AnimationStateEvent.PLAYBACK_COMPLETE, onCcIntoTVComplete);
			clip.looping = false;
			//reset3DAnimation(ChromeCast.CC_ANIMATOR_ID, ChromeCast.CC_INTO_TV_ANIM_NODE_ID);
			play3DAnimation(ChromeCast.CC_ANIMATOR_ID, ChromeCast.CC_INTO_TV_ANIM_NODE_ID);
			dispatchEvent(new Ar3dModelEvent(Ar3dModelEvent.ON_CC_INTO_TV_START));
		}


		// 10. icons exit complete
		private function onIconExitComplete(event:AnimationStateEvent):void
		{
			logger.info("[10] icons exit complete");
			var animator : VertexAnimator = VertexAnimator(event.animator);
			stop3DAnimation(animator.name);

			var node: VertexClipNode = VertexClipNode(event.animationNode);
			node.removeEventListener(AnimationStateEvent.PLAYBACK_COMPLETE, onIconExitComplete);

			iconIndex ++;
			if (iconIndex == 8)
			{
				logger.info("onIconExitComplete");
				dispatchEvent(new Ar3dModelEvent(Ar3dModelEvent.ON_ICONS_EXIT_COMPLETE));
			}
		}

		// 11. END chrome cast in tv
		private function onCcIntoTVComplete(event:AnimationStateEvent):void
		{
			logger.info("[11] END chrome cast in tv");
			var clip : VertexClipNode = animationNodes[CC_INTO_TV_ANIM_NODE_ID];
			clip.removeEventListener(AnimationStateEvent.PLAYBACK_COMPLETE, onCcIntoTVComplete);
			stop3DAnimation(ChromeCast.CC_ANIMATOR_ID);

			logger.info("Chromecast Pos: " + chromeCast.x +  " " + chromeCast.y+  " " + chromeCast.z);

			dispatchEvent(new Ar3dModelEvent(Ar3dModelEvent.ON_CC_INTO_TV_COMPLETE));
		}

		private function areModelsInCorrectPosition() : Boolean
		{
			if (hasCcCycleCompleted && hasIconCycleCompleted)
			{
				hasCcCycleCompleted = false;
				hasIconCycleCompleted = false;
				return true;
			}
			return false;

		}


		public function reset() : void
		{
//			if (wobbleTween != null && spinTween != null)
//			{
//
//
//				spinTween = null;
//				wobbleTween = null;
//			}
			TweenMax.killTweensOf(iconContainer);
			chromeCast.visible = false;
			iconContainer.visible = false;
			iconContainer.rotationX = 0;
			iconContainer.rotationY = 0;
			chromeCast.scale(0);
			//reset3DAnimation(ChromeCast.CC_ANIMATOR_ID, ChromeCast.CC_INTRO_ANIM_NODE_ID);

			for(var i:int= 0; i < iconClipIds.length; i++)
			{
				var animationNodeId : String = iconClipIds[i];
				var animatorId : String = iconClipAnimatorIds[i];
				reset3DAnimation(animatorId, animationNodeId + ENTER);
				reset3DAnimation(animatorId, animationNodeId + EXIT);
			}



		}

	}
}
