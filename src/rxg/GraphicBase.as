package reflex.rxg
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.collections.IList;
	
	import reflex.binding.Bind;
	import reflex.binding.DataChange;
	import reflex.display.ShapeDisplay;
	import reflex.invalidation.Invalidation;
	import reflex.measurement.IMeasurable;
	import reflex.measurement.IMeasurements;
	import reflex.measurement.Measurements;
	import reflex.metadata.resolveBindings;
	import reflex.metadata.resolveCommitProperties;
	import reflex.metadata.resolveDataListeners;
	import reflex.metadata.resolveEventListeners;
	import reflex.styles.IStyleable;
	
	
	[Style(name="left")]
	[Style(name="right")]
	[Style(name="top")]
	[Style(name="bottom")]
	[Style(name="horizontalCenter")]
	[Style(name="verticalCenter")]	
	public class GraphicBase extends ShapeDisplay
	{
		static public const DRAW:String = "draw";
		Invalidation.registerPhase(DRAW, 0, true);
		
		public function GraphicBase()
		{			
			super()
			
			addEventListener(DRAW, onDraw, false, 0, true);
			
			resolveEventListeners(this)
			resolveCommitProperties(this)			
		}
		
		
		/**
		 * Invalidation
		 */
		public function invalidate():void
		{
			Invalidation.invalidate(this, DRAW)			
		}
				
		[Commit(target="x,y,width,height,fill,fill.color,fill.alpha,stroke,stroke.color,stroke.alpha,stroke.weight,fill.entries,stroke.entries")]		
		public function reDraw(event:Event):void {
			invalidate()
		}
		
		/**
		 * Bindable x, y
		 */
		
		[Bindable(event="xChange", noEvent)]
		override public function get x():Number { return super.x; }
		override public function set x(value:Number):void {
			DataChange.change(this, "x", super.x, super.x = value);
		}
		
		[Bindable(event="yChange", noEvent)]
		override public function get y():Number { return super.y; }
		override public function set y(value:Number):void {
			DataChange.change(this, "y", super.y, super.y = value);
		}
		
		
		
		/**
		 * Fill and stroke 
		 */
		
		private var _fill:*;
		private var _stroke:*;
		
		[Bindable(event="fillChange")]
		public function get fill():* { return _fill; }
		public function set fill(value:*):void {
			if (value){
				(value as EventDispatcher).addEventListener("propertyChange", reDraw)
			}
			DataChange.change(this, "fill", _fill, _fill = value);			
		}
		
		[Bindable(event="strokeChange")]
		public function get stroke():* { return _stroke; }
		public function set stroke(value:*):void {
			if (value){
				(value as EventDispatcher).addEventListener("propertyChange", reDraw)
			}
			DataChange.change(this, "stroke", _stroke, _stroke = value);
		}
		
		/**
		 * Draw
		 */
		
		private function onDraw(event:Event = null):void {
			if(width > 0 && height > 0) {
				graphics.clear()
				var rectangle:Rectangle = new Rectangle(0, 0, width, height);
				if(stroke){ 
					stroke.apply(graphics, rectangle, new Point()); 
				}
				if(fill){ 
					fill.begin(graphics, rectangle, new Point()); 
				}
				if (fill || stroke){
					draw()
				}
				if(fill){ 
					fill.end(graphics); 
				}
			}
		}
		
		public function draw():void {
			graphics.drawRect(0, 0, width, height);
		}
		
		
	}
}