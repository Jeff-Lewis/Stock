var args = arguments[0] || {};

var tweet = args.content;

var date = new Date(args.createdAt);

Ti.API.info('detail window: ' + tweet + date);

$.image.image = args.image;
$.name.text = 'name';
$.user.text = 'userId:' + args.userId;
$.text.text = tweet;
$.time.text = date.toLocaleDateString();

var data = [];
var comments = Widget.createCollection('comment');
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

function myLoader(e){
	
}

function onEndCommentLoader(e) {
	setTimeout(function() {
		// request method here
		Ti.API.info("onEndLoading");

		var tempComments = Widget.createCollection('comment');
		tempComments.fetch();
		var id = getRandomInt(1, 8);
		Ti.API.info('add comment ' + id);
		tempComments = tempComments.filter(function(comment) {
			return comment.get('id') == id;
		});
		tempComments.map(function(comment) {
			data.push(Alloy.createWidget('nl.fokkezb.tweetsView', 'row', comment).getView());
		});

		$.tableView.setData(data);

		e.success();

	}, 1000);

}
