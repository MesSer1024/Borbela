package messer_entertainment.puzzles.pig {

import fl.motion.Color;
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.events.TouchEvent;
import flash.geom.Point;
import flash.utils.Timer;
import messer_entertainment.puzzles.IGame;
import messer_entertainment.utils.Identifiers;
import messer_entertainment.utils.listeners.ClickListener;
import messer_entertainment.utils.MesserUtils;
import messer_entertainment.utils.MovieController;
import messer_entertainment.utils.PerformanceTracker;

public class OinkGame implements IGame {
	private const _items:Array = ["1", "2", "3", "4", "5", "6", "7", "8"];
	private var _controllers:Array;
	private var _currentDraggedObject:GameObject;
	private var _content:MovieClip;
	private var _win:MovieClip;
	private var _back:MovieClip;
	
	private var _touchPointId:int;
	private var _itemsToPlace:uint;
	private var _tracker:PerformanceTracker;
	private var _player:SoundPlayer;
	
	public function OinkGame(content:MovieClip) {
		_content = content;
		trace("OinkGame");
	}
	
	/* INTERFACE messer_entertainment.puzzles.IGame */
	public function get Content():MovieClip {
		return _content;
	}
	
	public function init():void {
		trace("init");
		_tracker = new PerformanceTracker(_content.stage);
		_controllers = [];
		var gui:MovieClip = getAsserted("gui");
		_back = assert(gui["back"]);
		_win = getAsserted("win");
		_win.gotoAndStop(1);
		
		new ClickListener(_back, onBackClicked);
		Controller.listen(Identifiers.GAME_OBJECT_CLICKED, onClicked);
		Controller.listen(Identifiers.GAME_OBJECT_RELEASED, onReleased);
		Controller.listen(Identifiers.GAME_OBJECT_MOVED, onMoved);
		_player = new SoundPlayer();
		
		var ln:Number = _items.length;
		var mc:MovieClip;
		
		for (var i:int = 0; i < ln; ++i) {
			mc = getAsserted("hit" + _items[i]);
			var hitObject:GameObject = new GameObject(mc, i);
			
			mc = getAsserted("drag" + _items[i]);
			var dragObject:DraggableObject = new DraggableObject(mc, i);
			
			var finishedMc = getAsserted("finished" + _items[i]);
			
			_controllers.push(new HitAreaController(dragObject, hitObject, finishedMc));
		}
	}
	
	private function onBackClicked(e:ClickListener):void {
		trace("Back clicked!");
		Controller.send(Identifiers.BACK_CLICKED);
	}
	
	public function restart():void {
		Controller.send(Identifiers.E_GAME_STARTED);
		_win.visible = false;
		_win.gotoAndStop(1);
		_content.removeChild(_win);
		_itemsToPlace = _items.length;
		_touchPointId = 0;
		resetControllers();
	}
	
	private function resetControllers():void {
		for (var i:int = 0; i < _items.length; ++i) {
			HitAreaController(_controllers[i]).reset();
		}
	}
	
	private function onClicked(mc:GameObject):void {
		trace("function onClicked()");
		if (_currentDraggedObject) {
			HitAreaController(_controllers[_currentDraggedObject.id]).reset();
			_currentDraggedObject.stopDrag();
		}
		_touchPointId = mc.touchid;
		_currentDraggedObject = mc;
		mc.startDrag();
		_content.setChildIndex(mc.Content, _content.numChildren - 2);
	}
	
	private function onMoved(pos:Point):void {
		if (_currentDraggedObject) {
			var controller:HitAreaController = _controllers[_currentDraggedObject.id];
			if (controller.hitTest(pos)) {
				controller.overCorrect();
			} else {
				controller.overWrong();
			}
		}
	}
	
	private function onReleased(mc:GameObject):void {
		mc.stopDrag();
		var isFinished = false;
		if (_currentDraggedObject.correct) {
			HitAreaController(_controllers[mc.id]).lock();
			if (--_itemsToPlace == 0) {
				isFinished = true;
			}
		} else {
			HitAreaController(_controllers[mc.id]).reset();
		}
		_touchPointId = 0;
		_currentDraggedObject = null;
		if (isFinished) {
			finished();
		}
	}
	
	private function getAsserted(child:String):MovieClip {
		var mc:MovieClip = _content[child];
		assert(mc);
		return mc;
	}
	
	private function assert(mc:MovieClip):MovieClip {
		if (!mc)
			throw new Error("assert failed on movieclip with id:" + mc);
		return mc;
	}
	
	private function finished():void {
		_tracker.printStoredInfo();
		_content.addChild(_win);
		Controller.send(Identifiers.E_GAME_COMPLETED);
		var t:Timer = new Timer(750, 1); //FIXME: Util class for timers
		t.addEventListener(TimerEvent.TIMER, function(e:Event):void {
				Controller.send(Identifiers.E_WIN_ANIM_SHOWN);
				var foo:Timer = new Timer(2250, 1);
				foo.addEventListener(TimerEvent.TIMER_COMPLETE, function(e:Event):void {
					resetControllers();
					new MovieController(_win, restart).animOut();
				});
				foo.start();
				_win.visible = true;
				new MovieController(_win).animIn();
			});
		t.start();
	}
	
	public function destroy():void {
		for (var i:int = 0; i < _controllers.length; ++i) {
			HitAreaController(_controllers[i]).destroy();
		}
		_currentDraggedObject = null;
		_win = null;
		_back = null;
		_tracker = null;
		_content = null;
		_controllers = null;
		Controller.removeListener(Identifiers.GAME_OBJECT_CLICKED, onClicked);
		Controller.removeListener(Identifiers.GAME_OBJECT_RELEASED, onReleased);
		Controller.removeListener(Identifiers.GAME_OBJECT_MOVED, onMoved);
	}
}
}
