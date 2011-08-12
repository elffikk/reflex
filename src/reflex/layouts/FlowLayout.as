package reflex.layouts
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import reflex.binding.DataChange;
	import reflex.layouts.ILayout;
	import reflex.layouts.Layout;
	import reflex.measurement.IMeasurable;
	import reflex.measurement.IMeasurements;
	import reflex.measurement.resolveHeight;
	import reflex.measurement.resolveWidth;
	import reflex.styles.resolveStyle;
	
	[LayoutProperty(name="width", measure="true")]
	[LayoutProperty(name="height", measure="true")]
	
	public class FlowLayout extends Layout implements ILayout
	{
		
		protected var _gap:int;		
		[Bindable("gapChange")]
		public function get gap():int {return _gap;}
		public function set gap(value:int):void {
			DataChange.change(this, "gap", _gap, _gap = value);
		}
		
		
		public function FlowLayout()
		{
			super();
		}
		
		override public function measure(children:Array):Point
		{
			super.measure(children);
			var gap:Number = reflex.styles.resolveStyle(target, "gap", Number, this.gap) as Number;
			
			var moveX:int = 0;
			var moveY:int = 0;
			var width:int = (target as IMeasurable).width;
			var height:int = (target as IMeasurable).height;
			var rectangle:Rectangle = new Rectangle(0, 0, width, height);
			var maxY:int = 0;
			
			for each(var child:Object in children) {				
				child.x = moveX;
				child.y = moveY;
				
				var w:Number = resolveWidth(child, rectangle.width);
				var h:Number = resolveHeight(child, rectangle.height);
				
				moveX += gap;
				
				maxY = Math.max(maxY, moveY+h);
				
				moveX += w;
				if(moveX + w > width) {
					moveY = maxY+gap;
					moveX = 0;
					maxY = 0;
				}				
			}
			return new Point(moveX, Math.max(moveY, maxY));
		}
		
		override public function update(children:Array, rectangle:Rectangle):void {
			super.update(children, rectangle);
			
			var gap:Number = reflex.styles.resolveStyle(target, "gap", Number, this.gap) as Number;
			
			var moveX:int = 0;
			var moveY:int = 0;
			var width:int = (target as IMeasurable).width;
			var height:int = (target as IMeasurable).height;
			var maxY:int = 0;
			
			
			for each(var child:Object in children) {
				
				child.x = moveX;
				child.y = moveY;
				
				var w:Number = resolveWidth(child, rectangle.width);
				var h:Number = resolveHeight(child, rectangle.height);
				
				moveX += gap;
				
				maxY = Math.max(maxY, moveY+h);
				
				moveX += w;
				if(moveX + w > width) {
					moveY = maxY+gap;
					moveX = 0;
					maxY = 0;
				}
				
			}
		}
		
	}
}