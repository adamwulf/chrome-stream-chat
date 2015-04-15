


function processLog(host, sender, message){
		console.log("formatted [" + window.location.hostname + "] [" + sender + "] [" + message + "]");

}


function processLiveCodingLogElement($e){
	console.log("found log");
	console.log($e.text());
	
	var sender = $e.find("a").text().trim();
	var $c = $e.clone();
	$c.find("a").remove();
	$c.find("img").replaceWith(function() { return $.trim(this.alt); });
	var comment = $c.text().trim();
	
	processLog(window.location.hostname, sender, comment);
}

function processYouTubeLogElement($e){
	try{
		var sender = $e.find(".inline-author").text().trim();
		var comment = $e.find(".inline-comment").text().trim();
		processLog(window.location.hostname, sender, comment);
	}catch(e){
		console.log(e);
	}
}


function processTwitchLogElement($e){
	if(!$e.hasClass("admin")){
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
			console.log("Hello. This message was sent from scripts/inject.js");
			// ----------------------------------------------------------
	
			
				// livecoding.tv
				var currLCSib = false;
				var currYTSib = false;
				var currTWSib = false;
				setInterval(function() {
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
					
					
					
					if(!currTWSib){
						currTWSib = $("ul.chat-lines li.chat-line:first");
						if(currTWSib.length){
							processTwitchLogElement(currTWSib);
						}else{
							currTWSib = false;
						}
					}else if(currTWSib.nextAll("li.chat-line").length){
						currTWSib = currTWSib.nextAll("li.chat-line");
						processTwitchLogElement(currTWSib);
					}

				}, 100);
			
			
			

	

		}
	}, 10);
});