package messer_entertainment.puzzles.pig {
import flash.display.MovieClip;
import flash.events.TouchEvent;
import flash.filters.GlowFilter;
import flash.geom.ColorTransform;

public class DraggableObject extends GameObject {
	private var _glowFilter:GlowFilter;
	
	public function DraggableObject(content:MovieClip, id:Number) {
		super(content, id);
		_glowFilter = new GlowFilter(0x000000, 1, 15, 15, 3.25, 3);
	}
	
	override public function set correct(value:Boolean):void {
		if (!_correct && value) {
			_content.transform.colorTransform = new ColorTransform(1, 1, 1, 1);
		} else if (_correct && !value) {
			_content.transform.colorTransform = new ColorTransform(0.3, 0.3, 0.3, 0.8);
		}
		super.correct = value;
	}
	
	override public function startDrag():void {
		_content.filters = [_glowFilter];
		super.startDrag();
	}
	
	override public function stopDrag():void {
		_content.filters = [];
		super.stopDrag();
	}
	
	override public function destroy():void {
		_glowFilter = null;
		super.destroy();
	}
}

}