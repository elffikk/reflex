package rxc.mc.behaviors
{
	
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	import reflex.behaviors.Behavior;
	import reflex.behaviors.IBehavior;
	import reflex.binding.DataChange;

	public class PushButtonBehavior extends Behavior implements IBehavior
	{
		private var _selected:Boolean = false;
		private var _toggle:Boolean = false;
		
		
		[Bindable(event="selectedChange")]
		[Binding(target="target.selected")]
		public function get selected():Boolean { return _selected; }
		public function set selected(value:Boolean):void {
			DataChange.change(this, "selected", _selected, _selected = value);
		}
		
		[Bindable(event="toggleChange")]
		[Binding(target="target.toggle")]
		public function get toggle():Boolean {return _toggle; }
		public function set toggle(value:Boolean):void {
			DataChange.change(this, "toggle", _toggle, _toggle = value);
		}
		
		public function PushButtonBehavior(target:IEventDispatcher = null) {
			super(target);
		}
		
		// ====== Event Listeners ====== //		
		
		[EventListener(event="click", target="target")]
		public function onClick(event:MouseEvent):void
		{
			selected = toggle && !selected
		}
		
	}
}