package rxc.mc
{
	import flash.events.Event;
	
	import reflex.binding.DataChange;
	import reflex.components.Component;
	
	import rxc.mc.behaviors.RangeSliderBehavior;
	import rxc.mc.skins.RangeSliderSkin;
	
	public class RangeSlider extends Component
	{
		
		public static const HORIZONTAL:String = "horizontal";
		public static const VERTICAL:String = "vertical";
		
		private var _lowValue:Number=0;
		[Bindable(event="lowValueChange")]
		public function get lowValue():Number { return Math.round(_lowValue / _tick) * _tick; }
		public function set lowValue(v:Number):void {
			DataChange.change(this, "lowValue", _lowValue, _lowValue = v);
		}
		
		private var _highValue:Number=100;
		[Bindable(event="highValueChange")]
		public function get highValue():Number { return Math.round(_highValue / _tick) * _tick; }
		public function set highValue(v:Number):void {
			DataChange.change(this, "highValue", _highValue, _highValue = v);
		}
		
		
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
		public function set tick(value:Number):void {
			DataChange.change(this, "tick", _tick, _tick = value);
		}
		
		private var _direction:String=HORIZONTAL;
		[Bindable(event="directionChange")]
		public function get direction():String { return _direction; }
		public function set direction(value:String):void {
			DataChange.change(this, "direction", _direction, _direction = value);
		}
		
		public function RangeSlider()
		{
			super();
			this.skin = new RangeSliderSkin()
			this.behaviors = new RangeSliderBehavior(this)
			width = 100
			height = 10
		}
	}
}