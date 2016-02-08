'use strict';

let express = require('express');

module.exports = function(app, data) {
  let router = new express.Router();

  router.get('/', function(req, res) {
      res.send({
        result: data.wolitems.all()
      });
    })
    .post('/', function(req, res) {
      res.send({
        result: data.wolitems.save(req.body)
      });
    });

  app.use('/api/wolitems', router);
};