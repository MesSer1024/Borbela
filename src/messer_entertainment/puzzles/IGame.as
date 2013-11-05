package messer_entertainment.puzzles {
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Daniel 'MesSer' Dahlkvist
	 */
	public interface IGame {
		function get Content():MovieClip;
		function init():void;
		function restart():void;
		function destroy():void;
	}
	
}