/******************************************************************************
Function: validateRegForm
Parameters: none
Return: true or false
Description: Validate the form for emptiness.
******************************************************************************/
function validateRegForm()
{
    var regForm = window.document.RegisterForm;
    var name = regForm.username.value;
    var pwd = regForm.password.value;
    var rPwd = regForm.repassword.value;
    if (isEmpty(name)) {
        reportStatus(907);
        return false;
    }
    else {
        if (name.length < 1 || name.length > 32) {
            reportStatus(914);
            return false;
        }
        if (!isLegalCharacters(name)) {
            reportStatus(903);
            return false;
        }
    }
    if (isEmpty(pwd)) {
        reportStatus(904);
        return false;
    }
    else {
        if (pwd.length < 6 || pwd.length > 16) {
            reportStatus(905);
            return false;
        }
        if (!isLegalCharacters(pwd)) {
            reportStatus(906);
            return false;
        }

    }
    if (isEmpty(rPwd)) {
        reportStatus(908);
        return false;
    }
    else {
        if (rPwd.length < 6 || rPwd.length > 16) {
            reportStatus(909);
            return false;
        }
        if (!isLegalCharacters(rPwd)) {
            reportStatus(910);
            return false;
        }
    }
    if (pwd != rPwd) {
        reportStatus(911);
        regForm.password.value ="";
        regForm.repassword.focus();
        return false;
    }

    return true;
}


/******************************************************************************
Function: validateChangeForm
Parameters: none
Return: true or false
Description: Validate the form for emptiness.
******************************************************************************/
function validateChangeForm() {
    var oP = $("#SuperDog_oldPwd").val();
    var nP = $("#SuperDog_newPwd").val();
    var rP = $("#SuperDog_retypePwd").val();

    if (isEmpty(oP)) {
    	alertStatus(912);
        return false;
    }
    else {
        if (oP.length < 6 || oP.length > 16) {
        	alertStatus(905);
            return false;
        }
        if (!isLegalCharacters(oP)) {
        	alertStatus(906);
            return false;
        }
    }
    if (isEmpty(nP)) {
    	alertStatus(913);
        return false;
    }
    else {
        if (nP.length < 6 || nP.length > 16) {
        	alertStatus(905);
            return false;
        }
        if (!isLegalCharacters(nP)) {
        	alertStatus(906);
            return false;
        }
    }
    if (isEmpty(rP)) {
    	alertStatus(913);
        return false;
    }
    else {
        if (rP.length < 6 || rP.length > 16) {
        	alertStatus(905);
            return false;
        }
        if (!isLegalCharacters(rP)) {
        	alertStatus(906);
            return false;
        }
    }
    if (nP != rP) {
        alertStatus(911);
        $("#SuperDog_newPwd").val("");
        $("#SuperDog_retypePwd").val("");
        $("#SuperDog_newPwd").focus();
        return false;
    }

    return true;
}

/******************************************************************************
Function: isLegalCharacters
Parameters: string
Return: true or false
Description: Judge the string whether it is legal.
******************************************************************************/
function isLegalCharacters(s)
{
    var str;
    var len;
    var i;
    var c;

    str = new String(s);
    len = str.length;

    for(i=0; i < len; i++) {

        c = str.charAt(i);
        if ( (!(c >= '0' && c <= '9'))
            && (!(c >= 'a' && c <= 'z'))
            && (!(c >= 'A' && c <= 'Z'))
        )
        {
            return false;
        }
    }
    return true;
}

/******************************************************************************
Function: isEmpty
Parameters: string
Return: true or false
Description: Judge the string whether it is empty.
******************************************************************************/
function isEmpty(strValue)
{
    var myString = new String(strValue);
    var len = myString.length;
    if ("" == myString)
    {
        return true;
    }
    for (var i=0; i < len; ++i)
    {
        if(myString.charAt(i) != " ")
        {
            return false;
        }
    }
    return true;
}

/******************************************************************************
Function: getChallenge
Parameters: none
Return: challenge
Description: Send XMLHttpRequest get challenge.
******************************************************************************/
function getChallenge()
{
	var challenge = sendRequest("Auth?func=getChallenge");
	return ""+challenge+"";
}

/******************************************************************************
Function: getAuthCode
Parameters: none
Return: authCode
Description: Send XMLHttpRequest get authCode.
******************************************************************************/
function getAuthCode()
{	
	var authCode;
	authCode = sendRequest("ConfigInfo?data=AuthCode");
	return ""+authCode+"";

}

