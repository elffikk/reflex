package mx.states
{
	
	import flash.events.EventDispatcher;
	
	public class OverrideBase extends EventDispatcher //implements IOverride
	{
		
		/**
		 * @private
		 * @param parent The document level context for this override.
		 * @param target The component level context for this override.
		 */
		protected function getOverrideContext(target:Object, parent:Object):Object
		{
			if (target == null)
				return parent;
			
			if (target is String)
				return parent[target];
			
			return target;
		}
		
		
		public function initializeFromObject(properties:Object):Object {
			for (var p:String in properties)
			{
				try{
					this[p] = properties[p];
				}
				catch(err:Error){}
			}
			return Object(this);
		}
		
	}
}