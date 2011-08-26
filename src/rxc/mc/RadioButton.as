package rxc.mc
{
	import reflex.behaviors.ButtonBehavior;
	import reflex.binding.DataChange;
	import reflex.components.Component;
	
	import rxc.mc.behaviors.RadioButtonBehavior;
	import rxc.mc.skins.RadioButtonSkin;
	
	public class RadioButton extends Component
	{
		
		private var _label:String;
		private var _selected:Boolean;
		private var _groupName:String;
		
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
		
		[Bindable(event="groupNameChange")]
		[Inspectable(name="GroupName", type=String, defaultValue="defaultGroup")]
		public function get groupName():String {return _groupName; }
		public function set groupName(value:String):void {
			DataChange.change(this, "groupName", _groupName, _groupName = value);
		}
		
		public function RadioButton()
		{
			super();
			this.behaviors.addItem( new ButtonBehavior(this))
			this.behaviors.addItem( new RadioButtonBehavior(this))
			this.skin = new RadioButtonSkin()
		}
	}
}