/**********************************************************************************************
Function: doAuth
Parameters: dogID, result
Description: Send XMLHttpRequest do authenticate.
***********************************************************************************************/
function doAuth(dogid, result)
{
	var ret = sendRequest("Auth?func=Authentication&dogid="+dogid+"&result="+result+"");
	return ret;
}

/******************************************************************************
Function: sendRequest
Parameters: url
Return: response text
Description: Send XMLHttpRequest
******************************************************************************/
function sendRequest(url)
{
	var httpRequest = false;
	
  	if(window.XMLHttpRequest)
  	{
    	httpRequest = new XMLHttpRequest();
	}
	else
	{
		try
		{	
			httpRequest = new ActiveXObject("Msxm12.XMLHTTP");
		}
		catch(e)
		{
			try
			{
				httpRequest = new ActiveXObject("Microsoft.XMLHTTP");
			}
			catch(e)
			{
			}
		}
	}
	
	if(!httpRequest)
	{
		return false;
	}
	
	httpRequest.open('POST', url, false);
	httpRequest.send(null);
	var xmlText = httpRequest.responseText;
	var reg = /[^\[][^\]]*[^\]]/;
	var newXmlText = reg.exec(xmlText);
	return newXmlText;
}

/******************************************************************************
Function: getAuthObject
Parameters: none
Return: an object for authentication
Description: get object for authentication
******************************************************************************/
function getAuthObject() {
    var objAuth;
    if (window.ActiveXObject || "ActiveXObject" in window) //IE
    {
        objAuth = document.getElementById("AuthIE");
    }
    else if ( (navigator.userAgent.indexOf("Chrome") > 0) || (navigator.userAgent.indexOf("Firefox") > 0) ) {
        objAuth = getAuthObjectChrome();
    }
    else {
        objAuth = document.getElementById("AuthNoIE");
    }

    return objAuth;
}

/******************************************************************************
Function: embedTag
Parameters: none
Return: none
Description: embed tag of object for authentication
******************************************************************************/
function embedTag() {
    if (window.ActiveXObject || "ActiveXObject" in window) {//IE
        ;
    }
    else if ( (navigator.userAgent.indexOf("Chrome") > 0) || (navigator.userAgent.indexOf("Firefox") > 0) ) {//Chrome or Firefox
        ;
    }
    else {
        var temp = document.body.innerHTML;
        var tag = "<embed id=\"AuthNoIE\" type=\"application/x-dogauth\" width=0 height=0 hidden=\"true\"></embed>";
        document.body.innerHTML = tag + temp;
    }
}

/******************************************************************************
Function: clearInfo
Parameters: none
Return: none
Description: Clear the error info displayed in page.
******************************************************************************/
function clearInfo() {
     document.getElementById("errorinfo").innerHTML = "";
}

