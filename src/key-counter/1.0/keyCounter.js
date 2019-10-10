var redisHelper = require('./redisHelper');
var async = require('async');

var REDIS_URL = "redis://redis";

function reset (res) {
    console.log ("Resetting keys");

    client.flushall ();

    res.send ("Keys reset");
}

function list (res) {
  console.log ("Getting all keys");
  client.keys ('*', function (err, keys) {
    if (err)
      res.send(err);
    else {
      if (keys) {
        async.map(keys, function(key, cb) {
          console.log ("Key: " + key)
          client.get(key, function (error, value) {
            if (error)
              res.send(error);
            else {
              var job = {};
              job['key'] = key;
              job['value'] = value;
              cb(null, job)
            }
          });
        }, function (error, results) {
          if (error)
            res.send (error);
          else {
            console.log ("Results: ")
            console.log (results)
            res.json({keys:results})
          }
        })
      }
    }
  })
}

function setValue (res, key, value) {
  client.set (key, value, function (err, reply) {
    res.send ("Key " + key + " defined")
  })

}

function defineKey (req, res) {
  key = req.params.key;
  console.log ("Defining key " + key);
  setValue (res, key, 0);
}

function increment (req, res) {
  key = req.params.key;
  console.log ("Incrementing key " + key);
  client.get (key, function (error, value) {
    if (error)
      res.send(error);
    else {
      console.log ("value: " + value);
      num = parseInt(value);
      num = num+1;
      setValue (res, key, num);
    }
  })
}

var client = redisHelper.connectToRedis(REDIS_URL);

module.exports = {
	reset: reset,
  list: list,
  defineKey: defineKey,
  increment: increment
}
