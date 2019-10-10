var request = require('request')
var os = require('os')
var key = os.hostname()

function processResponse(res, body) {
	console.log ("Request successful");
	res.send (body);
}

function processError (res) {
    res.status(500).send ("Error ")
}

function pump (res) {
	console.log ("=== Pump === ");
	url = "http://key-counter:8080/inc/" + key;
	console.log ("URL: " + url);

	request.get({
			url: url
	},
	function (error, response, body) {
			console.log('error:', error); // Print the error if one occurred
			console.log('statusCode:', response.statusCode); // Print the response status code if a response was received
			if (!error && response.statusCode == 200) {
				processResponse (res, body);
			 } else {
					processError (res);
			 }
	 })
}

// Deprecated
function init () {
	url = "http://key-counter:8080/define/" + key;

	console.log ("URL: " + url);

	request.get({
			url: url
	},
	function (error, response, body) {
			console.log('error:', error); // Print the error if one occurred
			console.log('statusCode:', response.statusCode); // Print the response status code if a response was received
			if (!error && response.statusCode == 200) {
				console.log ("Request successful");
			 } else {
				 console.log ("Error");
			 }
	 })
}

//init()

module.exports = {
		pump: pump
}
