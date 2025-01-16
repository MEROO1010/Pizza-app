const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
app.use(bodyParser.json());
app.use(cors());

const port = process.env.PORT || 3000;

mongoose.connect('mongodb://localhost:27017/pizza_app', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

const userSchema = new mongoose.Schema({
  username: String,
  password: String,
  email: String,
});

const User = mongoose.model('User', userSchema);

app.post('/signup', async (req, res) => {
  const { username, password, email } = req.body;
  const newUser = new User({ username, password, email });
  await newUser.save();
  res.send('User registered');
});

app.post('/login', async (req, res) => {
  const { username, password } = req.body;
  const user = await User.findOne({ username, password });
  if (user) {
    res.send('Login successful');
  } else {
    res.send('Invalid credentials');
  }
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});