package com.tro.chromecast.views.components 
{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.utils.HAlign;
	/**
	 * ...
	 * @author Andrew Day
	 */
	public class SwipeToContinue extends Sprite 
	{
		private var _titleField:TextField;
		private var _arrowTextField:TextField;
		public function SwipeToContinue() 
		{
			initTextFields();
		}
		
		private function initTextFields():void 
		{
			_titleField = new TextField(1,1, "");
			_titleField.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			_titleField.hAlign = HAlign.CENTER;
			_titleField.fontName = "Roboto";
			_titleField.fontSize = 50;
			_titleField.color = 0x656666;
			_titleField.touchable = false;
			_titleField.text = "Swipe to continue ";
			
			_arrowTextField = new TextField(1,1, "");
			_arrowTextField.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			_arrowTextField.hAlign = HAlign.CENTER;
			_arrowTextField.fontName = "Roboto";
			_arrowTextField.fontSize = 50;
			_arrowTextField.color = 0x3369E8;
			_arrowTextField.touchable = false; 
			_arrowTextField.text = "»";
			
			_arrowTextField.x = _titleField.x + _titleField.width + 10;
			_arrowTextField.y = 2;
			
			addChild(_titleField);
			addChild(_arrowTextField);
		}
		
		public function get titleField():TextField 
		{
			return _titleField;
		}
		
		public function set titleField(value:TextField):void 
		{
			_titleField = value;
		}
	}
}