/**
 * Created by russellmilburn on 21/09/15.
 */
package com.tro.chromecast.models.vos
{

	import starling.textures.Texture;

	public class DoMoreAppVo
	{
		public static const WATCH : String = "Watch";
		public static const LISTEN : String = "Listen";
		public static const PLAY : String = "Play";

		public var id : Number;
		public var title : String;
		public var iconId : String;
		public var iconTexture : Texture;
		public var category : String;
		public var desc : String;

		public function DoMoreAppVo()
		{
		}
	}
}
