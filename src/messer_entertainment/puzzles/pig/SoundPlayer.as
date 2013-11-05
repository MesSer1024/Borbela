package messer_entertainment.puzzles.pig {
import flash.media.Sound;
import messer_entertainment.utils.Identifiers;

/**
* ...
* @author Daniel 'MesSer' Dahlkvist
*/
public class SoundPlayer {
	
	public function SoundPlayer() {
		Controller.listen(Identifiers.E_CORRECT_ITEM_PLACED, onCorrectItemReleased);
		Controller.listen(Identifiers.E_GAME_COMPLETED, onGameFinished);
		Controller.listen(Identifiers.GAME_OBJECT_CLICKED, onObjectClicked);
		Controller.listen(Identifiers.E_WIN_ANIM_SHOWN, onAnimShown);
		
	}
	
	private function onAnimShown():void {
		var s:Sound = new pig_name();
		s.play(0, 1);
	}
	
	private function onObjectClicked(sender:Object):void {
		var s:Sound = new pig_select();
		s.play(0, 1);
	}
	
	private function onGameFinished():void {
		trace(">onGameFinished");
		var s:Sound = new pig_won();
		s.play(0, 1);
		trace("<onGameFinished");
	}
	
	private function onCorrectItemReleased():void {
		var s:Sound = new pig_placed();
		s.play(0, 1);
	}
}
}