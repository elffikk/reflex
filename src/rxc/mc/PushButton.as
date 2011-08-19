package rxc.mc
{
	import reflex.behaviors.ButtonBehavior;
	import reflex.binding.Bind;
	import reflex.binding.DataChange;
	import reflex.components.Component;
	
	import rxc.mc.behaviors.PushButtonBehavior;
	import rxc.mc.skins.PushButtonSkin;
	
	public class PushButton extends Component
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
		
		[Bindable(event="toggleChange")]
		[Inspectable(name="Toggle", type=Boolean, defaultValue=false)]
		public function get toggle():Boolean {return _toggle; }
		public function set toggle(value:Boolean):void {
			DataChange.change(this, "toggle", _toggle, _toggle = value);
		}
		
		public function PushButton()
		{
			super();
			this.buttonMode = true
			this.behaviors.addItem( new ButtonBehavior(this))
			this.behaviors.addItem( new PushButtonBehavior(this))
			this.skin = new PushButtonSkin()
			Bind.addBinding(this, 'skin.labelDisplay.text', this, 'label')
		}
	}
}