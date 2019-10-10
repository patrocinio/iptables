var redisHelper = require('./redisHelper');
var async = require('async');
var redlock = require('redlock');

var REDIS_URL = "redis://redis";
var TTL = 10000;
var KEY = "mykey";

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

function setValue (res, lock, key, value) {
  console.log ("Setting value key: " + key + " value: " + value);
  client.set (key, value, function (err, reply) {
    console.log ("Key " + key + " set")
    res.send ("Key " + key + " set")
    lock.unlock(function(err) {
      if (err) {
			     console.error("lock.unlock error: " + err);
         } else {
           console.log ("Done with key " + key);
         }
    });
  });
}

function defineKey (req, res) {
  key = req.params.key;
//  lock_key = "lock-" + key;
  lock_key = KEY;
  console.log ("Defining key " + key);
  redlock.lock (lock_key, TTL, function (error, lock) {
    if (error)
      res.send(error);
    else {
      setValue (res, lock, key, 0);
    }
  });
}

function increment (req, res) {
  var key = req.params.key;
//  lock_key = "lock-" + key;
  lock_key = KEY;
  console.log ("Incrementing key " + key);
  redlock.lock (lock_key, TTL, function (error, lock) {
    if (error) {
      console.log ("error: " + error)
      res.send(error);
    }
    else {
      client.get (key, function (error, value) {
        if (error)
          res.send("client.get error: " + error);
        else {
          console.log ("key: " + key + " value: " + value);
          if (value) {
            num = parseInt(value);
            num = num+1;
          } else {
            num = 1;
          }
          setValue (res, lock, key, num);
        } // else
      }); // client.get
    } // else
  });
}

var client = redisHelper.connectToRedis(REDIS_URL);
var redlock = new redlock([client], { retryCount: 100, retryDelay: 1000 });

module.exports = {
	reset: reset,
  list: list,
  defineKey: defineKey,
  increment: increment
}
