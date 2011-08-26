package rxc.mc.behaviors
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import reflex.behaviors.Behavior;
	import reflex.binding.DataChange;
	
	import rxc.mc.Slider;
	
	public class SliderBehavior extends Behavior
	{
		
		private var _dragging:Boolean;
		
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
		
		private var _direction:String="horizontal";
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
		
		
		public function SliderBehavior(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		
		/**
		 * Event handlers
		 */
		[EventListener(event="press", target="thumb")]
		public function onThumbDragStart(event:Event):void
		{
			_dragging = true
			var w:Number = (target as Object).width
			var h:Number = (target as Object).height
			if(_direction == Slider.HORIZONTAL)
			{
				thumb.startDrag(false, new Rectangle(0, 0, w - h, 0));
			}
			else
			{
				thumb.startDrag(false, new Rectangle(0, 0, 0, h - w));
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
			var w:Number = (target as Object).width
			var h:Number = (target as Object).height
			var ratio:Number;
			if(_direction == Slider.HORIZONTAL)
			{
				ratio = event.localX  / (track.width - thumb.width-2)	
			}
			else
			{
				ratio = event.localY  / (track.height - thumb.height-2)
			}
			ratio = Math.max(0, Math.min(1, ratio))
			value = _minimum + ratio * (_maximum - _minimum)
		}
		
		[EventListener(event="drag", target="thumb")]
		public function oDrag(event:Event):void
		{			
			var w:Number = (target as Object).width
			var h:Number = (target as Object).height
			var ratio:Number;
			if(_direction == Slider.HORIZONTAL)
			{
				ratio = thumb.x  / (track.width - thumb.width-2)	
			}
			else
			{
				ratio = thumb.y  / (track.height - thumb.height-2)
			}
			ratio = Math.max(0, Math.min(1, ratio))
			value = _minimum + ratio * (_maximum - _minimum)
		}
		
		[EventListener(event="valueChange", target="target")]
		public function onValueChange(event:Event):void
		{
			if (_dragging) return;
			var w:Number = (target as Object).width
			var h:Number = (target as Object).height
			var range:Number;
			if(_direction == Slider.HORIZONTAL)
			{
				range = w - h;
				thumb.x = (_value - _minimum) / (_maximum - _minimum) * range;
			}
			else
			{
				range = h - w;
				thumb.y = h - w - (_value - _minimum) / (_maximum - _minimum) * range;
			}
		}
		
	}
}