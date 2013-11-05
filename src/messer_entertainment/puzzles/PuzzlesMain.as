package messer_entertainment.puzzles {
//import com.demonsters.debugger.MonsterDebugger;
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.ui.Multitouch;
import flash.ui.MultitouchInputMode;
import messer_entertainment.puzzles.pig.Controller;
import messer_entertainment.utils.Identifiers;
import messer_entertainment.utils.listeners.ClickListener;
import messer_entertainment.utils.MovieController;

public class PuzzlesMain extends Sprite {
	private var _gameContainer:GameContainer;
	private var _game:IGame;
	public var intro:MovieClip;
	
	public function PuzzlesMain() {
		addEventListener(Event.ADDED_TO_STAGE, onStage);
	}
	
	private function onStage(e:Event):void {
		removeEventListener(Event.ADDED_TO_STAGE, onStage);
		Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;

		var mc:MovieController = new MovieController(intro, onIntroDone);
		mc.animIn();
	}
	
	private function onIntroDone():void {
		trace("intro animation done");
		new ClickListener(intro, onIntroClicked);
	}
	
	private function onIntroClicked(id:Number):void {
		trace("screen clicked");
		removeChild(intro);
		intro = null;
		showGameContainer();
	}
	
	private function showGameContainer():void {
		_gameContainer = new GameContainer(playGame);
		addChild(_gameContainer);
	}
	
	private function playGame(game:IGame):void {
		_game = game;
		Controller.listen(Identifiers.BACK_CLICKED, onBack);
		trace("play game mc=" + game);
		removeChild(_gameContainer);
		_gameContainer = null;
		addChild(game.Content);
		game.init();
		game.restart();
	}
	
	private function onBack():void {
		trace("PuzzlesMain.onBack!");
		_game.destroy();
		Controller.removeAllListeners();
		showGameContainer();
	}
}

}