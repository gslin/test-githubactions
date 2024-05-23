const express = require('express');

const api = require('./api');

const app = express();

// Serve static files:
app.use(express.static('public'));

// Use ejs:
app.set('view engine', 'ejs');
app.set('views', 'src/views');

app.get('/', (req, res) => {
  res.render('index');
});

app.use('/api', api);

module.exports = app;
