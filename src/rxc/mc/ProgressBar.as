package rxc.mc
{
	import reflex.binding.DataChange;
	import reflex.components.Component;
	
	import rxc.mc.skins.ProgressBarSkin;
	
	public class ProgressBar extends Component
	{
		
		private var _value:Number=0;
		[Bindable(event="valueChange")]
		public function get value():Number { return _value; }
		public function set value(v:Number):void {
			DataChange.change(this, "value", _value, _value = v);
		}
		
		private var _maximum:Number=1;
		[Bindable(event="maximumChange")]
		public function get maximum():Number { return _maximum; }
		public function set maximum(value:Number):void {
			DataChange.change(this, "maximum", _maximum, _maximum = value);
		}
		
		public function ProgressBar()
		{
			super();
			this.skin = new ProgressBarSkin()
			width = 100
			height = 10
		}
	}
}