/******************************************************************************
Function: reportStatus
Parameters: status
Return: Description
Description: Report status's description.
******************************************************************************/
function reportStatus(status) {
    var text = "Unknown status code";
    switch (status) {
        case 0: text = "Success";
            break;
        case 1: text = "Request exceeds data file range";
            break;
        case 3: text = "System is out of memory";
            break;
        case 4: text = "Too many open login sessions";
            break;
        case 5: text = "Access denied";
            break;
        case 7: text = "Required SuperDog not found";
            break;
        case 8: text = "Encryption/decryption data length is too short";
            break;
        case 9: text = "Invalid input handle";
            break;
        case 10: text = "Specified File ID not recognized by API";
            break;
        case 15: text = "Invalid XML format";
            break;
        case 18: text = "SuperDog to be updated not found";
            break;
        case 19: text = "Invalid update data";
            break;
        case 20: text = "Update not supported by SuperDog";
            break;
        case 21: text = "Update counter is set incorrectly";
            break;
        case 22: text = "Invalid Vendor Code passed";
            break;
        case 24: text = "Passed time value is outside supported value range";
            break;
        case 26: text = "Acknowledge data requested by the update, however the ack_data input parameter is NULL";
            break;
        case 27: text = "Program running on a terminal server";
            break;
        case 29: text = "Unknown algorithm used in V2C file";
            break;
        case 30: text = "Signature verification failed";
            break;
        case 31: text = "Requested Feature not available";
            break;
        case 33: text = "Communication error between API and local SuperDog License Manager";
            break;
        case 34: text = "Vendor Code not recognized by API";
            break;
        case 35: text = "Invalid XML specification";
            break;
        case 36: text = "Invalid XML scope";
            break;
        case 37: text = "Too many SuperDog currently connected";
            break;
        case 39: text = "Session was interrupted";
            break;
        case 41: text = "Feature has expired";
            break;
        case 42: text = "SuperDog License Manager version too old";
            break;
        case 43: text = "USB error occurred when communicating with a SuperDog";
            break;
        case 45: text = "System time has been tampered with";
            break;
        case 46: text = "Communication error occurred in secure channel";
            break;
        case 50: text = "Unable to locate a Feature matching the scope";
            break;
        case 54: text = "The values of the update counter in the file are lower than those in the SuperDog";
            break;
        case 55: text = "The first value of the update counter in the file is greater than the value in the SuperDog";
            break;
        case 400: text = "Unable to locate dynamic library for API";
            break;
        case 401: text = "Dynamic library for API is invalid";
            break;
        case 500: text = "Object incorrectly initialized";
            break;
        case 501: text = "Invalid function parameter";
            break;
        case 502: text = "Logging in twice to the same object";
            break;
        case 503: text = "Logging out twice of the same object";
            break;
        case 525: text = "Incorrect use of system or platform";
            break;
        case 698: text = "Requested function not implemented";
            break;
        case 699: text = "Internal error occurred in API";
            break;
        case 802: text = "Parameter error";
            break;
        case 803: text = "Verify password failed";
            break;
        case 804: text = "Modify password failed";
            break;
        case 810: text = "Password's length is wrong";
            break;
        case 811: text = "Name's length is wrong";
            break;
        case 812: text = "Info's length is wrong";
            break;
        case 813: text = "Name's length is wrong";
            break;
        case 814: text = "Parameter error";
            break;
        case 820: text = "Hardware internal error!";
            break;
        case 821: text = "Parameter error";
            break;
        case 822: text = "Need to verify Password";
            break;
        case 823: text = "Verify password failed";
            break;
        case 824: text = "Need to initialize";
            break;
        case 825: text = "Password has been locked";
            break;
        case 831: text = "Verify password failed, you still have 14 chances";
            break;
        case 832: text = "Verify password failed, you still have 13 chances";
            break;
        case 833: text = "Verify password failed, you still have 12 chances";
            break;
        case 834: text = "Verify password failed, you still have 11 chances";
            break;
        case 835: text = "Verify password failed, you still have 10 chances";
            break;
        case 836: text = "Verify password failed, you still have 9 chances";
            break;
        case 837: text = "Verify password failed, you still have 8 chances";
            break;
        case 838: text = "Verify password failed, you still have 7 chances";
            break;
        case 839: text = "Verify password failed, you still have 6 chances";
            break;
        case 840: text = "Verify password failed, you still have 5 chances";
            break;
        case 841: text = "Verify password failed, you still have 4 chances";
            break;
        case 842: text = "Verify password failed, you still have 3 chances";
            break;
        case 843: text = "Verify password failed, you still have 2 chances";
            break;
        case 844: text = "Verify password failed, you still have 1 chance";
            break;
        case 845: text = "Password has been locked";
            break;
        case 901: text = "Authenticate failed";
            break;
        case 902: text = "Generate challenge string failed";
            break;
        case 903: text = "Name is illegal";
            break;
        case 904: text = "Please enter your password";
            break;
        case 905: text = "Password's length should be between 6-16 characters";
            break;
        case 906: text = "Password is illegal";
            break;
        case 907: text = "Please enter your user name";
            break;
        case 908: text = "Please enter your confirm password";
            break;
        case 909: text = "Confirm password's length should be between 6-16 characters";
            break;
        case 910: text = "Password is illegal";
            break;
        case 911: text = "Passwords do not match";
            break;
        case 912: text = "Please enter your current password";
            break;
        case 913: text = "Please enter your new password";
            break;
        case 914: text = "Name length should be between 1-32 characters";
            break;
        case 915: text = "The SuperDog has been registered";
            break;
        case 916: text = "no dog_auth_srv in java.library.path";
            break;
        case 917: text = "Fail to get challenge";
            break;
        case 918: text = "Fail to get challenge";
            break;
        case 919: text = "Cannot find session file! Please confirm you have created session folder and set the folder path!";
            break;
        case 920: text = "Fail to load the library: dog_auth_srv_php.dll! Please confirm that your configuration file is right.";
            break;

    }
     document.getElementById("errorinfo").innerHTML = text + " (" + status + ")\n";
}

function TextExit(Msg){
    swal({
        title : Msg,
        text : "",
        type : "warning",
        showCloseButton : false,
        allowOutsideClick : false,
        showConfirmButton : true,
    });
}

