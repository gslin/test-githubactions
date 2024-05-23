const express = require('express');

const app = express();
const port = 3001;

// Serve static files:
app.use(express.static('public'));

// Use ejs:
app.set('view engine', 'ejs');
app.set('views', 'src/views');

app.get('/', (req, res) => {
  res.render('index');
});

app.listen(port, () => {
  console.log(`App listening on port ${port}`);
});
