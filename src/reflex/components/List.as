package reflex.components
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import reflex.behaviors.ListSelectionBehavior;
	import reflex.binding.Bind;
	import reflex.data.Selection;
	import reflex.layouts.VerticalLayout;
	import reflex.skins.ListSkin;
	import reflex.binding.DataChange;
	import reflex.data.IPosition;
	import reflex.data.IRange;
	import reflex.data.ISelection;
	import reflex.layouts.ILayout;
	import mx.collections.IList;

	[Event(name="selectionChange", type="flash.events.Event")]
	[Event(name="itemClick", type="flash.events.Event")]
	public class List extends Component
	{
		
		private var _layout:ILayout;
		private var _dataProvider:IList;
		private var _template:Object;
		private var _position:IPosition;
		private var _selection:ISelection
		
		[Bindable(event="layoutChange")]
		public function get layout():ILayout { return _layout; }
		public function set layout(value:ILayout):void {
			DataChange.change(this, "layout", _layout, _layout = value);
		}
		
		[Bindable(event="dataProviderChange")]
		public function get dataProvider():IList { return _dataProvider; }
		public function set dataProvider(value:IList):void {
			DataChange.change(this, "dataProvider", _dataProvider, _dataProvider = value);
		}
		
		[Bindable(event="templateChange")]
		public function get template():Object { return _template; }
		public function set template(value:Object):void {
			DataChange.change(this, "template", _template, _template = value);
		}
		
		[Bindable(event="selectionChange")]
		public function get selection():ISelection { return _selection; }
		public function set selection(value:ISelection):void {			
			DataChange.change(this, "selection", _selection, _selection = value);			
		}
		
		[Bindable(event="positionChange")]
		public function get position():IPosition { return _position; }
		public function set position(value:IPosition):void {
			DataChange.change(this, "position", _position, _position = value);
		}		
		
		public function List()
		{
			super();
			initialize();
		}
		
		private function initialize():void {
			selection = new Selection();
			layout = new VerticalLayout();
			(layout as VerticalLayout).gap = 10;
			template = ListItem;
			skin = new ListSkin();
			Bind.addBinding(this, "skin.container.content", this, "dataProvider");
			Bind.addBinding(this, "skin.container.template", this, "template");
			Bind.addBinding(this, "skin.container.layout", this, "layout");
			behaviors.addItem(new ListSelectionBehavior(this));
		}
		
	}
}