package messer_entertainment.utils.listeners {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TouchEvent;

/**
* ...
* @author Daniel 'MesSer' Dahlkvist
*/
public class ReleaseListener implements IListener {
	private var _content:DisplayObject;
	private var _releasedCB:Function;
	private var _id:Number;
	
	public function ReleaseListener(content:MovieClip, releasedCB:Function) {
		_content = content;
		_releasedCB = releasedCB;
		_content.addEventListener(TouchEvent.TOUCH_END, onReleased);
		_content.addEventListener(MouseEvent.MOUSE_UP, onReleased); //FIXME: mouse
	}
	
	private function onReleased(e:Event):void {
		if (!_content) return;
		_content.removeEventListener(TouchEvent.TOUCH_END, onReleased);
		_content.removeEventListener(MouseEvent.MOUSE_UP, onReleased); //FIXME: mouse
		_id = e is TouchEvent ? TouchEvent(e).touchPointID : ClickListener.MOUSE_CLICK_IDENTIFIER;
		if (_releasedCB != null) {
			var f:Function = _releasedCB;
			_releasedCB = null;
			_content = null;
			f(this);
		}
	}
	
	public function destroy():void {
		if (!_content) return;
		_content.removeEventListener(TouchEvent.TOUCH_END, onReleased);
		_content.removeEventListener(MouseEvent.MOUSE_UP, onReleased); //FIXME: mouse
		_content = null;
	}
	
	public function get id():Number {
		return _id;
	}

}

}