var dom = fl.getDocumentDOM();
var selectionCount = dom.selection.length;

for (var i = 0; i < selectionCount; i++)
{
	var selectedItem = fl.getDocumentDOM().selection[i];
	var newX = selectedItem.width / 2;
	var newY = selectedItem.height / 2;
	fl.trace("moving registration point for item " + selectedItem.name);
	selectedItem.setTransformationPoint({x:newX, y:newY});
}