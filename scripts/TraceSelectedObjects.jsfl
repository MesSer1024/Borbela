fl.outputPanel.clear();

function traceSelectedObjects() {

    var e = fl.getDocumentDOM().selection;
    if (!e) return;
	
	fl.trace("e=" + e);
	fl.trace("e.length=" + e.length);
}

traceSelectedObjects();