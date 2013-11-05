package messer_entertainment.utils.listeners {
import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TouchEvent;

/**
* ...
* @author Daniel 'MesSer' Dahlkvist
*/
public class ClickListener implements IListener {
	static public const MOUSE_CLICK_IDENTIFIER:int = -325;
	private var _content:DisplayObject;
	private var _clickedCB:Function;
	private var _id:Number;
	
	public function ClickListener(content:DisplayObject, clickedCB:Function) {
		_content = content;
		_clickedCB = clickedCB;
		_content.addEventListener(TouchEvent.TOUCH_TAP, onClicked);
		_content.addEventListener(MouseEvent.CLICK, onClicked); //FIXME: mouse
	}
	
	/* INTERFACE messer_entertainment.utils.listeners.IListener */
	
	public function destroy():void {
		if (!_content) return;
		_content.removeEventListener(TouchEvent.TOUCH_TAP, onClicked);
		_content.removeEventListener(MouseEvent.CLICK, onClicked); //FIXME: mouse
		_content = null;
	}
	
	private function onClicked(e:Event):void {
		if (!_content) return;
		_content.removeEventListener(TouchEvent.TOUCH_TAP, onClicked);
		_content.removeEventListener(MouseEvent.CLICK, onClicked); //FIXME: mouse
		_id = e is TouchEvent ? TouchEvent(e).touchPointID : MOUSE_CLICK_IDENTIFIER;
		if (_clickedCB != null) {
			var f:Function = _clickedCB;
			_clickedCB = null;
			_content = null;
			f(this);
		}
	}
	
	public function get id():Number {
		return _id;
	}

}

}