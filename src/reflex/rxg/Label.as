package reflex.rxg
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.engine.CFFHinting;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.FontLookup;
	import flash.text.engine.FontPosture;
	import flash.text.engine.FontWeight;
	import flash.text.engine.LineJustification;
	import flash.text.engine.RenderingMode;
	import flash.text.engine.SpaceJustifier;
	import flash.text.engine.TextBlock;
	import flash.text.engine.TextElement;
	import flash.text.engine.TextJustifier;
	import flash.text.engine.TextLine;
	import flash.text.engine.TextLineValidity;
	import flash.text.engine.TypographicCase;
	
	import reflex.binding.DataChange;
	import reflex.display.Display;
	import reflex.metadata.resolveCommitProperties;
	
	
	[Style(name="left")]
	[Style(name="right")]
	[Style(name="top")]
	[Style(name="bottom")]
	[Style(name="horizontalCenter")]
	[Style(name="verticalCenter")]
	[Style(name="dock")]
	[Style(name="align")]
	[Style(name="txtAlign", format="String", enumeration="left,right,center,justify")]
	[Style(name="verticalAlign")]
	public class Label extends Display
	{		
		
		public function Label(text:String = "")
		{
			mouseEnabled = false;
			mouseChildren = false;			
			this.text = text;
			
			resolveCommitProperties(this)
		}
		
		private var _text:String;
		[Bindable(event="textChange")]
		public function get text():String { return _text; }
		public function set text(value:String):void {
			if (value == _text) {
				return;
			}
			DataChange.change(this, "text", _text, _text = value);
		}
		
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
		
		[Commit(properties="text,embed,color,bold,italic,fontFamily,fontSize")]
		public function onTextRender(event:Event):void
		{
			while (numChildren > 0) removeChildAt(0)
							
			var textElement:TextElement = new TextElement(_text, new ElementFormat(new FontDescription(fontFamily, _bold?FontWeight.BOLD:FontWeight.NORMAL, _italic?FontPosture.ITALIC:FontPosture.NORMAL, _embed?FontLookup.EMBEDDED_CFF:FontLookup.DEVICE), _fontSize, _color));						
			var block:TextBlock = new TextBlock(textElement);
			var line:TextLine = block.createTextLine(null, stage.stageWidth);
			line.x=0
			line.y=line.ascent
			measured.width=line.width
			measured.height=line.height
			addChild(line)
		}		
		
	}
}