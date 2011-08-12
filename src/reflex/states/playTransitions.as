package reflex.states
{
	
	import mx.states.IOverride;
	import mx.states.State;
	import mx.states.Transition;
	
	public function playTransitions(fromState:String, toState:String, transitions:Array):void
	{
		for each(var transition:Object in transitions) {
			if (transition.effect.isPlaying){
				transition.effect.stop();
			}
		}
		for each(var transition:Object in transitions) {
			if (fromState == null || transition.fromState == null || transition.fromState == fromState || transition.fromState == "*"){
				if (toState == null  || transition.toState == null || transition.toState == toState || transition.toState == "*"){
					transition.effect.play()
				}
			}
		}
	}
	
}