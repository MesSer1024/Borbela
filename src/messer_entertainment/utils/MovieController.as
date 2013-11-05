package messer_entertainment.utils {
import flash.display.FrameLabel;
import flash.display.MovieClip;
import flash.events.Event;

public class MovieController {
	private static const MAX_FRAMES:uint = 300;
	private var _content:MovieClip;
	private var _stopLabel:String;
	private var _frameCounter:uint;
	
	private static const ANIM_IN_LABEL:String = "in";
	private static const ANIM_IN_DONE_LABEL:String = "in_done";
	private static const IDLE_LABEL:String = "idle";
	private static const ANIM_OUT_LABEL:String = "out";
	private static const ANIM_OUT_DONE_LABEL:String = "out_done";
	
	public var completeCB:Function;
	
	public function get Content():MovieClip {
		return _content;
	}
	
	public function MovieController(mc:MovieClip, completeCB:Function = null) {
		_content = mc;
		_stopLabel = "";
		_frameCounter = 0;
		this.completeCB = completeCB;
	}
	
	public function animIn():void {
		animate(ANIM_IN_LABEL, ANIM_IN_DONE_LABEL);
	}
	
	public function animOut():void {
		animate(ANIM_OUT_LABEL, ANIM_OUT_DONE_LABEL);
	}
	
	public function reset():void {
		_content.stop();
		_content.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	public function animate(from:String, to:String):void {
		var labels:Array = _content.currentLabels;
		_content.visible = true;
		var labelsFound:Number = 0;
		for (var i:int = 0; i < labels.length; i++) {
			var label:FrameLabel = labels[i];
			if (label.name == from || label.name == to) {
				labelsFound++;
			}
		}
		if (labelsFound != 2) {
			throw new Error("missing fromLabel[" + from + "] or toLabel[" + to + "] in labels[" + labels.toString() + "]");
		}
		reset();
		_frameCounter = 0;
		_stopLabel = to;
		_content.gotoAndPlay(from);
		_content.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	private function onEnterFrame(e:Event):void {
		_frameCounter++;
		if (_content.currentFrameLabel == _stopLabel || _frameCounter > MAX_FRAMES) {
			animDone();
		}
	}
	
	private function animDone():void {
		reset();
		_stopLabel = "";
		_content.stop();
		if (completeCB != null) {
			var f:Function = completeCB;
			completeCB = null;
			_content = null;
			f();
		}
	}
}
}