package com.tro.chromecast.views.components 
{
	import starling.display.Sprite;
	import starling.display.Quad;
	
	/**
	 * ...
	 * @author David Armstrong
	 */
	public class Cable extends Sprite 
	{
		private var _chromecastPlug:Quad;
		private var _powerPlug:Quad;
		private var _cable:Quad;
		
		private var _plugWidth:Number;
		private var _plugHeight:Number;
		private var _defaultCableWidth:Number;
		private var _defaultCableHeight:Number;
		
		public function Cable() 
		{
			super();
			
			_chromecastPlug = new Quad(35, 25, 0x888888);
			addChild(_chromecastPlug);
			_chromecastPlug.pivotY = _chromecastPlug.height * 0.5;
			_plugWidth = _chromecastPlug.width;
			_plugHeight = _chromecastPlug.height;
			
			_powerPlug = new Quad(_plugWidth, _chromecastPlug.height, _chromecastPlug.color);
			addChild(_powerPlug);
			_powerPlug.pivotY = _powerPlug.height * 0.5;
			
			_cable = new Quad(150, 300, 0x888888);
			addChild(_cable);
			
			_powerPlug.y = _cable.height;			
			_cable.x = _powerPlug.width;
			_chromecastPlug.x = _cable.x + _cable.width;
			_cable.y = -(_plugHeight * 0.5);
			
			pivotX = width;
			
			_defaultCableWidth = width;
			_defaultCableHeight = height;
		}
		
		public function cableShift(newWidth:Number, newHeight:Number = -1, isDefault:Boolean = false):void
		{
			_cable.width = newWidth - (_plugWidth * 2);
			_chromecastPlug.x = _cable.x + _cable.width;
			
			if (newHeight != -1)
			{
				_cable.height = newHeight + _plugHeight;
				_powerPlug.y = newHeight;
			}
			
			if (isDefault)
			{
				_defaultCableWidth = newWidth;
				_defaultCableHeight = newHeight;
			}
			
			pivotX = width;
		}
		
		public function set color(newColour:uint):void
		{
			_chromecastPlug.color = newColour;
			_powerPlug.color = newColour;
			_cable.color = newColour;
		}
		
		public function get color():uint
		{
			return _chromecastPlug.color;
		}
		
		public function reset():void
		{
			cableShift(_defaultCableWidth, _defaultCableHeight);
		}
	}
}