function logInfo(info){
	Ti.API.info(info);
}

function logWarn(warn){
	Ti.API.warn(warn);
}

function logError(error){
	Ti.API.error(error);
}

function logException(e){
	Ti.API.error("An Error:[" + e.message + "] has occured in line " + e.line + " \nsourceID:"+e.sourceId+"\nsourceURL:"+e.sourceURL);
	Ti.API.error(JSON.stringify(e));
}

function logHttpRequest(url, action, args){
	Ti.API.info("Send " + action + " request to " + url);
	Ti.API.info("With args = " + JSON.stringify(args));
}

exports.logInfo = logInfo;
exports.logWarn = logWarn;
exports.logError = logError;
exports.logException = logException;
exports.logHttpRequest = logHttpRequest;

exports.version = 1.0;
exports.author = 'Chen & Chen';
