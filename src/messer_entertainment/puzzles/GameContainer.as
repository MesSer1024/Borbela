package messer_entertainment.puzzles {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import messer_entertainment.puzzles.pig.OinkGame;
	import messer_entertainment.puzzles.pig.PigResource
	import messer_entertainment.utils.listeners.ClickListener;
	import messer_entertainment.utils.listeners.IListener;
	
	
	public class GameContainer extends MovieClip {
		private var _gameSelectedCB:Function;
		public var pig:MovieClip;
		public var cow:MovieClip;
		public var rooster:MovieClip;
		
		public function GameContainer(gameSelectedCB:Function) {
			_gameSelectedCB = gameSelectedCB;
			new ClickListener(pig, onPig);
			new ClickListener(cow, onCow);
			new ClickListener(rooster, onRooster);
		}
		
		private function onPig(e:IListener):void {
			trace("onPig");
			var mc:MovieClip = new PigResource();
			var game:IGame = new OinkGame(mc);
			_gameSelectedCB(game);
		}
		
		private function onCow(e:IListener):void {
			trace("onCow");
		}
		
		private function onRooster(e:IListener):void {
			trace("onRooster");
		}
	}
	
}
