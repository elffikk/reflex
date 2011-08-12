package reflex.rxg
{
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import reflex.binding.DataChange;
	
	
	public class Line extends GraphicBase
	{
		private var _xFrom:Number = 0;
		private var _yFrom:Number = 0;
		private var _xTo:Number = 0;
		private var _yTo:Number = 0;
		
		[Bindable(event="xFromChange")]
		public function get xFrom():Number { return _xFrom; }
		public function set xFrom(value:Number):void {
			if (_xFrom == value) {
				return;
			}
			DataChange.change(this, "xFrom", _xFrom, _xFrom = value);
			invalidate()
		}
		
		[Bindable(event="yFromChange")]
		public function get yFrom():Number { return _yFrom; }
		public function set yFrom(value:Number):void {
			if (_yFrom == value) {
				return;
			}
			DataChange.change(this, "yFrom", _yFrom, _yFrom = value);
			invalidate()
		}
		
		[Bindable(event="xToChange")]
		public function get xTo():Number { return _xTo; }
		public function set xTo(value:Number):void {
			if (_xTo == value) {
				return;
			}
			DataChange.change(this, "xTo", _xTo, _xTo = value);
			invalidate()
		}
		
		[Bindable(event="yToChange")]
		public function get yTo():Number { return _yTo; }
		public function set yTo(value:Number):void {
			if (_yTo == value) {
				return;
			}
			DataChange.change(this, "yTo", _yTo, _yTo = value);
			invalidate()
		}
		
		override public function draw():void {
			graphics.moveTo(xFrom, yFrom)
			graphics.lineTo(xTo, yTo)
		}
	}
}