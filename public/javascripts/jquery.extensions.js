// ------------------------------------
// Jquery extensions and helpers
// ------------------------------------

$(function(){
	Function.prototype.forEach = function(object, block, context) {
	  for (var key in object) {
	    if (typeof this.prototype[key] == "undefined") {
	      block.call(context, object[key], key, object);
	    }
	  }
	};

	var forEach = function(object, block, context) {
	  if (object) {
	    var resolve = Object; // default
	    if (object instanceof Function) {
	      // functions have a "length" property
	      resolve = Function;
	    } else if (object.forEach instanceof Function) {
	      // the object implements a custom forEach method so use that
	      object.forEach(block, context);
	      return;
	    } else if (typeof object.length == "number") {
	      // the object is array-like
	      resolve = Array;
	    }
	    resolve.forEach(object, block, context);
	  }
	};

	jQuery.extend(String.prototype, {
	  databaseId: function() { return $.trim(this.split('_').last()); }
	});

	jQuery.extend(Array.prototype, {
	  last: function() { return this[this.length - 1]; }
	});

	jQuery.authenticity_token = function() {
	  return window._authenticity_token;
	};

	if (typeof console === 'undefined') {
		console = {
			"assert"     : Function.empty,
			"count"      : Function.empty,
			"debug"      : Function.empty,
			"dir"        : Function.empty,
			"dirxml"     : Function.empty,
			"error"      : Function.empty,
			"group"      : Function.empty,
			"groupEnd"   : Function.empty,
			"info"       : Function.empty,
			"log"        : Function.empty,
			"profile"    : Function.empty,
			"profileEnd" : Function.empty,
			"time"       : Function.empty,
			"timeEnd"    : Function.empty,
			"trace"      : Function.empty,
			"warn"       : Function.empty
		};
	}

	// FAQ section
	$('#faq').makeFAQ({faqHeader: "h5", indexTitle:"Tweasier FAQ"});
		
});