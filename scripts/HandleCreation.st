Gofer new
	squeaksource: 'Handle';
	package: 'Handles';
	load.
	
Smalltalk recreateSpecialObjectsArrayForHandles.

(Smalltalk saveAs: 'HandlesImage.image') 
	ifFalse: [ Smalltalk snapshot: false andQuit: true ]
