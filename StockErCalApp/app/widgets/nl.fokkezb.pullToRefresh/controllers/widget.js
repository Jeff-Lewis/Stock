var args = arguments[0] || {};

var options = {
	msgPull: L('ptrPull', 'Pull to refresh...'),
	msgRelease: L('ptrRelease', 'Release to refresh...'),
	msgUpdating: L('ptrUpating', 'Updating...'),
	top: 0
};

var height = 50,
	attached = false,
	pulling = false,
	pulled = false,
	loading = false,
	released = false,
	offset = 0;

// delete special args
delete args.__parentSymbol;
delete args.__itemTemplate;
delete args.$model;

// set args as options
setOptions(args);

// Not in all Alloy versions (1.3.0-cr)
if (__parentSymbol) {
	init();
}

function show(msg) {

	if (!attached || pulled) {
		//TODO
		Ti.API.info("show false");
		return false;
	}

	pulled = true;
	released = false;

	$.view.ptrText.text = msg || options.msgUpdating;
	$.view.ptrArrow.opacity = 0;
	$.view.ptrIndicator.show();
	$.view.prtCenter.show();

	if (OS_IOS) {

		// __parentSymbol.setContentInsets({
			// top: options.top + height
		// }, {
			// animated: true
		// });
// 		
		// __parentSymbol.scrollToTop(options.top + height, {
			// animated: true,
			// duration: 250
		// });

	} else {
		__parentSymbol.scrollToTop(0, {
			animated: true,
			duration: 250
		});
	}
	
	//TODO
	Ti.API.info("show true");

	return true;
}

function hide() {

	if (!attached || !pulled) {
		//TODO
		Ti.API.info("hide false");
		return false;
	}

	$.view.ptrIndicator.hide();
	$.view.ptrArrow.transform = Ti.UI.create2DMatrix();
	$.view.ptrArrow.opacity = 1;
	$.view.ptrText.text = options.msgPull;

	if (OS_IOS) {

		// __parentSymbol.setContentInsets({
			// top: options.top
		// }, {
			// animated: true,
			// duration: 250
		// });

		__parentSymbol.scrollToTop(options.top, {animated: true, duration: 250});
	} else {
		// __parentSymbol.animate({
			// top: 0 + height,
			// duration: 2500
		// });
		
		__parentSymbol.scrollToTop(1, {animated: true, duration: 250});
	}

	// setTimeout(function () {
		// $.view.prtCenter.hide();
		// //TODO
		// Ti.API.info("hide timeout true");
	// }, 2500);

	pulled = false;
	loading = false;
	
	//TODO
	Ti.API.info("hide true");

	return true;
}

function refresh() {

	if (!attached || loading) {
		//TODO
		Ti.API.info("refresh false");
		return false;
	}

	loading = true;

	show();

	$.trigger('release', {
		hide: hide
	});
	
	//TODO
	Ti.API.info("refresh true");

	return true;
}

function scrollListener(e) {

	// Closes #17
	if (e.source !== __parentSymbol) {
		//TODO
		Ti.API.info("scroll false");
		return;
	}
	
	//TODO
	Ti.API.info("scroll true");

	if (OS_IOS) {

		if (pulled) {
			return;
		}

		offset = e.contentOffset.y;

		if (pulling && !loading && offset > 0 - options.top - height) {
			pulling = false;
			var unrotate = Ti.UI.create2DMatrix();
			$.view.ptrArrow.animate({
				transform: unrotate,
				duration: 180
			});
			$.view.ptrText.text = options.msgPull;

		} else if (!pulling && !loading && offset <= 0 - options.top - height) {
			pulling = true;
			var rotate = Ti.UI.create2DMatrix().rotate(180);
			$.view.ptrArrow.animate({
				transform: rotate,
				duration: 180
			});
			$.view.ptrText.text = options.msgRelease;
		}

	} else {
		offset = e.firstVisibleItem;
		//TODO
		Ti.API.info("offset = " + offset);
		
		if (pulled) {
			return;
		}

		if (offset > 0){
			pulling = true;
		}
		
		if (pulling && !loading && !released && offset == 0) {
			//TODO
			Ti.API.info("pull to refresh");
			
			var unrotate = Ti.UI.create2DMatrix();
			$.view.ptrArrow.animate({
				transform: unrotate,
				duration: 180
			});
			$.view.ptrText.text = options.msgPull;
			
			setTimeout(function(){pulling = false;}, 180);

		} else if (!pulling && !loading && offset <= 0) {
			//TODO
			Ti.API.info("release to refresh");
			pulling = true;
			released = true;
			var rotate = Ti.UI.create2DMatrix().rotate(180);
			$.view.ptrArrow.animate({
				transform: rotate,
				duration: 180
			});
			$.view.ptrText.text = options.msgRelease;
		}
	}

	return;
}

function dragEndListener(e) {

	// Closes #17
	if (e.source !== __parentSymbol) {
		//TODO
		Ti.API.info("drag end false");
		return;
	}

	if (!pulled && pulling && !loading && offset <= 0 - options.top - height) {
		pulling = false;
		
		//TODO
		Ti.API.info("drag end true");
		//TODO
		Ti.API.info("offset = " + offset + " options.top = " + options.top + " height = " + height);

		refresh();
	}

	return;
}

function swipeListener(e) {
	Ti.API.info("swipe offset = " + offset + " direction = " + e.direction);
	if ((offset === 0 && e.direction === 'down') || released) {
		//TODO
		Ti.API.info("swipe true");
		refresh();
	}

	return;
}

function setOptions(_options) {
	_.extend(options, _options);

	return;
}

function attach() {

	if (attached) {
		return false;
	}

	if (OS_IOS) {
		__parentSymbol.headerPullView = $.view.ptr;
	}

	init();

	return true;
}

function init(_table) {
	//TODO
	Ti.API.info("init true");
	
	// Override __parentSymbol
	if (_table) {
		//TODO
		Ti.API.info("init __parentSymbol true");
		__parentSymbol = _table;
	}
	else{
		return;
	}
	__parentSymbol.addEventListener('scroll', scrollListener);
	height = $.view.ptr.height;
	attached = true;
	pulling = false;
	pulled = false;
	loading = false;

	offset = 0;

	if (OS_IOS) {
		__parentSymbol.addEventListener('dragEnd', dragEndListener);

	} else {
		__parentSymbol.scrollToTop(0, {animated: true});

		__parentSymbol.addEventListener('swipe', swipeListener);
	}

	$.view.ptrText.text = options.msgPull;
	$.view.prtCenter.show();
	
	return;
}

function dettach() {

	if (!attached) {
		return false;
	}

	__parentSymbol.removeEventListener('scroll', scrollListener);

	if (OS_IOS) {
		__parentSymbol.removeEventListener('dragEnd', dragEndListener);

		__parentSymbol.headerPullView = null;

	} else {
		__parentSymbol.removeEventListener('swipe', swipeListener);

		hide();
	}

	attached = false;

	return true;
}

exports.setOptions = setOptions;
exports.show = show;
exports.hide = hide;
exports.refresh = refresh;
exports.dettach = dettach;
exports.attach = attach;
exports.init = init;