package rxc.mc
{
	import flash.events.Event;

	public class VSlider extends Slider
	{
		public function VSlider()
		{
			super();
			direction = Slider.VERTICAL
			width = 10
			height = 100
			dispatchEvent(new Event("valueChange"))//to position thumb correctly
		}
	}
}