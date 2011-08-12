package reflex.behaviors
{
	import reflex.components.SimpleTextInput;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import reflex.text.TextFieldDisplay;
	
	public class SimpleTextInputBehavior extends Behavior
	{
		public function SimpleTextInputBehavior(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		[Binding(target="target")]
		public var textInput:SimpleTextInput;
		
		[Binding(target="target.skin.textField")]
		public var textField:TextFieldDisplay;
		
		[EventListener(type="change", target="textField")]
		public function onChange(event:Event):void {
			trace("behavior change: "+ event.target.text);
			textInput.text = event.target.text;
			event.stopImmediatePropagation();
			target.dispatchEvent(event.clone());
		}
		
		
	}
}