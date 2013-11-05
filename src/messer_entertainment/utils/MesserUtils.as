package messer_entertainment.utils {
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Daniel 'MesSer' Dahlkvist
	 */
	public class MesserUtils {
		
		public function MesserUtils() {
		}
		
		public static function destroy(mc:MovieClip):* {
			recursiveStopMovies(mc);
			if (mc && mc.parent) {
				mc.parent.removeChild(mc);
			}
			return null;
		}
		
		public static function recursiveStopMovies(mc:MovieClip):void {
			if (!mc) return;
			mc.stop();
			var ln:int = mc.numChildren;
			var child:MovieClip;
			for (var i:int = 0; i < ln; ++i) {
				child = mc.getChildAt(i) as MovieClip;
				if (child) {
					child.stop();
					recursiveStopMovies(child);
				}
			}
		}
		
		public static function recursiveDisableInput(mc:MovieClip):void {
			if (!mc) return;
			mc.mouseEnabled = false;
			mc.mouseChildren = false;
			mc.enabled = false;
			var ln:int = mc.numChildren;
			var child:MovieClip;
			for (var i:int = 0; i < ln; ++i) {
				child = MovieClip(mc.getChildAt(i));
				child.mouseChildren = false;
				child.mouseEnabled = false;
				child.enabled = false;
				if (child) {
					recursiveDisableInput(child);
				}
			}
		}
		
		public static function recursiveEnableInput(mc:MovieClip):void {
			if (!mc) return;
			parent = mc;
			var parent:MovieClip;
			while (parent != null) {
				parent.mouseEnabled = true;
				parent.mouseChildren = true;
				parent.enabled = true;
				parent = MovieClip(parent.parent);
			}
		}
		
	}

}