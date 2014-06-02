var constants = require('Constants');
var logger = require('LogOperations');
var common = require('CommonOperations');
var parser = require('ModelParser');

function addLatestTweetsByStock(lastUpdatedAt, stock, updateUIHandler, handlerArgs){
	var url = constants._.host + '/getNextTweetsByStock';
	if (lastUpdatedAt == null || lastUpdatedAt == ''){
		lastUpdatedAt = '20010101 000001';
	}
	var number = 30;
	//TODO replace id to real one
	var args = {'stockId' : 1, 'date' : lastUpdatedAt, 'num' : 30};
	common.xhrGet(
		url, 
		args, 
		function(json){
			if (json.status == 'true'){
				logger.logInfo(json.message);
				
				var tweets = [];
				
				for(var i = 0; i < json.data.length; i++) {
					var tweet = parser.parseTweet(json.data[i].tweet);
					tweets.unshift(tweet); 
					tweet.save();
					
					var profile = parser.parseProfile(json.data[i].profile);
					profile.save();
				}
				
				updateUIHandler(tweets, handlerArgs);
			}
			else{
				logger.logError(json.message);
			}
		}, 
		logger.logError);
}

function addPreviousTweetsByStock(lastUpdatedAt, stock, updateUIHandler, handlerArgs){
	var url = constants._.host + '/getPreviousTweetsByStock';
	if (lastUpdatedAt == null || lastUpdatedAt == ''){
		lastUpdatedAt = '20010101 000001';
	}
	var number = 30;
	//TODO replace id to real one
	var args = {'stockId' : 1, 'date' : lastUpdatedAt, 'num' : 30};
	common.xhrGet(
		url, 
		args, 
		function(json){
			if (json.status == 'true'){
				logger.logInfo(json.message);
				
				var tweets = [];
				
				for(var i = 0; i < json.data.length; i++) {
					var tweet = parser.parseTweet(json.data[i].tweet);
					tweets.push(tweet); 
					tweet.save();
					
					var profile = parser.parseProfile(json.data[i].profile);
					profile.save();
				}
				
				updateUIHandler(tweets, handlerArgs);
			}
			else{
				logger.logError(json.message);
			}
		}, 
		logger.logError);
}

exports.addLatestTweetsByStock = addLatestTweetsByStock;
exports.addPreviousTweetsByStock = addPreviousTweetsByStock;
exports.version = 1.0;
exports.author = 'Chen & Chen';