const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const cors = require('cors');
const http = require('http');
const socketIo = require('socket.io');

const app = express();
const server = http.createServer(app);
const io = socketIo(server);

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

const orderSchema = new mongoose.Schema({
  userId: String,
  status: String,
  items: Array,
  total: Number,
});

const User = mongoose.model('User', userSchema);
const Order = mongoose.model('Order', orderSchema);

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

app.post('/order', async (req, res) => {
  const { userId, items, total } = req.body;
  const newOrder = new Order({ userId, status: 'Pending', items, total });
  await newOrder.save();
  io.emit('orderStatus', { orderId: newOrder._id, status: 'Pending' });
  res.send('Order placed');
});

io.on('connection', (socket) => {
  console.log('New client connected');
  socket.on('disconnect', () => {
    console.log('Client disconnected');
  });
});

server.listen(port, () => {
  console.log(`Server running on port ${port}`);
});