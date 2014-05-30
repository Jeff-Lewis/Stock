// TODO: Internationalization

var args = arguments[0] || {};

// Based on: http://ejohn.org/blog/javascript-pretty-date/
function prettyDate(time){
	var date = new Date((time || "").replace(/-/g,"/").replace(/[TZ]/g," ")),
		diff = (((new Date()).getTime() - date.getTime()) / 1000),
		day_diff = Math.floor(diff / 86400);
			
	if ( isNaN(day_diff) || day_diff < 0 || day_diff >= 31 )
		return;
			
	return day_diff == 0 && (
			diff < 60 && Math.ceil(diff) + " secs" ||
			diff == 60 && "1 sec" ||
			diff < 3600 && Math.floor( diff / 60 ) + " mins" ||
			diff < 7200 && "1 hour" ||
			diff < 86400 && Math.floor( diff / 3600 ) + " hours") ||
		day_diff == 1 && "1 day" ||
		day_diff + " days";
}

Ti.API.info('image url = ' + args.get('image'));

$.image.image = args.get('image');
$.name.text = args.get('userId');
$.time.text = prettyDate(args.get('createdAt').toString());
$.text.text = args.get('content');
$.row.data = JSON.stringify(args);
Ti.API.info('tweet row loaded');
