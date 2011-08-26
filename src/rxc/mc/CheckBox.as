package rxc.mc
{
	import reflex.behaviors.ButtonBehavior;
	import reflex.behaviors.SelectBehavior;
	import reflex.binding.DataChange;
	import reflex.components.Component;
	
	import rxc.mc.skins.CheckBoxSkin;
	
	public class CheckBox extends Component
	{
		
		private var _label:String;
		private var _selected:Boolean;
		private var _toggle:Boolean;
		
		[Bindable(event="labelChange")]
		[Inspectable(name="Label", type=String, defaultValue="Label")]
		public function get label():String { return _label; }
		public function set label(value:String):void {
			DataChange.change(this, "label", _label, _label = value);
		}
		
		[Bindable(event="selectedChange")]
		[Inspectable(name="Selected", type=Boolean, defaultValue=false)]
		public function get selected():Boolean {return _selected; }
		public function set selected(value:Boolean):void {
			DataChange.change(this, "selected", _selected, _selected = value);
		}		
		
		public function CheckBox()
		{
			super();
			this.behaviors.addItem( new ButtonBehavior(this))
			this.behaviors.addItem( new SelectBehavior(this))
			this.skin = new CheckBoxSkin()
		}
	}
}