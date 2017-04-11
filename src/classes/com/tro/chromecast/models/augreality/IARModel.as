/**
 * Created by russellmilburn on 25/09/15.
 */
package com.tro.chromecast.models.augreality
{

	import away3d.core.managers.Stage3DProxy;

	import com.tro.chromecast.views.components.away3d.Away3DCameraLens;

	import flash.display.BitmapData;

	import flash.display.Stage;

	import starling.textures.ConcreteTexture;

	public interface IARModel
	{
		function get cTexture() : ConcreteTexture;
		function get lens() : Away3DCameraLens;
		function set stage(value : Stage) : void;
		function set stage3DProxy(value : Stage3DProxy) : void;
		function initAugReality() : void;
		function destroyAugReality() : void;
		function get cameraBuffer() : BitmapData
	}
}
