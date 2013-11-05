package messer_entertainment.puzzles.pig {
import caurina.transitions.Tweener;
import flash.display.MovieClip;
import flash.geom.Point;
import messer_entertainment.utils.Identifiers;

public class HitAreaController {
	private var _dragObject:DraggableObject;
	private var _hitObject:GameObject;
	private var _finished:MovieClip;
	private var _startPoint:Point;
	static private const MOVE_ITEM_TIME:Number = 0.368;
	static private const TRANSITION_TYPE:String = "easeInOut";
	
	public function HitAreaController(dragObject:DraggableObject, hitObject:GameObject, finished:MovieClip) {
		_dragObject = dragObject;
		_startPoint = new Point(dragObject.Content.x, dragObject.Content.y);
		
		_hitObject = hitObject;
		_hitObject.disableInput();
		_hitObject.Content.visible = false;
		
		_finished = finished;
		_finished.mouseChildren = false;
		_finished.mouseEnabled = false;
		_finished.visible = false;
	}
	
	public function overWrong():void {
		_dragObject.correct = false;
		_hitObject.correct = false;
		_finished.visible = false;
	}
	
	public function overCorrect():void {
		_dragObject.correct = true;
		_hitObject.correct = true;
		_finished.visible = true;
	}
	
	public function lock(tween:Boolean = true):void {
		_dragObject.disableInput();
		Controller.send(Identifiers.E_CORRECT_ITEM_PLACED);
		var tarX:Number = _finished.x;
		var tarY:Number = _finished.y;
		if (tween) {
			Tweener.addTween(_dragObject.Content, { x:tarX, y:tarY, time:MOVE_ITEM_TIME, transition:TRANSITION_TYPE, onComplete:onCenteredOnTarget});
		} else {
			_dragObject.Content.x = tarX;
			_dragObject.Content.y = tarY;
			onCenteredOnTarget();
		}
	}
	
	private function onCenteredOnTarget():void {
		Controller.send(Identifiers.E_ITEM_PLACED_AND_ANIM_COMPLETE, this);
	}
	
	public function reset():void {
		trace("reset hitareacontroller");
		_hitObject.correct = false;
		
		_dragObject.Content.x = _startPoint.x;
		_dragObject.Content.y = _startPoint.y;
		_dragObject.correct = false;
		_dragObject.enableInput();
		
		_finished.visible = false;
	}
	
	public function hitTest(pos:Point):Boolean {
		return _hitObject.Content.hitTestPoint(pos.x, pos.y);
	}
	
	public function destroy():void {
		_dragObject.destroy();
		_hitObject.destroy();
		_dragObject = null;
		_hitObject = null;
		_finished = null;
		_startPoint = null;
	}
}

}