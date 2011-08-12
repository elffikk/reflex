package reflex.rxg
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import reflex.binding.DataChange;
	import reflex.components.Component;
	
	import reflex.rxg.skins.RasterTextSkin;
	

	public class RasterText extends Component
	{
		public function RasterText()
		{
			cacheAsBitmap = true //important! without this will not work
			skin = new RasterTextSkin()
		}
		
		/**
		 * Text properties 
		 */
		
		
		private var _text:String = "Label";
		[Bindable(event="textChange")]
		public function get text():String{ return _text;}
		public function set text(value:String):void
		{
			DataChange.change(this, "text", _text, _text=value);
		}
		
		private var _fontFamily:String = "Arial";
		[Bindable(event="fontFamilyChange")]
		public function get fontFamily():String{ return _fontFamily;}
		public function set fontFamily(value:String):void{
			DataChange.change(this, "fontFamily", _fontFamily, _fontFamily=value);
		}
		
		private var _fontSize:Number = 12;
		[Bindable(event="fontSizeChange")]
		public function get fontSize():Number{ return _fontSize;}
		public function set fontSize(value:Number):void{
			DataChange.change(this, "fontSize", _fontSize, _fontSize=value);
		}
		
		private var _bold:Boolean;
		[Bindable(event="boldChange")]
		public function get bold():Boolean{ return _bold;}
		public function set bold(value:Boolean):void
		{
			DataChange.change(this, "bold", _bold, _bold=value);
		}
		
		private var _italic:Boolean;
		[Bindable(event="italicChange")]
		public function get italic():Boolean{ return _italic;}
		public function set italic(value:Boolean):void
		{
			DataChange.change(this, "italic", _italic, _italic=value);
		}
		
		
		/**
		 * Fill and stroke 
		 */
		
		private var _fill:*;
		[Bindable(event="fillChange")]
		public function get fill():* { return _fill; }
		public function set fill(value:*):void {
			DataChange.change(this, "fill", _fill, _fill = value);			
		}
		
	}
}