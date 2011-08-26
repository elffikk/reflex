package rxc.mc.behaviors
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	import reflex.behaviors.Behavior;
	import reflex.binding.DataChange;
	
	public class RadioButtonBehavior extends Behavior
	{
		
		protected static var _selections:Object=new Object();
		
		private var _selected:Boolean;
		[Bindable(event="selectedChange")]
		[Binding(target="target.selected")]
		public function get selected():Boolean {return _selected; }
		public function set selected(value:Boolean):void {
			DataChange.change(this, "selected", _selected, _selected = value);
		}
		
		private var _groupName:String="defaultGroup";
		[Bindable(event="groupNameChange")]
		[Binding(target="target.groupName")]
		public function get groupName():String {return _groupName; }
		public function set groupName(value:String):void {
			DataChange.change(this, "groupName", _groupName, _groupName = value);
		}
		
		
		public function RadioButtonBehavior(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		/**
		 * Event handlers
		 */		
		[EventListener(event="selectedChange", target="target")]
		public function onChange(event:Event):void			
		{
			if (_selected){
				RadioButtonBehavior.setSelection(target)
			}
		}
		
		
		[EventListener(event="click", target="target")]
		public function onClick(event:MouseEvent):void
		{			
			selected = true
		}
		
		
		/**
		 *  Private
		 */
		protected static function setSelection(rb:Object):void
		{
			if (_selections[rb.groupName] != null && _selections[rb.groupName] != rb){
				_selections[rb.groupName].selected = false
				_selections[rb.groupName] = rb
			}
			else{
				_selections[rb.groupName] = rb
			}
		}
	}
}