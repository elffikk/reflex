package rxc.mc.behaviors
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;
	
	import reflex.behaviors.Behavior;
	import reflex.binding.DataChange;
	import reflex.metadata.resolveCommitProperties;
	
	import rxc.mc.ScrollBar;
	
	public class ScrollBarBehavior extends Behavior
	{
		private var _dragging:Boolean = false;
		
		/**
		 * Component properties
		 */
		private var _value:Number;
		[Bindable(event="valueChange")]
		[Binding(target="target.value")]
		public function get value():Number { return _value; }
		public function set value(v:Number):void {
			DataChange.change(this, "value", _value, _value = v);
		}		
		
		private var _minimum:Number;
		[Bindable(event="minimumChange")]
		[Binding(target="target.minimum")]
		public function get minimum():Number { return _minimum; }
		public function set minimum(value:Number):void {
			DataChange.change(this, "minimum", _minimum, _minimum = value);
		}
		
		private var _maximum:Number;
		[Bindable(event="maximumChange")]
		[Binding(target="target.maximum")]
		public function get maximum():Number { return _maximum; }
		public function set maximum(value:Number):void {
			DataChange.change(this, "maximum", _maximum, _maximum = value);
		}
		
		private var _stepSize:Number;
		[Bindable(event="stepSizeChange")]
		[Binding(target="target.stepSize")]
		public function get stepSize():Number { return _stepSize; }
		public function set stepSize(value:Number):void {
			DataChange.change(this, "stepSize", _stepSize, _stepSize = value);
		}
		
		private var _pageSize:Number;
		[Bindable(event="pageSizeChange")]
		[Binding(target="target.pageSize")]
		public function get pageSize():Number { return _pageSize; }
		public function set pageSize(value:Number):void {
			DataChange.change(this, "pageSize", _pageSize, _pageSize = value);
		}
		
		private var _thumbPercent:Number;
		[Bindable(event="thumbPercentChange")]
		[Binding(target="target.thumbPercent")]
		public function get thumbPercent():Number { return _thumbPercent; }
		public function set thumbPercent(value:Number):void {
			DataChange.change(this, "thumbPercent", _thumbPercent, _thumbPercent = value);
		}
		
		
		private var _direction:String;
		[Bindable(event="directionChange")]
		[Binding(target="target.direction")]
		public function get direction():String { return _direction; }
		public function set direction(value:String):void {
			DataChange.change(this, "direction", _direction, _direction = value);
		}	
		
		/**
		 * Skin parts
		 */
		private var _thumb:Sprite;		
		[Bindable(event="thumbChange")]
		[Binding(target="target.skin.thumb")]
		public function get thumb():Sprite { return _thumb; }
		public function set thumb(value:Sprite):void {
			DataChange.change(this, "thumb", _thumb, _thumb = value);
		}
		
		private var _track:Sprite;		
		[Bindable(event="trackChange")]
		[Binding(target="target.skin.track")]
		public function get track():Sprite { return _track; }
		public function set track(value:Sprite):void {
			DataChange.change(this, "track", _track, _track = value);
		}
		
		private var _incrementButton:Sprite;		
		[Bindable(event="incrementButtonChange")]
		[Binding(target="target.skin.incrementButton")]
		public function get incrementButton():Sprite { return _incrementButton; }
		public function set incrementButton(value:Sprite):void {
			DataChange.change(this, "incrementButton", _incrementButton, _incrementButton = value);
		}
		
		private var _decrementButton:Sprite;		
		[Bindable(event="decrementButtonChange")]
		[Binding(target="target.skin.decrementButton")]
		public function get decrementButton():Sprite { return _decrementButton; }
		public function set decrementButton(value:Sprite):void {
			DataChange.change(this, "decrementButton", _decrementButton, _decrementButton = value);
		}
		
		
		public function ScrollBarBehavior(target:IEventDispatcher=null)
		{
			super(target);
			resolveCommitProperties(this)
		}
		
		/**
		 * Event handlers
		 */		
		
		[EventListener(event="press", target="thumb")]
		public function onThumbDragStart(event:Event):void
		{
			_dragging = true
			if(direction == "horizontal")
			{
				thumb.startDrag(false, new Rectangle(track.x, track.y, track.width - thumb.width, 0));
			}
			else
			{
				thumb.startDrag(false, new Rectangle(track.x, track.y, 0, track.height - thumb.height));
			}			
		}
		
		
		[EventListener(event="release", target="thumb")]
		[EventListener(event="releaseOutside", target="thumb")]
		public function onThumbDragStop(event:Event):void
		{			
			_dragging = false
			thumb.stopDrag()
		}
		
		
		[EventListener(event="click", target="track")]
		public function onTrackClick(event:MouseEvent):void
		{			
			updateValue(event.localX, event.localY)
		}
		
		[EventListener(event="drag", target="thumb")]
		public function onDrag(event:Event):void
		{			
			updateValue(thumb.x, thumb.y)
		}
		
		[Commit(properties="value,minimum,maximum,stepSize,thumbPercent,width,height,skin", target="target")]
		public function onValueChange(event:Event):void
		{
			if (_dragging) return;
			//ugly solution
			//to fix adding events to component and/or skin like creationComplete, etc 
			(target as Sprite).stage.addEventListener(Event.ENTER_FRAME, onFixPosition)		
		}
		
		[EventListener(event="press", target="decrementButton")]
		[EventListener(event="hold", target="decrementButton")]
		public function onDecrement(event:Event):void
		{			
			value = Math.max(minimum, value - stepSize)
		}
		
		[EventListener(event="press", target="incrementButton")]
		[EventListener(event="hold", target="incrementButton")]
		public function onIncrement(event:Event):void
		{			
			value = Math.min(maximum, value + stepSize)			
		}
		
		
		/**
		 * Private
		 */
		protected function onFixPosition(event:Event):void
		{
			if (thumb && track){
				(target as Sprite).stage.removeEventListener(Event.ENTER_FRAME, onFixPosition)
				positionHandle()
			}
		}
		
		protected function positionHandle():void
		{
			var range:Number;
			if(direction == ScrollBar.HORIZONTAL)
			{
				thumb.width = Math.min(Math.max(thumbPercent * track.width, track.height), track.width)
				range = track.width - thumb.width;				
				thumb.x = track.x + (value - minimum) / (maximum - minimum) * range;
			}
			else
			{
				thumb.height = Math.min(Math.max(thumbPercent * track.height, track.width), track.height)
				range =  track.height - thumb.height;
				thumb.y = track.y + (value - minimum) / (maximum - minimum) * range;
			}
		}
		
		protected function updateValue(_x:Number, _y:Number):void
		{
			var ratio:Number;
			if(direction == ScrollBar.HORIZONTAL)
			{
				ratio = (_x - track.x)  / (track.width - thumb.width-2)	
			}
			else
			{
				ratio = (_y - track.y)  / (track.height - thumb.height)
			}
			ratio = Math.max(0, Math.min(1, ratio))
			value = minimum + ratio * (maximum - minimum)
		}
		
	}
}