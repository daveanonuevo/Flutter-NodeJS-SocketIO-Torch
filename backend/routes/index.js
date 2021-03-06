const express = require('express');
const router = express.Router();

router.get('/', function(req, res, next) {
  res.render('index', { title: 'INTEV Project' });
});

const toggleRouter = require('./toggle');
router.use('/toggle', toggleRouter);

module.exports = router;
