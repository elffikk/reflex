package reflex.rxg
{
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import reflex.binding.DataChange;
	
	
	public class Rect extends GraphicBase
	{
		/**
		 * Degrafa like complex rect
		 */
		private var _topLeftRadius:Number = 0;		
		[Bindable(event="topLeftRadius")]
		public function get topLeftRadius():Number { return _topLeftRadius; }
		public function set topLeftRadius(value:Number):void {
			if (_topLeftRadius == value) {
				return;
			}
			DataChange.change(this, "topLeftRadius", _topLeftRadius, _topLeftRadius = value);
			invalidate()
		}
		
		private var _topRightRadius:Number = 0;		
		[Bindable(event="topRightRadius")]
		public function get topRightRadius():Number { return _topRightRadius; }
		public function set topRightRadius(value:Number):void {
			if (_topRightRadius == value) {
				return;
			}
			DataChange.change(this, "topRightRadius", _topRightRadius, _topRightRadius = value);
			invalidate()
		}
		
		private var _bottomLeftRadius:Number = 0;		
		[Bindable(event="bottomLeftRadius")]
		public function get bottomLeftRadius():Number { return _bottomLeftRadius; }
		public function set bottomLeftRadius(value:Number):void {
			if (_bottomLeftRadius == value) {
				return;
			}
			DataChange.change(this, "bottomLeftRadius", _bottomLeftRadius, _bottomLeftRadius = value);
			invalidate()
		}
		
		private var _bottomRightRadius:Number = 0;		
		[Bindable(event="bottomRightRadius")]
		public function get bottomRightRadius():Number { return _bottomRightRadius; }
		public function set bottomRightRadius(value:Number):void {
			if (_bottomRightRadius == value) {
				return;
			}
			DataChange.change(this, "bottomRightRadius", _bottomRightRadius, _bottomRightRadius = value);
			invalidate()
		}
		
		/**
		 * Fxg like rect
		 */
		
		private var _radiusX:Number = 0;		
		[Bindable(event="radiusXChange")]
		public function get radiusX():Number { return _radiusX; }
		public function set radiusX(value:Number):void {
			if (_radiusX == value) {
				return;
			}
			DataChange.change(this, "radiusX", _radiusX, _radiusX = value);
			invalidate()
		}
		
		private var _radiusY:Number = 0;
		[Bindable(event="radiusYChange")]
		public function get radiusY():Number { return _radiusY; }
		public function set radiusY(value:Number):void {
			if (_radiusY == value) {
				return;
			}
			DataChange.change(this, "radiusY", _radiusY, _radiusY = value);
			invalidate()
		}		
		
		override public function draw():void {
			if (topLeftRadius>0 || topRightRadius>0 || bottomLeftRadius>0 || bottomRightRadius>0){
				graphics.drawRoundRectComplex(0, 0, width, height, topLeftRadius, topRightRadius, bottomLeftRadius, bottomRightRadius)
			}
			else if (radiusX > 0){
				//http://opensource.adobe.com/wiki/display/flexsdk/FXG+2.0+Specification#FXG2.0Specification-TheRectelement
				graphics.drawRoundRect(0, 0, width, height, 2*radiusX, 2*(radiusY == 0?radiusX:radiusY) )
			}
			else{
				graphics.drawRect(0, 0, width, height)
			}
		}
	}
}