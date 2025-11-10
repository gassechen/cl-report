
$(document).ready(function(){
    $('.resizable-card')
	.draggable(
	    {
		containment: "#windows-content"
	    })
	.resizable(
	    {
		helper: "ui-resizable-helper"
		
	    })
});

function dragStart(event){};


    
