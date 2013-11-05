package messer_entertainment.utils.listeners {
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;

/**
* ...
* @author Daniel 'MesSer' Dahlkvist
*/
public class DownListener implements IListener {
	private var _content:DisplayObject;
	private var _clickedCB:Function;
	private var _id:Number;
	
	public function DownListener(content:DisplayObject, clickedCB:Function) {
		_content = content;
		_clickedCB = clickedCB;
		_content.addEventListener(TouchEvent.TOUCH_BEGIN, onDown);
		_content.addEventListener(MouseEvent.MOUSE_DOWN, onDown); //FIXME: mouse
	}
	
	/* INTERFACE messer_entertainment.utils.listeners.IListener */
	
	public function destroy():void {
		if (!_content) return;
		_content.removeEventListener(TouchEvent.TOUCH_BEGIN, onDown);
		_content.removeEventListener(MouseEvent.MOUSE_DOWN, onDown); //FIXME: mouse
		_content = null;
	}
	
	private function onDown(e:Event):void {
		trace("ClickListener");
		if (!_content) return;
		_content.removeEventListener(TouchEvent.TOUCH_BEGIN, onDown);
		_content.removeEventListener(MouseEvent.MOUSE_DOWN, onDown); //FIXME: mouse
		_id = e is TouchEvent ? TouchEvent(e).touchPointID : ClickListener.MOUSE_CLICK_IDENTIFIER;
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