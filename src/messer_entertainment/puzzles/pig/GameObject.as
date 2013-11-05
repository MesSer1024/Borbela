package messer_entertainment.puzzles.pig {
import flash.display.MovieClip;
import flash.events.TouchEvent;
import flash.geom.Point;
import messer_entertainment.utils.Identifiers;
import messer_entertainment.utils.listeners.ClickListener;
import messer_entertainment.utils.listeners.DownListener;
import messer_entertainment.utils.listeners.IListener;
import messer_entertainment.utils.listeners.MoveListener;
import messer_entertainment.utils.listeners.ReleaseListener;

public class GameObject {
	private var _listeners:Array;
	protected var _content:MovieClip;
	protected var _correct:Boolean;
	public var id:Number;
	public var touchid:int;
	public var stageX:Number;
	public var stageY:Number;
	
	public function get Content():MovieClip {
		return _content;
	}
	
	public function get correct():Boolean {
		return _correct;
	}
	
	public function set correct(value:Boolean):void {
		_correct = value;
	}
	
	public function GameObject(content:MovieClip, id:Number) {
		_listeners = [];
		this.id = id;
		_content = content;
		_correct = true;
		correct = false;
	}
	
	private function onTouchStart(e:IListener):void {
		touchid = e.id;
		Controller.send(Identifiers.GAME_OBJECT_CLICKED, this);
	}
	
	public function startDrag():void {
		trace("touchId=" + touchid);
		if (touchid != Identifiers.MOUSE_CLICK_IDENTIFIERS) {
			_content.startTouchDrag(touchid, true);
		} else {
			_content.startDrag(true);
		}
		disableInput();
		_listeners.push(new MoveListener(_content, onMoved));
		_listeners.push(new ReleaseListener(_content, onTouchEnd));
	}
	
	private function onTouchEnd(e:IListener):void {
		touchid = e.id;
		Controller.send(Identifiers.GAME_OBJECT_RELEASED, this);
	}
	
	private function onMoved(e:IListener):void {
		//trace("Pos:" + e.stageX + "," + e.stageY);
		Controller.send(Identifiers.GAME_OBJECT_MOVED, MoveListener(e).point);
	}
	
	public function stopDrag():void {
		trace("stop touchid=" + touchid);
		if (touchid != Identifiers.MOUSE_CLICK_IDENTIFIERS) {
			_content.stopTouchDrag(touchid);
		} else {
			_content.stopDrag();
		}
		disableInput();
		enableInput();
	}
	
	public function disableInput():void {
		var listener:IListener;
		for (var i:int = 0; i < _listeners.length; ++i) {
			listener = _listeners[i];
			listener.destroy();
		}
		_listeners = [];
	}
	
	public function enableInput():void {
		_listeners.push(new DownListener(_content, onTouchStart));
	}
	
	public function destroy():void {
		disableInput();
		_content = null;
	}
}
}