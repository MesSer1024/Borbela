package messer_entertainment.puzzles.pig {

/**
* ...
* @author
*/
public class Controller {
	private static var _listeners:Object = {};
	
	public static function send(id:String, data:Object = null):void {
		var arr:Array = _listeners[id];
		//trace("inEvent " + id + ", listeners=" + arr.length);

		if (arr) {
			var ln:Number = arr.length;
			var fn:Function;
			for (var i:int = 0; i < ln; ++i) {
				fn = arr[i];
				data == null ? fn() : fn(data);
			}
		}
	}
	
	public static function listen(id:String, cb:Function):void {
		trace("adding event listener for [" + id + "] for function :" + cb);
		var arr:Array = _listeners[id];
		if (!arr) {
			_listeners[id] = [cb];
		} else {
			arr.push(cb);
		}
	}
	
	public static function removeListener(id:String, cb:Function):void {
		var arr:Array = _listeners[id];
		if (arr && arr.length > 0) {
			for (var i:int = 0; i < arr.length; ++i) {
				if (arr[i] == cb) {
					arr.splice(cb);
					--i;
				}
			}
			
		}
	}
	
	public static function removeAllListeners():void {
		_listeners = new Object();
	}
}

}