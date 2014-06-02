var constants = require('Constants');
var logger = require('LogOperations');
var common = require('CommonOperations');

function parseProfile(json){
	var profile = Alloy.createModel('profile', {
	   	id: json.id,
	    beat: json.beat,
	    miss: json.miss,
	    rank: json.rank,
	    success: json.success,
	    failure: json.failure,
	    userId: json.user_id,
	    bullism: json.bullism,
	    username: json.username,
	    avatar: json.imageUrl,
	    createdAt: json.created_at
	});
	
	return profile;
}

function parseTweet(json){
	var tweet = Alloy.createModel('tweet', {
	   	id: json.id,
	    content: json.content,
	    image: json.mediumImageUrl,
	    cmtCount: 0,
	    stockId: json.stock_Id,
	    erdateId: json.erdate_Id,
	    userId: json.user_Id,
	    createdAt: json.created_at
	});
	
	return tweet;
}

exports.parseProfile = parseProfile;
exports.parseTweet = parseTweet;

exports.version = 1.0;
exports.author = 'Chen & Chen';