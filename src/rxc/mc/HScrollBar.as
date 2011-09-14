package rxc.mc
{
	import rxc.mc.skins.HScrollBarSkin;

	public class HScrollBar extends ScrollBar
	{
		public function HScrollBar()
		{
			super();
			skin = new HScrollBarSkin()
			direction = HORIZONTAL
			width = 110
			height = 10
		}
	}
}