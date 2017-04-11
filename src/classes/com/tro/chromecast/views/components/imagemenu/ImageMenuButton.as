/**
 * Created by tro on 10/08/2015.
 */
package com.tro.chromecast.views.components.imagemenu
{

	import com.tro.chromecast.views.components.*;

	import com.tro.chromecast.models.vos.ImageMenuButtonVo;

	import flash.filters.GlowFilter;

	import org.gestouch.events.GestureEvent;
	import org.gestouch.gestures.TapGesture;

	import starling.display.Image;

	import starling.display.Sprite;
	import starling.filters.BlurFilter;
	import starling.textures.Texture;

	public class ImageMenuButton extends Sprite
	{

		private var _data:ImageMenuButtonVo;
		private var _index:Number;
		private var tap:TapGesture;
		private var _image:Image;

		private var _selected:Boolean;

		public function ImageMenuButton()
		{
			super();
		}

		public function get data():ImageMenuButtonVo
		{
			return _data;
		}

		public function set data(value:ImageMenuButtonVo):void
		{
			_data = value;

			updateDisplayList();
		}

		public function enable():void
		{
			tap = new TapGesture(this);
			tap.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onTapHandler);
		}

		public function disable():void
		{
			tap.removeEventListener(GestureEvent.GESTURE_RECOGNIZED, onTapHandler);
			tap = null;
		}

		private function onTapHandler(event:GestureEvent):void
		{
			var evt:ImageMenuEvent = new ImageMenuEvent(ImageMenuEvent.ON_TAP, true);
			evt.vo = this.data;
			evt.index = this.index;
			dispatchEvent(evt);
		}

		private function updateDisplayList():void
		{
			_image = new Image(_data.texture);
			addChild(_image);
		}

		public function get selected():Boolean
		{
			return _selected;
		}

		public function set selected(value:Boolean):void
		{
			_selected = value;

			if (_selected)
			{
				//var bf:BlurFilter = BlurFilter.createGlow(0x259dad, 1, 36, 1);
				//this.filter = bf;
			}
			else
			{
				this.filter = null;
			}
		}

		public function get index():Number
		{
			return _index;
		}

		public function set index(value:Number):void
		{
			_index = value;
		}
		
		public function get image():Image 
		{
			return _image;
		}
		
		public function set image(value:Image):void 
		{
			_image = value;
		}
	}
}
