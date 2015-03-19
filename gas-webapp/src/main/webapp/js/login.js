function checkForm(){
	var username=document.forms["login"]["username"];
	var userpwd=document.forms["login"]["userpwd"];
	var identify=document.forms["login"]["identify"];
	if(username.value=="")
	{
		alert("user name can't empty");
		return false;
	}
	if(identify.value=="")
	{
		alert("check code can't empty");
		return false;
	}
	return true;
}