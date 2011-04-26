	var Tweasier = {
	
	// Helpers
	// could eventually do with finding a live event for this?
	forceExternalLinks : function(){
		// Added an additional scope to links with the class of
		// 'local'. IE will still open a #anchor in a new window even
		// if that link is on the same domain...
		$('a[href^="http://"][class!=local]').attr({
			target: "_blank",
			title: "Opens this link in a new window"
		});
	},
	
	// JSON parser
	parseJSON : function(response){
		return JSON.parse(response);
	},
	
	// Ajax loaders
	showLoader : function(text){
		this.setLoaderText(text);
		$("#loader").show();
	},
	
	setLoaderText : function(text) {
		$("#loader > h4").html(text ? text : "Talking to Twitter");
	},
	
	hideLoader : function(reset){
		if(reset != null && reset === true) this.setLoaderText();
		$("#loader").hide();
	},
	
	// Status functions
	setTop : function(){
		window.scrollTo(0, 0);
	},
	
	disableStatusForm : function(){
		$('#status_form_submit').attr({disabled:"disabled"});
		$('#text').attr({disabled:"disabled"});
	},
	
	enableStatusForm : function(){
		$('#status_form_submit').removeAttr("disabled");
		$('#text').removeAttr("disabled");
	},
	
	setStatusFormLabel : function(label) {
		$('label[for=text]').text(label);
	},
	
	setStatusFormAction : function(path){
		$('#status_form').attr("action", path);
	},
	
	setStatusFormSubmit : function(text){
		$('#status_form_submit').val(text);
	},
	
	setStatusFormHiddenField : function(name, value){
		if($('#status_' + name).val() != null)
			$('#status_' + name).val(value);
		else
			$('#status_form').append("<input type='hidden' name='" + name + "' value='" + value + "' id='status_" + name + "'/>");
	},
	
	setStatusFormFocus : function(text){
		$('#text').focus().val(text);
	},
	
	// Poll form
	setupPollForm : function(){
		// Don't hide the feedback form if the poll isn't available
		if($("#poll_form:visible").length != 0) $("#feedback_form").hide();
	},
	
	showPollResponse : function(response){
		response = this.parseJSON(response);
		$("#poll_form").empty().html("<h3 id='poll_response'>" + response.text + "</h3>");
		// Now show the additional feedback form
		$("#feedback_form").show();
	},
	
	// Feedback form
	showFeedbackResponse : function(response){
		response = this.parseJSON(response);
		$("#poll_form").hide()
		$("#feedback_form").empty().html("<h3 id='feedback_response'>" + response.text + "</h3>");
	},
	
	// Statistics form
	showStatisticsResponse : function(response){
		response = this.parseJSON(response);
		$("#tweet_statistics").empty().html("<h3>" + response.text + "</h3>");
		Tweasier.hideLoader();
	},
	
	// Search results follow response
	showSearchResultsFollowResponse : function(response){
		response = this.parseJSON(response);
		$("#search_results_follow_form").empty().html("<p>" + response.text + "</p>");
	},
	
	// Link requests
	replaceLinkRequestResponse : function(response){
		object = JSON.parse(response)
		Tweasier.enableStatusForm();
		Tweasier.hideLoader(true);
		
		if(object.text) {
			Tweasier.setStatusFormLabel("URL's successfully shortened");
			Tweasier.setStatusFormFocus(object.text);
		}
		else
		{
			Tweasier.setStatusFormLabel(object.error);
		}
	},
	
	// Search requests
	replaceSearchResponse : function(response){
		$("#search_results").empty().append(response);
		Tweasier.hideLoader(true);
		Tweasier.forceExternalLinks(); // remove eventually
	},
	
	// Follow requests
	replaceInlineFollowResponse : function(response, user_id){
		object = this.parseJSON(response);
		$("#follow_message_for-" + user_id).html(object.text);
	},
	
	// Retweets requests
	replaceRetweetResponse : function(response, status_id){
		object = this.parseJSON(response);
		$("#retweet_link_for-" + status_id).html(object.text);
	},
	
	// Retweets requests
	replaceSpamReportResponse : function(response){
		object = this.parseJSON(response);
		$("#spam_report_message").html(object.text);
	}
}

