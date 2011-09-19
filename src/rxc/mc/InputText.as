package rxc.mc
{
	import reflex.binding.DataChange;
	import reflex.components.Component;
	
	import rxc.mc.skins.InputTextSkin;
	import rxc.mc.skins.Style;
	
	public class InputText extends Component
	{
		/**
		 * Properties from minimal comps
		 */
		private var _text:String;
		[Bindable(event="textChange")]
		public function get text():String { return _text; }
		public function set text(value:String):void {
			DataChange.change(this, "text", _text, _text = value);
		}
		
		private var _password:Boolean;
		[Bindable(event="passwordChange")]
		public function get password():Boolean { return _password; }
		public function set password(value:Boolean):void {
			DataChange.change(this, "password", _password, _password = value);
		}
		
		private var _maxChars:Number;
		[Bindable(event="maxCharsChange")]
		public function get maxChars():Number { return _maxChars; }
		public function set maxChars(value:Number):void {
			DataChange.change(this, "maxChars", _maxChars, _maxChars = value);
		}
		
		private var _restrict:String;
		[Bindable(event="restrictChange")]
		public function get restrict():String { return _restrict; }
		public function set restrict(value:String):void {
			DataChange.change(this, "restrict", _restrict, _restrict = value);
		}
		
		/**
		 * Label like properties
		 */		
		private var _embed:Boolean;
		[Bindable(event="embedChange")]
		public function get embed():Boolean {return _embed;}
		public function set embed(value:Boolean):void {
			DataChange.change(this, "embed", _embed, _embed=value);
		}
		
		private var _color:uint=0x000000;
		[Bindable(event="colorChange")]
		public function get color():uint { return _color; }
		public function set color(value:uint):void {
			if (value == _color) {
				return;
			}
			DataChange.change(this, "color", _color, _color = value);
		}
		
		private var _fontFamily:String="Arial";
		[Bindable(event="fontFamilyChange")]
		public function get fontFamily():String { return _fontFamily; }
		public function set fontFamily(value:String):void {
			if (value == _fontFamily) {
				return;
			}
			DataChange.change(this, "fontFamily", _fontFamily, _fontFamily = value);
		}
		
		private var _fontSize:Number=12;
		[Bindable(event="fontSizeChange")]
		public function get fontSize():Number { return _fontSize; }		
		public function set fontSize(value:Number):void {
			if (value == _fontSize) {
				return;
			}
			DataChange.change(this, "fontSize", _fontSize, _fontSize = value);
		}
		
		private var _bold:Boolean;
		[Bindable(event="boldChange")]
		public function get bold():Boolean {
			return _bold;
		}		
		public function set bold(value:Boolean):void {
			if (value == _bold) {
				return;
			}
			DataChange.change(this, "bold", _bold, _bold=value);
		}
		
		private var _italic:Boolean;
		[Bindable(event="italicChange")]
		public function get italic():Boolean {
			return _italic;
		}
		public function set italic(value:Boolean):void
		{
			if (value == _italic) {
				return;
			}
			DataChange.change(this, "italic", _italic, _italic = value);
		}
		
		public function InputText()
		{
			super();
			fontFamily = Style.fontName
			fontSize = Style.fontSize
			color = Style.INPUT_TEXT
			this.skin = new InputTextSkin()
			width = 100
			height = 16
		}
	}
}