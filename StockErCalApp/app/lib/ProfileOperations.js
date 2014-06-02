var logger = require('LogOperations');

function getProfileByUserId(userId, success){
	var profile = Alloy.createModel('profile', {userId: userId});
	profile.fetch({
	    success: function(profiles, response, options) {
	    	logger.logInfo("fetch profile = " + JSON.stringify(profiles));
	        success(profiles.get('0'));
	    },
	    error: function(profiles, response, options){
	    	logger.logError("fetch profile error userId = " + userId);
	    	logger.logError(response.responseText);
	    }
	});
}

exports.getProfileByUserId = getProfileByUserId;

exports.version = 1.0;
exports.author = 'Chen & Chen';