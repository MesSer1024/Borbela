package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import messer_entertainment.puzzles.pig.OinkGame;
	
	
	public class PigFlaDummy extends MovieClip {
		private var _game:OinkGame;
		public var fla_dummy:MovieClip;
		
		public function PigFlaDummy() {
			trace("PigFlaDummy!");
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			removeChild(fla_dummy);
			_game = new OinkGame(fla_dummy);
			addChild(fla_dummy);
			_game.init();
			_game.restart();
		}
	}
	
}
