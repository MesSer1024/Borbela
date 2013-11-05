package messer_entertainment.utils.listeners {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Daniel 'MesSer' Dahlkvist
	 */
	public class MoveListener implements IListener {
		private var _content:DisplayObject;
		private var _movedCB:Function;
		private var _id:Number;
		public var point:Point;
		
		public function MoveListener(content:DisplayObject, movedCB:Function) {
			_content = content;
			_movedCB = movedCB;
			_content.addEventListener(TouchEvent.TOUCH_MOVE, onMoved);
			_content.addEventListener(MouseEvent.MOUSE_MOVE, onMoved);
			point = new Point();
		}
		
		private function onMoved(e:Event):void {
			if (!_content) return;
			if (e is TouchEvent) {
				var foo:TouchEvent = e as TouchEvent;
				point.x = foo.stageX;
				point.y = foo.stageY;
				_id = foo.touchPointID;
			} else {
				point.x = _content.stage.mouseX;
				point.y = _content.stage.mouseY;
				_id = ClickListener.MOUSE_CLICK_IDENTIFIER;
			}
			
			if (_movedCB != null) {
				_movedCB(this);
			}
		}
		
		public function destroy():void {
			if (!_content) return;
			_content.removeEventListener(TouchEvent.TOUCH_MOVE, onMoved);
			_content.removeEventListener(MouseEvent.MOUSE_MOVE, onMoved);
			_content = null;
			_movedCB = null;
		}
		
		public function get id():Number {
			return _id;
		}
	}

}