/******************************************************************************
Function: alertStatus
Parameters: status
Return: Description
Description: Report status's description.
******************************************************************************/
function alertStatus(status) {
    var text = "Unknown status code";
    switch (status) {
        case 0: text = "Success";
            break;
        case 1: text = "??????????????????????????????";
            break;
        case 3: text = "??????????????????";
            break;
        case 4: text = "???????????????????????????";
            break;
        case 5: text = "????????????";
            break;
        case 7: text = "???????????????????????????";
            break;
        case 8: text = "????????????????????????";
            break;
        case 9: text = "?????????????????????";
            break;
        case 10: text = "API???????????????????????????ID ";
            break;
        case 15: text = " XML???????????? ";
            break;
        case 18: text = "??????????????????????????????";
            break;
        case 19: text = "??????????????????";
            break;
        case 20: text = "????????????????????????";
            break;
        case 21: text = "??????????????????????????????";
            break;
        case 22: text = "??????????????????????????????";
            break;
        case 24: text = "??????????????????????????????????????????";
            break;
        case 26: text = "????????????????????????????????????ACK U????????????????????????";
            break;
        case 27: text = "????????????????????????????????????";
            break;
        case 29: text = "v2c??????????????????????????????";
            break;
        case 30: text = "??????????????????";
            break;
        case 31: text = "????????????????????????";
            break;
        case 33: text = "API?????????????????????????????????????????????????????????";
            break;
        case 34: text = "API???????????????????????????";
            break;
        case 35: text = "XML????????????";
            break;
        case 36: text = "XML????????????";
            break;
        case 37: text = "??????????????????????????????";
            break;
        case 39: text = "???????????????";
            break;
        case 41: text = "???????????????";
            break;
        case 42: text = "???????????????????????????????????????";
            break;
        case 43: text = "???????????????????????????USB??????";
            break;
        case 45: text = "?????????????????????";
            break;
        case 46: text = "?????????????????????????????????";
            break;
        case 50: text = "????????????????????????????????????";
            break;
        case 54: text = "??????????????????????????????????????????????????????";
            break;
        case 55: text = "???????????????????????????????????????????????????????????????";
            break;
        case 400: text = "?????????API????????????";
            break;
        case 401: text = "API??????????????????";
            break;
        case 500: text = "????????????????????????";
            break;
        case 501: text = "??????????????????";
            break;
        case 502: text = "????????????????????????";
            break;
        case 503: text = "????????????????????????";
            break;
        case 525: text = "???????????????????????????";
            break;
        case 698: text = "????????????????????????";
            break;
        case 699: text = "API?????????????????????";
            break;
        case 802: text = "????????????";
            break;
        case 803: text = "??????????????????";
            break;
        case 804: text = "??????????????????";
            break;
        case 810: text = "??????????????????";
            break;
        case 811: text = "??????????????????";
            break;
        case 812: text = "??????????????????";
            break;
        case 813: text = "??????????????????";
            break;
        case 814: text = "????????????";
            break;
        case 820: text = "??????????????????";
            break;
        case 821: text = "????????????";
            break;
        case 822: text = "??????????????????";
            break;
        case 823: text = "??????????????????";
            break;
        case 824: text = "???????????????";
            break;
        case 825: text = "???????????????";
            break;
        case 831: text = "???????????????????????????14?????????";
            break;
        case 832: text = "???????????????????????????13?????????";
            break;
        case 833: text = "???????????????????????????12?????????";
            break;
        case 834: text = "???????????????????????????11?????????";
            break;
        case 835: text = "???????????????????????????10?????????";
            break;
        case 836: text = "???????????????????????????9?????????";
            break;
        case 837: text = "???????????????????????????8?????????";
            break;
        case 838: text = "???????????????????????????7?????????";
            break;
        case 839: text = "???????????????????????????6?????????";
            break;
        case 840: text = "???????????????????????????5?????????";
            break;
        case 841: text = "???????????????????????????4?????????";
            break;
        case 842: text = "???????????????????????????3?????????";
            break;
        case 843: text = "???????????????????????????2?????????";
            break;
        case 844: text = "???????????????????????????1?????????";
            break;
        case 845: text = "???????????????";
            break;
        case 901: text = "??????????????????";
            break;
        case 902: text = "???????????????????????????";
            break;
        case 903: text = "????????????";
            break;
        case 904: text = "???????????????";
            break;
        case 905: text = "?????????????????????6-16???????????????";
            break;
        case 906: text = "???????????????";
            break;
        case 907: text = "????????????????????????";
            break;
        case 908: text = "?????????????????????";
            break;
        case 909: text = "???????????????????????????6-16???????????????";
            break;
        case 910: text = "???????????????";
            break;
        case 911: text = "???????????????";
            break;
        case 912: text = "?????????????????????";
            break;
        case 913: text = "??????????????????";
            break;
        case 914: text = "?????????????????????1-32???????????????";
            break;
        case 915: text = "????????????????????????";
            break;
        case 916: text = "java.library.path?????????dog_auth_srv";
            break;
        case 917: text = "????????????????????????";
            break;
        case 918: text = "????????????????????????";
            break;
        case 919: text = "????????????????????????????????????????????????????????????????????????????????????";
            break;
        case 920: text = "??????????????????dog_auth_srv_php.dll??????????????????????????????";
            break;

    }
    $("#SuperDog_oldPwd").val("");
    $("#SuperDog_newPwd").val("");
    $("#SuperDog_retypePwd").val("");
    TextExit(text);
}

