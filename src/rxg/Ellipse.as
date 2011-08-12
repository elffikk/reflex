package reflex.rxg
{
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Ellipse extends GraphicBase
	{		
		override public function draw():void {
			graphics.drawEllipse(0, 0, width, height);
		}
	}
}