jQuery(function($) {
  var countdown = $('#countdown');
  var allowedCount = parseInt(countdown.text());

  $('#text').keydown(function() {
    var length = $(this).val().length;
    countdown.text(allowedCount - length);
  });
  
	$("#status_form").submit(function(){
		if($("#status_form > #text").val() == "")
		{
			Tweasier.setStatusFormLabel("Please enter some text");
			return false;
		}
	});

  $('a.dm').live('click', function() {
		Tweasier.setTop();
		
    var screen_name = $(this).attr('rel');
    
		Tweasier.setStatusFormLabel("New direct message to " + screen_name);
		Tweasier.setStatusFormSubmit("Message " + screen_name);
		Tweasier.setStatusFormAction(window.direct_messages_path);
		Tweasier.setStatusFormHiddenField("recipient_id", screen_name);
		Tweasier.setStatusFormFocus("");
    return false;
  });

  $('a.retweet').live('click', function(event) {
		event.preventDefault();
		$(this).hide();
		
		var status_id    = this.rel
		var form_name    = "#retweet_form_for-" + status_id;
		var message_name = "#retweet_link_for-" + status_id;
		
		$(message_name).removeClass("retweet");
		$(message_name).attr({"style":"width:120px;margin-top:4px;display:block;float:right;text-align:center"});
		$(message_name).html("Retweeting...");
		
		$.ajax({ type: "POST",
		 				 url: $(form_name).attr("action"),
						 data: $(form_name).serialize(),
						 success: function(response){ Tweasier.replaceRetweetResponse(response, status_id); },
						 error: function(response){ Tweasier.replaceRetweetResponse(response, status_id); }
		});
		
    return false;
  });
  
  $('a.reply').live('click', function() {
		Tweasier.setTop();
		Tweasier.setStatusFormAction(window.statuses_path);
		
    var pieces = $(this).attr('rel').split(':');
    var screen_name = pieces[0];
    var id 					= pieces[1];
		
		$('#in_reply_to_status_id').val(id);
		
		Tweasier.setStatusFormFocus("@" + screen_name + " ");
		Tweasier.setStatusFormLabel("Replying to " + screen_name + "'s tweet")
		Tweasier.setStatusFormSubmit("Reply to " + screen_name);
    return false;
  });

  $('a.link_request').live('click', function() {
		Tweasier.disableStatusForm();
		Tweasier.showLoader("Shortening URLs, one moment please");
		
		$.ajax({ type: "POST",
		 				 url: this.href,
						 data: { text:$("#text").val() },
						 success: function(response){ Tweasier.replaceLinkRequestResponse(response); },
						 error: function(response){ Tweasier.replaceLinkRequestResponse(response); }
		});
		
    return false;
  });

  $('#perform_search').submit(function(e) {
		e.preventDefault();
		Tweasier.showLoader("Running search '" + $("#search_title").val() + "'");
		
		$.ajax({ type: "POST",
		 				 url: this.action,
						 success: function(response){ Tweasier.replaceSearchResponse(response); },
						 error: function(response){ Tweasier.replaceSearchResponse(response); }
		});
		
    return false;
  });
	
  $('a.inline_follow').live('click', function(event) {
		event.preventDefault();
		$(this).hide();
		
		var user_id      = this.rel
		var form_name    = "#follow_form_for-" + user_id;
		var message_name = "#follow_message_for-" + user_id;
		
		$(message_name).attr("style","display:inline");
		
		$.ajax({ type: "POST",
		 				 url: $(form_name).attr("action"),
						 data: $(form_name).serialize(),
						 success: function(response){ Tweasier.replaceInlineFollowResponse(response, user_id); },
						 error: function(response){ Tweasier.replaceInlineFollowResponse(response, user_id); }
		});
		
    return false;
  });

  $('a.report_spam').live('click', function(event) {
		event.preventDefault();
		
		if(!confirm("Are you sure you want to report this user as spam?!")) return false;
		
		$(this).hide();
		
		var form_name    = "#spam_report_form";
		var message_name = "#spam_report_message";
		
		$(message_name).attr("style","display:inline");
		
		$.ajax({ type: "POST",
		 				 url: $(form_name).attr("action"),
						 data: $(form_name).serialize(),
						 success: function(response){ Tweasier.replaceSpamReportResponse(response); },
						 error: function(response){ Tweasier.replaceSpamReportResponse(response); }
		});
		
    return false;
  });
	
	// External links
	Tweasier.forceExternalLinks();
	
	// Quick account selector
	$("#account_selector").change(function(){
		if(this.value == "") return false;
		Tweasier.showLoader("Changing account");
		window.location = "/app/user/accounts/" + this.value;
	});
	
	// Poll observer
	Tweasier.setupPollForm();
	
	$(".poll_entry").change(function(){
		$.ajax({ type: "POST",
		 				 url: this.form.action,
						 data: $(this.form).serialize(),
						 success: function(response){ Tweasier.showPollResponse(response); },
						 error: function(response){ Tweasier.showPollResponse(response); }
		});
		return false;
	});
	
	// Feedback observer
	//Tweasier.setupPollForm();
	$("#feedback_entry_form").submit(function(){
		$.ajax({ type: "POST",
		 				 url: this.action,
						 data: $(this).serialize(),
						 success: function(response){ Tweasier.showFeedbackResponse(response); },
						 error: function(response){ Tweasier.showFeedbackResponse(response); }
		});
		return false;
	});
	
	// Statistics observer
	$("#statistics_form").live('submit', function(){
		Tweasier.showLoader("Tweeting statistics");
		
		$.ajax({ type: "POST",
		 				 url: this.action,
						 data: $(this).serialize(),
						 success: function(response){ Tweasier.showStatisticsResponse(response); },
						 error: function(response){ Tweasier.showStatisticsResponse(response); }
		});
		return false;
	});
	
	// Search results follow form
	$("#search_results_follow_form").live("submit", function(){
		Tweasier.showLoader("Sending follow requests");
		
		$.ajax({ type: "POST",
		 				 url: this.action,
						 data: $(this).serialize(),
						 success: function(response){ Tweasier.showSearchResultsFollowResponse(response); },
						 error: function(response){ Tweasier.showSearchResultsFollowResponse(response); }
		});
		return false;
	});
	
	// Check for conditions that dont require a value and hide value text box if so
	$("#condition_search_condition_type_id").change(function(){
		(jQuery.inArray(this.value, window._valid_empty_conditions) != -1) ? $("#condition_value_wrapper").hide() : $("#condition_value_wrapper").show();
	});
	
	// Clone search show/hide
	$("#clone_search_form").hide();
	$("#clone_search").click(function(event){
		event.preventDefault();
		$(this).hide();
		$("#clone_search_form").show();
	});
	
	// Search batch amount selector
	$("#search_batch_count_selector").change(function(){
		if(this.value == "") return false;
		window.location = window.new_search_batches_path + "?count=" + this.value;
	});
	
	// Search batch amount selector
	$("#retweets_selector").change(function(){
		if(this.value == "") return false;
		window.location = "?filter=" + this.value;
	});
	
	// Setup Tweasier
	Tweasier.hideLoader(true);
	
	// Init FacyBox
	$('a[rel*=facybox]').facybox()
	
	// TEMP ajax loader triggers
	$(".ajax").each(function(i, el){
		$(el).click(function(){ Tweasier.showLoader(); });
	});
	
});