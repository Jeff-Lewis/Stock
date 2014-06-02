var logger = require('LogOperations');

function xhrGet(url, args, success, error){
    var client = Ti.Network.createHTTPClient({
         // function called when the response data is available
         onload : function(e) {
             logger.logInfo("Received JSON Text: " + this.responseText);
             setCsrf(this.allResponseHeaders);
             var json = JSON.parse(this.responseText);
             success(json);
         },
         // function called when an error occurs, including a timeout
         onerror : function(e) {
             Ti.API.debug(e.error);
             error(e.error);
         },
         timeout : 5000 //in milliseconds
     });
     
     client.setRequestHeader('Content-Type', 'application/json; charset=utf-8'); 
     client.open("GET", url); // Prepare the connection.
     client.send(args);  // Send the request.
     
     logger.logHttpRequest(url, 'GET', args);
};

function xhrPost(url, args, success, error){
    var client = Ti.Network.createHTTPClient({
         // function called when the response data is available
         onload : function(e) {
             logger.logInfo("Received JSON Text: " + this.responseText);
             setCsrf(this.allResponseHeaders);
             var json = JSON.parse(this.responseText);
             success(json);
         },
         // function called when an error occurs, including a timeout
         onerror : function(e) {
             Ti.API.debug(e.error);
             error(e.error);
         },
         timeout : 5000 //in milliseconds
     });
     
     client.setRequestHeader('Content-Type', 'application/json; charset=utf-8');  
     client.open("POST", url); // Prepare the connection.
     client.send(args);  // Send the request.
     
     logger.logHttpRequest(url, 'POST', args);
};

function getUserToken(){
	return Ti.App.Properties.getString('auth');
}

function getUserEmail(){
	return Ti.App.Properties.getString('email');
}

function getCsrf(){
	return Ti.App.Properties.getString('csrf');
}

function setCsrf(headers) {
	var csrf_attr = "X-Csrf-Token";
	var index = headers.indexOf(csrf_attr);
	if (index != -1) {
		headers = headers.substr(index + csrf_attr.length + 1);
		headers = headers.substr(0, headers.indexOf("\n"));
		Ti.App.Properties.setString('csrf', headers);
	}
	else{
		logger.logError("X-Csrf-Token not exists in the header");
		logger.logError("headers = " + headers);
	}
}


exports.xhrGet = xhrGet;
exports.xhrPost = xhrPost;

exports.getUserToken = getUserToken;
exports.getUserEmail = getUserEmail;
exports.getCsrf = getCsrf;
exports.setCsrf = setCsrf;

exports.version = 1.0;
exports.author = 'Chen & Chen';