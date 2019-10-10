var request = require('request')

function pumpOne (res) {
	url = "http://dispatcher:8080/pump";

	request.get({
			url: url
	},
	function (error, response, body) {
			console.log('error:', error); // Print the error if one occurred
			console.log('statusCode:', response.statusCode); // Print the response status code if a response was received
		});
}

function pump(res) {
		for (i = 0; i < 1000; i++) {
			console.log ("#" + i);
			pumpOne ();
		}
		res.send ("Request sent")
}

module.exports = {
		pump: pump
}
