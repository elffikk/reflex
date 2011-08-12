package reflex.components
{
	
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import mx.controls.TextInput;
	import mx.core.UIComponent;
	import mx.core.UITextField;
	import mx.managers.FocusManager;
	import mx.managers.IFocusManagerComponent;
	
	import reflex.behaviors.SimpleTextInputBehavior;
	import reflex.binding.Bind;
	import reflex.binding.DataChange;
	import reflex.skins.SimpleTextInputSkin;
	import reflex.text.TextFieldDisplay;
	
	[Style(name="paddingTop")]
	[Style(name="paddingRight")]
	[Style(name="paddingBottom")]
	[Style(name="paddingLeft")]
	[Style(name="backgroundColor")]
	[Style(name="borderColor")]
	[Style(name="borderThickness")]
	
	[Style(name="rxFontFamily")]
	[Style(name="rxColor")]
	[Style(name="rxFontWeight")]
	[Style(name="rxFontSize")]
	
	[Event(name="change", type="flash.events.Event")]
	public class SimpleTextInput extends Component
	{
		
		protected var _text:String = '';
		
		public function SimpleTextInput()
		{
			super();
			
			setStyle("backgroundColor", 0xFFFFFF);
			setStyle("borderColor", 0xCCCCCC);
			setStyle("paddingTop", 2);
			setStyle("paddingRight", 2);
			setStyle("paddingBottom", 2);
			setStyle("paddingLeft", 2);
			
			skin = new SimpleTextInputSkin();
			
			Bind.addBinding(this, "skin.textField.text", this, "text");
			
			Bind.addBinding(this, "skin.backgroundColor", this, "style.backgroundColor");
			Bind.addBinding(this, "skin.borderColor", this, "style.borderColor");
			Bind.addBinding(this, "skin.borderThickness", this, "style.borderThickness");
			Bind.addBinding(this, "skin.fontFamily", this, "style.rxFontFamily");
			Bind.addBinding(this, "skin.fontSize", this, "style.rxFontSize");
			Bind.addBinding(this, "skin.fontWeight", this, "style.rxFontWeight");
			Bind.addBinding(this, "skin.color", this, "style.rxColor");
		
			Bind.addBinding(this, "skin.textField.style.top", this, "style.paddingTop");
			Bind.addBinding(this, "skin.textField.style.right", this, "style.paddingRight");
			Bind.addBinding(this, "skin.textField.style.bottom", this, "style.paddingBottom");
			Bind.addBinding(this, "skin.textField.style.left", this, "style.paddingLeft");
			
			behaviors.addItem(new SimpleTextInputBehavior(this));
			
		}
		
		[Bindable("textChange")]
		public function get text():String { return _text; }
		public function set text(value:String):void {
			DataChange.change(this, "text", _text, _text = value);
		}
		
		public function setFocus():void {
			this.stage.focus = this.skin.textField;
		}
		
		
	}
}