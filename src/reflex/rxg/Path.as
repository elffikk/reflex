package reflex.rxg
{
	
	
	import flash.display.GraphicsPath;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.svgweb.utils.SvgPath;
	
	import reflex.binding.DataChange;
	
		
	public class Path extends GraphicBase
	{		
		private var path:GraphicsPath;
		
		private var _winding:String;
		[Bindable(event="windingChange")]
		public function get winding():String { return _winding; }
		public function set winding(value:String):void {			
			DataChange.change(this, "winding", _winding, _winding = value);
			invalidate()			
		}
		
		private var _data:String;
		[Bindable(event="dataChange")]
		public function get data():String { return _data; }
		public function set data(value:String):void {			
			DataChange.change(this, "data", _data, _data = value);
			onDataChange()
			invalidate()			
		}		
		
		private function onDataChange():void
		{
			//parser
			var svgPath:SvgPath = new SvgPath(_data) 
			this.path = svgPath.graphicsPath
			//measure
			var p:Point = new Point(0, 0)
			for (var i:int = 0; i < path.data.length; i+=2)
			{
				p.x = Math.max(p.x, path.data[i])
				p.y = Math.max(p.y, path.data[i+1])
			}
			measured.width = p.x
			measured.height = p.y
		}
				
		override public function draw():void 
		{
			graphics.drawPath(path.commands, path.data, winding || path.winding)			
		}

	}
}