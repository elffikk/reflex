package rxc.mc
{
	import flash.events.Event;
	
	import reflex.binding.DataChange;
	import reflex.components.Component;
	
	import rxc.mc.behaviors.ScrollBarBehavior;
	import rxc.mc.skins.HScrollBarSkin;
	
	public class ScrollBar extends Component
	{
		public static const HORIZONTAL:String = "horizontal";
		public static const VERTICAL:String = "vertical";
		
		private var _value:Number=0;
		[Bindable(event="valueChange")]
		public function get value():Number { return _value; }
		public function set value(v:Number):void {
			DataChange.change(this, "value", _value, _value = v);
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
		
		private var _stepSize:Number=1;
		[Bindable(event="stepSizeChange")]
		public function get stepSize():Number { return _stepSize; }
		public function set stepSize(value:Number):void {
			DataChange.change(this, "stepSize", _stepSize, _stepSize = value);
		}
		
		private var _pageSize:Number=1;
		[Bindable(event="pageSizeChange")]
		public function get pageSize():Number { return _pageSize; }
		public function set pageSize(value:Number):void {
			DataChange.change(this, "pageSize", _pageSize, _pageSize = value);
		}
		
		private var _thumbPercent:Number=0.1;
		[Bindable(event="thumbPercentChange")]
		public function get thumbPercent():Number { return _thumbPercent; }
		public function set thumbPercent(value:Number):void {
			DataChange.change(this, "thumbPercent", _thumbPercent, _thumbPercent = value);
		}
		
		
		private var _direction:String="horizontal";
		[Bindable(event="directionChange")]
		public function get direction():String { return _direction; }
		public function set direction(value:String):void {
			DataChange.change(this, "direction", _direction, _direction = value);
		}
		
		public function ScrollBar()
		{
			super();
			//this.skin = new HScrollBarSkin()
			this.behaviors = new ScrollBarBehavior(this)
			//width = 110
			//height = 10
		}
		
		
	}
}