window.onload = initMenu;

function initMenu() {
    var theUL = document.getElementById("navigation").getElementsByTagName("ul")[0];
    var theULChilds = theUL.childNodes;
	for (var i = 0; i < theULChilds.length; i++) {
		if (theULChilds[i].tagName == "LI") {
			var theLINode = theULChilds[i];
			if (theLINode.getElementsByTagName("LI").length > 0) {
			 setMouseActions(theLINode); 
				theLINode.firstChild.className = "downMenu";
			   }
		 }
   }
   
   	var Ptr=document.getElementById("maintable").getElementsByTagName("tr");
    for (i=1;i<Ptr.length+1;i++) { 
    	Ptr[i-1].className = (i%2>0)?"t1":"t2"; 
    }
	for(var i=0;i<Ptr.length;i++) {
	    Ptr[i].onmouseover=function(){
	    	this.tmpClass=this.className;
	    	this.className = "t3";    
	    };
	    Ptr[i].onmouseout=function(){
	    	this.className=this.tmpClass;
	    };
	}
}

function setMouseActions(node) {
   node.onmouseover = function() {
	   this.getElementsByTagName("ul")[0].style.display = "block";
   };

   node.onmouseout = function() {
	   this.getElementsByTagName("ul")[0].style.display = "none";
   };
} 