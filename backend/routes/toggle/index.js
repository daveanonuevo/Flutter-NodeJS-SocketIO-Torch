const express = require('express');

const router = express.Router();

router.post('/', function(req, res, next) {
//  Send toggle to Socket.IO chat

  const io = req.app.io;
  io.emit("toggle", true);
  console.log("/toggle/");

  res.send({success:true});
});

module.exports = router;