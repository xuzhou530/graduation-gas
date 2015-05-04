function previous(){
	document.getElementById('second').className="line line2";
	document.getElementById('third').className="line line2";
	document.getElementById('table1').style.display="block";
	document.getElementById('table2').style.display="none";
	document.getElementById('btn-next').disabled = false;
}
function next(){
	document.getElementById('second').className = "line line1";
	document.getElementById('third').className = "line line1";
	document.getElementById('table1').style.display = "none";
	document.getElementById('table2').style.display = "block";
	document.getElementById('btn-next').disabled = true;
}
function complete(){
	var texts = document.getElementsByClassName("txt");
	var flag = 0;
	for(var i=0; i<texts.length; i++){
		if(texts[i].value.length == 0){
			flag = 1;
			alert(i);
			break;
		}
	}
	
	if(flag == 1){
		alert("您的输入内容不完整!");
		return false;
	}
	else{
		document.getElementById('forth').className="line line1";
		document.getElementById('btn-next').disabled = true;
		document.getElementById('btn-previous').disabled = true;
		return true;
	}
}
