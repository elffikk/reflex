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
	import reflex.metadata.resolveCommitProperties;
	
	import rxc.mc.Slider;
	
	public class RangeSliderBehavior extends Behavior
	{
		
		private var _dragging:Boolean;
		
		private var _lowValue:Number;
		[Bindable(event="lowValueChange")]
		[Binding(target="target.lowValue")]
		public function get lowValue():Number { return _lowValue; }
		public function set lowValue(v:Number):void {
			DataChange.change(this, "lowValue", _lowValue, _lowValue = v);
		}
		
		private var _highValue:Number;
		[Bindable(event="highValueChange")]
		[Binding(target="target.highValue")]
		public function get highValue():Number { return _highValue; }
		public function set highValue(v:Number):void {
			DataChange.change(this, "highValue", _highValue, _highValue = v);
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
		private var _thumb1:Sprite;
		[Bindable(event="thumb1Change")]
		[Binding(target="target.skin.thumb1")]
		public function get thumb1():Sprite { return _thumb1; }
		public function set thumb1(value:Sprite):void {
			DataChange.change(this, "thumb1", _thumb1, _thumb1 = value);
		}
		
		private var _thumb2:Sprite;
		[Bindable(event="thumb2Change")]
		[Binding(target="target.skin.thumb2")]
		public function get thumb2():Sprite { return _thumb2; }
		public function set thumb2(value:Sprite):void {
			DataChange.change(this, "thumb2", _thumb2, _thumb2 = value);
		}
		
		private var _track:Sprite;
		[Bindable(event="trackChange")]
		[Binding(target="target.skin.track")]
		public function get track():Sprite { return _track; }
		public function set track(value:Sprite):void {
			DataChange.change(this, "track", _track, _track = value);
		}
		
		
		public function RangeSliderBehavior(target:IEventDispatcher=null)
		{
			super(target);
			resolveCommitProperties(this)			
		}
		
		
		/**
		 * Event handlers
		 */
		
		[EventListener(event="press", target="thumb1")]
		public function onThumb1DragStart(event:Event):void
		{
			_dragging = true	
			var _width:Number = (target as Object).width
			var _height:Number = (target as Object).height
			if(direction == Slider.HORIZONTAL)
			{
				thumb1.startDrag(false, new Rectangle(0, 0, thumb2.x - _height, 0));
			}
			else
			{
				thumb1.startDrag(false, new Rectangle(0, thumb2.y + _width, 0, _height - thumb2.y - _width * 2));
			}
		}
		
		
		[EventListener(event="release", target="thumb1")]
		[EventListener(event="releaseOutside", target="thumb1")]
		public function onThumb1DragStop(event:Event):void
		{			
			_dragging = false
			thumb1.stopDrag()
		}
		
		[EventListener(event="press", target="thumb2")]
		public function onThumb2DragStart(event:Event):void
		{
			_dragging = true	
			var _width:Number = (target as Object).width
			var _height:Number = (target as Object).height
			if(direction == Slider.HORIZONTAL)
			{
				thumb2.startDrag(false, new Rectangle(thumb1.x + _height, 0, _width - _height - thumb1.x - _height, 0));
			}
			else
			{
				thumb2.startDrag(false, new Rectangle(0, 0, 0, thumb1.y - _width));
			}
		}
		
		
		[EventListener(event="release", target="thumb2")]
		[EventListener(event="releaseOutside", target="thumb2")]
		public function onThumb2DragStop(event:Event):void
		{			
			_dragging = false
			thumb2.stopDrag()
		}
		
		
		[EventListener(event="drag", target="thumb1")]		
		public function onThumb1Drag(event:MouseEvent):void
		{			
			updateMinValue(event.localX, event.localY)
		}
		
		[EventListener(event="drag", target="thumb2")]		
		public function onThumb2Drag(event:MouseEvent):void
		{			
			updateMaxValue(event.localX, event.localY)
		}
						
		
		[Commit(properties="lowValue,highValue,minimum,maximum,width,height",target="target")]
		public function onValueChange(event:Event):void
		{
			if (_dragging) return;
			positionHandles()
		}
		
		/**
		 * Private
		 */
		
		protected function positionHandles():void
		{
			var _width:Number = (target as Object).width
			var _height:Number = (target as Object).height
			var range:Number;
			if(direction == Slider.HORIZONTAL)
			{
				range = _width - _height * 2;
				thumb1.x = (_lowValue - _minimum) / (_maximum - _minimum) * range;
				thumb2.x = _height + (_highValue - _minimum) / (_maximum - _minimum) * range;
			}
			else
			{
				range = _height - _width * 2;
				thumb1.y = _height - _width - (_lowValue - _minimum) / (_maximum - _minimum) * range;
				thumb2.y = _height - _width * 2 - (_highValue - _minimum) / (_maximum - _minimum) * range;
			}
		}
		
		protected function updateMinValue(_x:Number, _y:Number):void
		{
			var _width:Number = (target as Object).width
			var _height:Number = (target as Object).height
			var oldValue:Number = _lowValue;
			if(direction == Slider.HORIZONTAL)
			{
				lowValue = thumb1.x / (_width - _height * 2) * (_maximum - _minimum) + _minimum;
			}
			else
			{
				lowValue = (_height - _width - thumb1.y) / (_height - _width * 2) * (_maximum - _minimum) + _minimum;
			}
		}
		
		protected function updateMaxValue(_x:Number, _y:Number):void
		{
			var _width:Number = (target as Object).width
			var _height:Number = (target as Object).height
			var oldValue:Number = _highValue;
			if(direction == Slider.HORIZONTAL)
			{
				highValue = (thumb2.x - _height) / (_width - _height * 2) * (_maximum - _minimum) + _minimum;
			}
			else
			{
				highValue = (_height - _width * 2 - thumb2.y) / (_height - _width * 2) * (_maximum - _minimum) + _minimum;
			}
		}
		
	}
}