/**********************************************************************************************
Class: AuthObject
Dynamic prototype method
Description: used for Chrome/Firefox and produced with dynamic prototype method
***********************************************************************************************/
function AuthObject() {

    if (typeof AuthObject._initialized == "undefined") {

        // GetUserNameEx
        AuthObject.prototype.GetUserNameEx = function (scope, authCode) {
            //console.log("enter GetUserNameEx()");
            window.parent.postMessage({ type: "SNTL_FROM_PAGE", text: { "InvokeMethod": "GetUserNameEx", "Scope": scope, "AuthCode": authCode} }, "*");
            return 0;
        };

        // GetDigestEx
        AuthObject.prototype.GetDigestEx = function (scope, authCode, password, challenge) {
            //console.log("enter GetDigestEx()");
            window.parent.postMessage({ type: "SNTL_FROM_PAGE", text: { "InvokeMethod": "GetDigestEx", "Scope": scope, "AuthCode": authCode, "UserPin": password, "Challenge": challenge} }, "*");
            return 0;
        };

        // RegisterUserEx   
        AuthObject.prototype.RegisterUserEx = function (scope, authCode, username, password) {
            //console.log("enter RegisterUserEx()");
            window.parent.postMessage({ type: "SNTL_FROM_PAGE", text: { "InvokeMethod": "RegisterUserEx", "Scope": scope, "AuthCode": authCode, "Name": username, "UserPin": password } }, "*");
            return 0;
        };

        // ChangeUserPinEx
        AuthObject.prototype.ChangeUserPinEx = function (scope, authCode, oldPassword, newPassword) {
            //console.log("enter ChangeUserPinEx()");
            window.parent.postMessage({ type: "SNTL_FROM_PAGE", text: { "InvokeMethod": "ChangeUserPinEx", "Scope": scope, "AuthCode": authCode, "OldPin": oldPassword, "NewPin": newPassword } }, "*");
            return 0;
        };

        // SetUserDataEx
        AuthObject.prototype.SetUserDataEx = function (scope, authCode, password, type, offset, data) {
            //console.log("enter SetUserDataEx()");
            window.parent.postMessage({ type: "SNTL_FROM_PAGE", text: { "InvokeMethod": "SetUserDataEx", "Scope": scope, "AuthCode": authCode, "UserPin": password, "Type": type, "Offset": offset, "Data": data } }, "*");
            return 0;
        };

        // GetUserDataEx
        AuthObject.prototype.GetUserDataEx = function (scope, authCode, type, offset, size) {
            //console.log("enter GetUserDataEx()");
            window.parent.postMessage({ type: "SNTL_FROM_PAGE", text: { "InvokeMethod": "GetUserDataEx", "Scope": scope, "AuthCode": authCode, "Type": type, "Offset": offset, "Size": size } }, "*");
            return 0;
        };

        // EnumDog
        AuthObject.prototype.EnumDog = function (authCode) {
            //console.log("enter EnumDog()");
            window.parent.postMessage({ type: "SNTL_FROM_PAGE", text: { "InvokeMethod": "EnumDog", "AuthCode": authCode} }, "*");
            return 0;
        };

        AuthObject._initialized = true;
    }
}

/**********************************************************************************************
Function: getAuthObjectChrome
Parameters: none
Return: an AuthObject object
Description: get object for authentication used in Chrome and Firefox
***********************************************************************************************/
function getAuthObjectChrome() {
    var obj = new AuthObject();
    return obj;
}
