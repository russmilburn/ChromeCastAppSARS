/**
 * Created by tro on 4/08/2015.
 */
package com.tro.chromecast.models.vos
{

	import starling.textures.Texture;

	public class DeviceTypeVo
	{
		public static const IOS : String = "IOS";
		public static const ANDROID : String = "Android";
		public static const MOBILE : String = "Mobile";
		public static const TABLET : String = "Tablet";
		public static const LAPTOP : String = "Laptop";

		public var texture:Texture;
		public var textureId:String;

		public var type:String;

		public function DeviceTypeVo()
		{

		}
	}
}
