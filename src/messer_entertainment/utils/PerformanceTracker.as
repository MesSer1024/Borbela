package messer_entertainment.utils {
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.getTimer;
	import messer_entertainment.puzzles.pig.Controller;
	/**
	 * ...
	 * @author Daniel 'MesSer' Dahlkvist
	 */
	public class PerformanceTracker {
		private var _stage:Stage;
		private var _timestamp:Number;
		private var _deltas:Vector.<Number>;
		private var _texts:Vector.<String>;
		private var _currentText:String;
		
		public function PerformanceTracker(stage:Stage) {
			_deltas = new Vector.<Number>();
			_texts = new Vector.<String>;
			_stage = stage;
			//_stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			//_stage.addEventListener(Event.EXIT_FRAME, onExitFrame);
			Controller.listen(Identifiers.GAME_OBJECT_CLICKED, onClicked);
			Controller.listen(Identifiers.GAME_OBJECT_MOVED, onMoved);
			Controller.listen(Identifiers.GAME_OBJECT_RELEASED, onRelease);
		}
		
		private function onRelease(...rest):void {
			addTextDescription("released");
		}
		
		private function onMoved(...rest):void {
			addTextDescription("moved");
		}
		
		private function onClicked(...rest):void {
			addTextDescription("clicked");
		}
		
		private function onEnterFrame(e:Event):void {
			_timestamp = getTimer();
			_currentText = "";
		}
		
		private function onExitFrame(e:Event):void {
			var delta:Number = getTimer() - _timestamp;
			if (!isNaN(delta) && delta > 20) {
				_texts[_texts.length - 1] += "|CPU_MAJOR";
			}
			_deltas.push(delta);
			_texts.push(_currentText);
		}
		
		public function addTextDescription(s:String):void {
			_currentText += s;
		}
		
		public function printStoredInfo():void {
			var ln:Number = Math.min(_deltas.length, _texts.length);
			for (var i:int = 0; i < ln; ++i) {
				trace("frame[" + i + "]=" + _deltas[i] + ":" + _texts[i]);
			}
		}
		
		public function reset():void {
			_deltas.length = 0;
		}
	}
}