window.onload = function() {
    var layout = document.getElementById("layout");
    var box = document.getElementById("box");
    var closed = document.getElementById("closed");
    var closedbuttons = document.getElementsByClassName("closed-btn");
    for (var i=0; i<closedbuttons.length; i++) {
    	closedbuttons[i].onclick = function() { 
            layout.style.display = "none"; 
            box.style.display = "none"; 
            return false;
        }
    }  
    closed.onclick = layout.onclick = function() { 
        layout.style.display = "none"; 
        box.style.display = "none"; 
    }
    layout.style.height = window.screen.height;
}	