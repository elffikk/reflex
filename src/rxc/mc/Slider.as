package rxc.mc
{
	import flash.events.Event;
	
	import reflex.binding.DataChange;
	import reflex.components.Component;
	
	import rxc.mc.behaviors.SliderBehavior;
	import rxc.mc.skins.SliderSkin;
	
	[Event(name="valueChange", type="flash.events.Event")]
	public class Slider extends Component
	{
		public static const HORIZONTAL:String = "horizontal";
		public static const VERTICAL:String = "vertical";
		
		private var _value:Number=0;
		[Bindable(event="valueChange")]
		public function get value():Number { return Math.round(_value / _tick) * _tick; }
		public function set value(v:Number):void {
			DataChange.change(this, "value", _value, _value = v);
		}
		
		[Bindable(event="valueChange")]
		public function get rawValue():Number{return _value;}
		
		private var _minimum:Number=0;
		[Bindable(event="minimumChange")]
		public function get minimum():Number { return _minimum; }
		public function set minimum(value:Number):void {
			DataChange.change(this, "minimum", _minimum, _minimum = value);
		}
		
		private var _maximum:Number=100;
		[Bindable(event="maximumChange")]
		public function get maximum():Number { return _maximum; }
		public function set maximum(value:Number):void {
			DataChange.change(this, "maximum", _maximum, _maximum = value);
		}
		
		private var _tick:Number=0.01;
		[Bindable(event="tickChange")]
		public function get tick():Number { return _tick; }
		public function set tick(v:Number):void {
			DataChange.change(this, "tick", _tick, _tick = value);
		}
		
		private var _direction:String="horizontal";
		[Bindable(event="directionChange")]
		public function get direction():String { return _direction; }
		public function set direction(value:String):void {
			DataChange.change(this, "direction", _direction, _direction = value);
		}
		
		[Commit(properties="value,minimum,maximum")]
		public function onValueChange(event:Event):void
		{
			correctValue()
		}
		
		/**
		 * Utils
		 */
		protected function correctValue():void
		{
			if(_maximum > _minimum)
			{
				_value = Math.min(_value, _maximum);
				_value = Math.max(_value, _minimum);
			}
			else
			{
				_value = Math.max(_value, _maximum);
				_value = Math.min(_value, _minimum);
			}
		}
		
		
		public function Slider()
		{
			super();
			this.behaviors = new SliderBehavior(this)
			this.skin = new SliderSkin()
			this.setSize(100, 10)
		}
	}
}