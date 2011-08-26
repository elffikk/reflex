package rxc.mc.behaviors
{
	import flash.display.InteractiveObject;
	import flash.events.IEventDispatcher;
	
	import reflex.behaviors.Behavior;
	import reflex.events.ButtonEvent;
	
	public class ButtonEventsBehavior extends Behavior
	{
		public function ButtonEventsBehavior(target:IEventDispatcher=null)
		{
			super(target);
			if (target) ButtonEvent.initialize(target as InteractiveObject)
		}
		
		override public function set target(value:IEventDispatcher):void
		{	
			if (target) ButtonEvent.deinitialize(target as InteractiveObject)
			if (value) ButtonEvent.initialize(value as InteractiveObject)
			super.target = value			
		}
	}
}