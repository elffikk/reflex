package rxc.mc
{
	import rxc.mc.skins.VScrollBarSkin;

	public class VScrollBar extends ScrollBar
	{
		public function VScrollBar()
		{
			super();
			skin = new VScrollBarSkin()
			direction = VERTICAL
			width = 10
			height = 110
			value = 0
		}
	}
}