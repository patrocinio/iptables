// server.js

// BASE SETUP
// =============================================================================

// call the packages we need
var express    = require('express');        // call express
var app        = express();                 // define our app using express
var bodyParser = require('body-parser');
var keyCounter = require('./keyCounter');

// configure app to use bodyParser()
// this will let us get the data from a POST
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

var port = process.env.PORT || 8080;        // set our port

// ROUTES FOR OUR API
// =============================================================================
var router = express.Router();              // get an instance of the express Router

// test route to make sure everything is working (accessed at GET http://localhost:8080/api)
//router.post('/:symbol', function(req, res) {
//	stock.set(req, res)
//});

router.get('/reset', function(req, res) {
	keyCounter.reset(res)
});

router.get('/list', function(req, res) {
	keyCounter.list(res)
});

router.get('/define/:key', function (req, res) {
	keyCounter.defineKey(req, res)
})

router.get('/inc/:key', function (req, res) {
	keyCounter.increment(req, res)
})

router.get('/', function(req, res) {
	res.send("I'm healthy")
});



// more routes for our API will happen here

// REGISTER OUR ROUTES -------------------------------
// all of our routes will be prefixed with /api
app.use('/', router);

// START THE SERVER
// =============================================================================
app.listen(port);
console.log('Magic happens on port ' + port);
