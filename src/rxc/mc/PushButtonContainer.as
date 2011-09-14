package rxc.mc
{
	import reflex.behaviors.ButtonBehavior;
	import reflex.binding.DataChange;
	import reflex.components.Component;
	
	import rxc.mc.behaviors.PushButtonBehavior;
	import rxc.mc.skins.PushButtonContainerSkin;
	
	[DefaultProperty("content")]
	public class PushButtonContainer extends Component
	{
		private var _icon:Object;
		private var _content:Object;
		private var _selected:Boolean;
		private var _toggle:Boolean;
		
		[Bindable(event="iconChange")]
		public function get icon():Object { return _icon; }
		public function set icon(value:Object):void {
			DataChange.change(this, "icon", _icon, _icon = value);
		}
		
		[Bindable(event="contentChange")]
		public function get content():Object { return _content; }
		public function set content(value:Object):void {
			DataChange.change(this, "content", _content, _content = value);
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
		
		public function PushButtonContainer()
		{
			super();
			this.behaviors.addItem( new ButtonBehavior(this))
			this.behaviors.addItem( new PushButtonBehavior(this))
			this.skin = new PushButtonContainerSkin()
		}
	}
}