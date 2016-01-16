
function processLog(host, sender, message){
	
	chrome.runtime.sendMessage(
	    {"host": host, "sender" : sender, "message" : message},
	    function (response) {
	        console.log(response);
	    }
	);
}


function processLiveCodingLogElement($e){
	console.log($e.text());
	
	var timeStamp = $e.find("a small").text().trim();
	var sender = $e.find("a").text().trim();
	sender = sender.substr(timeStamp.length);
	
	
	var $c = $e.clone();
	$c.find("a").remove();
	$c.find("img").replaceWith(function() { return $.trim(this.alt); });
	var comment = $c.text().trim();
	
	processLog(window.location.hostname, sender, comment);
}

function processYouTubeLogElement($e){
	try{
		console.log("process youtube: ");
		console.log($e);
		var sender = $e.find("a").text().trim();
		var comment = $e.find(".comment-text").text().trim();
		console.log("sender: " + sender);
		console.log("comment: " + comment);
		processLog(window.location.hostname, sender, comment);
	}catch(e){
		console.log(e);
	}
}


function processTwitchLogElement($e){
	if(!$e.find('li').hasClass("admin")){
		$c = $e.clone();
		$c.find(".message").find("img").replaceWith(function() { return this.alt; });

		var sender = $c.find(".from").text().trim();
		var comment = $c.find(".message").text().trim();
		processLog(window.location.hostname, sender, comment);
	}
}


chrome.extension.sendMessage({}, function(response) {
	var readyStateCheckInterval = setInterval(function() {
		if (document.readyState === "complete") {
			clearInterval(readyStateCheckInterval);
	
			// ----------------------------------------------------------
			// This part of the script triggers when page is done loading
			// ----------------------------------------------------------
			
				var currLCSib = false;
				var currYTSib = false;
				var currTWSib = false;
				setInterval(function() {
					// livecoding.tv
					if(!currLCSib){
						currLCSib = $("ul.message-pane li:first");
						if(currLCSib.length){
							processLiveCodingLogElement(currLCSib);
						}else{
							currLCSib = false;
						}
					}else if(currLCSib.next().length){
						currLCSib = currLCSib.next();
						processLiveCodingLogElement(currLCSib);
					}

					// youtube
					if(!currYTSib){
						currYTSib = $("ul#all-comments li:first");
						if(currYTSib.length){
							processYouTubeLogElement(currYTSib);
						}else{
							currYTSib = false;
						}
					}else if(currYTSib.next().length){
						currYTSib = currYTSib.next();
						processYouTubeLogElement(currYTSib);
					}
					
					// twitch
					if(!currTWSib){
						currTWSib = $("ul.chat-lines div.ember-view:first");
						if(currTWSib.length){
							processTwitchLogElement(currTWSib);
						}else{
							currTWSib = false;
						}
					}else if(currTWSib.nextAll("div.ember-view").length){
						currTWSib = currTWSib.nextAll("div.ember-view");
						processTwitchLogElement(currTWSib);
					}

				}, 100);
			
			
			

	

		}
	}, 10);
});