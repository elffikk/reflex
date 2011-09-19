package reflex.rxg
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import mx.graphics.SolidColor;
	
	import reflex.binding.DataChange;
	import reflex.display.BitmapDisplay;
	import reflex.display.Display;
	import reflex.invalidation.Invalidation;
	import reflex.measurement.resolveHeight;
	import reflex.measurement.resolveWidth;
	import reflex.metadata.resolveCommitProperties;
	import reflex.metadata.resolveEventListeners;
	
	import reflex.rxg.Rect;
	
	[Style(name="left")]
	[Style(name="right")]
	[Style(name="top")]
	[Style(name="bottom")]
	[Style(name="horizontalCenter")]
	[Style(name="verticalCenter")]
	[Style(name="dock")]
	[Style(name="align")]
	
	[Event(name="complete", type="flash.events.Event")]
	public class Image extends Display
	{
		Invalidation.registerPhase('draw')
		
		static public const BEST_FIT:String = "bestFit";
		static public const BEST_FILL:String = "bestFill";
		static public const HORIZONTAL_FIT:String = "horizontalFit";
		static public const VERTICAL_FIT:String = "verticalFit";
		static public const SKEW:String = "skew";
		static public const NONE:String = "none";
		
		private var loader:Loader;				
		private var _source:Object;
		private var _scaling:String = NONE;
		private var _backgroundColor:uint = 0xFFFFFF;
		private var _backgroundAlpha:Number = 0;
				
		private var _content:DisplayObject;
		[Bindable(event="contentChange")]
		public function get content():DisplayObject { return _content; }
		public function set content(value:DisplayObject):void {
			DataChange.change(this, "content", _content, _content = value);
		}
		
		private var _contentWidth:Number=0;
		[Bindable(event="contentWidthChange")]
		public function get contentWidth():Number { return _contentWidth; }
		public function set contentWidth(value:Number):void {
			DataChange.change(this, "contentWidth", _contentWidth, _contentWidth = value);
		}
		
		private var _contentHeight:Number=0;
		[Bindable(event="contentHeightChange")]
		public function get contentHeight():Number { return _contentHeight; }
		public function set contentHeight(value:Number):void {
			DataChange.change(this, "contentHeight", _contentHeight, _contentHeight = value);
		}
		
		private var _smoothing:Boolean=true;
		[Bindable(event="smoothingChange")]
		public function get smoothing():Boolean { return _smoothing; }
		public function set smoothing(value:Boolean):void {
			DataChange.change(this, "smoothing", _smoothing, _smoothing = value);
		}
		
		private var _loaded:Boolean;
		[Bindable(event="loadedChange")]
		public function get loaded():Boolean { return _loaded; }
		public function set loaded(value:Boolean):void {
			DataChange.change(this, "loaded", _loaded, _loaded = value);
		}
		
		[Bindable(event="sourceChange")]
		public function get source():Object { return _source; }
		public function set source(value:Object):void {
			DataChange.change(this, "source", _source, _source = value);
		}
		
		[Bindable(event="scalingChanged")]
		public function get scaling():String { return _scaling; }
		public function set scaling(value:String):void {
			DataChange.change(this, "scaling", _scaling, _scaling = value);
		}
		
		[Bindable(event="backgroundColorChanged")]
		public function get backgroundColor():uint { return _backgroundColor; }
		public function set backgroundColor(value:uint):void {
			DataChange.change(this, "backgroundColor", _backgroundColor, _backgroundColor = value);
		}
		
		[Bindable(event="backgroundAlphaChanged")]
		public function get backgroundAlpha():Number { return _backgroundAlpha; }
		public function set backgroundAlpha(value:Number):void {
			DataChange.change(this, "backgroundAlpha", _backgroundAlpha, _backgroundAlpha = value);
		}
		
		public function Image()
		{
			super();
			measured.width = 0
			measured.height = 0
			addEventListener('draw', draw)
			reflex.metadata.resolveCommitProperties(this, resolve);
		}
		
		/**
		 * @private
		 */
		[Commit(properties="source")]
		public function onSourceChanged(event:Event):void {
			loaded = false
			if (loader!=null){
				try{
					loader.close()
				}
				catch(err:Error){						
				}
			}
			mask=null
			while (numChildren>0){
				removeChildAt(0)
			}
			if (source is String) {				
				var request:URLRequest = new URLRequest(source as String);
				loader = new Loader();
				loader.load(request, new LoaderContext(true));
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete, false, 0, true);
			} else if (source is Class) {
				content = new (source as Class)();
			}
			else if (source is BitmapData) {
				var d:Shape = new Shape()
				d.width = source.width
				d.height = source.height
				d.graphics.beginBitmapFill(source as BitmapData)
				d.graphics.endFill()
				content = d
			}
			else if (source is DisplayObject)
			{
				content = source as DisplayObject
			}
			else if (source is ByteArray){
				loader = new Loader()
				loader.loadBytes(source as ByteArray)
				loader.contentLoaderInfo.addEventListener(Event.INIT, onComplete, false, 0, true);
			}
		}
		
		private function onComplete(event:Event):void {
			content = loader.content			
		}
		
		[Commit(properties="content")]
		public function onContentChanged(ev:Event):void
		{
			loaded = true			
			measured.width = content.width;
			measured.height = content.height;			
			Invalidation.invalidate(this, 'draw')
			dispatchEvent(new Event("complete"))
		}
		
		/**
		 * @private
		 */
		[Commit(properties="width,height,scaling,backgroundColor,backgroundAlpha")]
		public function onSizeChange(event:Event):void {			
			Invalidation.invalidate(this, 'draw')
		}
		
		[Commit(properties="scaling")]
		public function onScalingChange(event:Event):void {
			try{
				removeChild(mask)
			}
			catch(err:Error){
			}
			mask = null			
		}
		
		public function draw(ev:Event = null):void {
			if (content) {				
				try{
					var index:Number = getChildIndex(content) //raises error if it is not child
				}
				catch(err:Error){
					addChild(content)
				}
				if (content is Bitmap){
					(content as Bitmap).smoothing = smoothing;
				}
				
				var w:Number = resolveWidth(this)
				var h:Number = resolveHeight(this)
				content.x = content.y = 0
				if (scaling == BEST_FILL){
					content.scaleX = content.scaleY = Math.max(h/content.height, w/content.width);
					
					if (mask == null){
						var rect:Rect = new Rect()
						rect.fill = new SolidColor(0xffffff, 0.01)
						rect.percentWidth = 100
						rect.percentHeight = 100
						addChild(rect)
						mask = rect
					}
					mask.width = w
					mask.height = h
					
					//scrollRect = new Rectangle(0, 0, w, h)
				}
				else if (scaling == SKEW){
					content.scaleY = h/content.height
					content.scaleX = w/content.width
				}
				else if (scaling == BEST_FIT){ 
					content.scaleX = content.scaleY = Math.min(h/content.height, w/content.width);
					content.x = (w - content.width)/2
					content.y = (h - content.height)/2
				}
				contentWidth = content.width;
				contentHeight = content.height;
				
			}
		}
		
		private function resolve(m:String):* {
			var t:* = this[m];
			return t;
		}
		
	}
}