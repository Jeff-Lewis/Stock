var logger = require('LogOperations');
var profileOperations = require('ProfileOperations');

var args = arguments[0] || {};

function displayProfile(profile){
	$.name.text = profile.username;
	$.header.image = profile.avatar;
}

var tweet = args.content;

var date = new Date(args.createdAt);

Ti.API.info('detail window: ' + tweet + date);
profileOperations.getProfileByUserId(args.userId, displayProfile);

$.image.image = args.image;
$.text.text = tweet;
$.time.text = date.toLocaleDateString();

var data = [];
var comments = Alloy.createCollection('comment');
comments.fetch();

Ti.API.info("comments: " + comments.length);

comments.map(function(comment) {
	// The book argument is an individual model object in the collection
	data.push(Alloy.createWidget('nl.fokkezb.tweetsView', 'row', comment).getView());
});
// TableView object in the view with id = 'table'
$.tableView.setData(data); 

$.ptr.init($.tableView);
$.isComment.init($.tableView);

/**
 * Returns a random integer between min and max
 * Using Math.round() will give you a non-uniform distribution!
 */
function getRandomInt(min, max) {
	return Math.floor(Math.random() * (max - min + 1)) + min;
}