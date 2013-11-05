fl.outputPanel.clear();

function changeRegistrationPoint() {

    var e = fl.getDocumentDOM().selection[0];
    if (!e) return;

	fl.trace("e=" + e);
	fl.trace("size=" + e.width + "," + e.height);

	var centerX = -e.width/2;
	var centerY = -e.height/2;
	var dx = 0;
	var dy = 0;
	// Change the selected items "library item" and reposition all the items in that item's timeline
    var tl = e.libraryItem.timeline;
    var iLen = tl.layers.length;
    for (var i = 0; i < iLen; i++) {
        var l = tl.layers[i];
        fl.trace("Layer: " + l.name);
        var jLen = l.frames.length;
        for (var j = 0; j < jLen; j++) {
            var f = l.frames[j];
            // Don't mess with elements in frames that aren't keyframes...
            if (f.startFrame != j) continue;
            fl.trace("\tFrame: " + (j+1));
            // Loop over each keyframe's elements.
            var kLen = f.elements.length;
            for (var k = 0; k < kLen; k++) {
                // Move the element.
                var child = f.elements[k];
                fl.trace("\t\t" + child + " " + k + " :: " + child.name
                        + "("+child.x+","+child.y+") => ("+(centerX)+","+(centerY)+")");
				dx = child.x - centerX;
				dy = child.y - centerY;
				
                fl.trace("\t\t dx=" + dx + ", dy=" + dy);
				
                child.x = centerX;
                child.y = centerY;
            }
        }
    }
	
    e.x += dx;
    e.y += dy;
}

changeRegistrationPoint();