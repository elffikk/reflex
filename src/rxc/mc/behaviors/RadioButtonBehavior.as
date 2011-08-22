package rxc.mc.behaviors
{
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	import reflex.behaviors.Behavior;
	import reflex.binding.DataChange;
	import reflex.collections.SimpleCollection;
	
	public class RadioButtonBehavior extends Behavior
	{
		
		protected static var buttons:SimpleCollection=new SimpleCollection();
		
		private var _selected:Boolean;
		private var _groupName:String="defaultGroup";
		
		
		[Bindable(event="selectedChange")]
		[Binding(target="target.selected")]
		[Inspectable(name="Selected", type=Boolean, defaultValue=false)]
		public function get selected():Boolean {return _selected; }
		public function set selected(value:Boolean):void {
			DataChange.change(this, "selected", _selected, _selected = value);
		}
		
		[Bindable(event="groupNameChange")]
		[Binding(target="target.groupName")]
		[Inspectable(name="GroupName", type=String, defaultValue=false)]
		public function get groupName():String {return _groupName; }
		public function set groupName(value:String):void {
			DataChange.change(this, "groupName", _groupName, _groupName = value);
		}
				
		override public function set target(value:IEventDispatcher):void
		{
			if (target) buttons.removeItemAt(buttons.getItemIndex(target))
			super.target = value
			if (value)buttons.addItem(this)	
		}
		
		
		public function RadioButtonBehavior(target:IEventDispatcher=null)
		{
			super(target);
			if (target)buttons.addItem(this)
		}
		
		/**
		 * Event handlers
		 */		
		[EventListener(event="click", target="target")]
		public function onClick(event:MouseEvent):void
		{
			clear(this)
			selected = true
		}
		
		
		/**
		 *  Private
		 */
		protected static function clear(rb:Object):void
		{
			for(var i:uint = 0; i < buttons.length; i++)
			{
				var btn:Object = buttons.getItemAt(i)
				if(btn != rb && btn.groupName == rb.groupName)
				{
					btn.selected = false;
				}
			}
		}
	}
}