const dotenv = require('dotenv');
const express = require('express');
const http = require('http');
const cors = require('cors');
const socketIo = require('socket.io');

const connectDB = require('./config/db');
const authRoutes = require('./routes/auth');
const chatRoutes = require('./routes/chat');
const Message = require('./models/Message');
const Group = require('./models/Group');
// console.log("Environment Variables:", process.env);
dotenv.config();
connectDB();

const app = express();
app.use(cors());
app.use(express.json());
app.use('/api/auth', authRoutes);
app.use('/api/chat', chatRoutes);

const server = http.createServer(app);
const io = socketIo(server, { cors: { origin: '*' } });

io.on('connection', (socket) => {
  console.log('New client connected');

  // Join all available groups
  socket.on('joinAllGroups', async () => {
    const groups = await Group.find({});
    groups.forEach(group => {
      socket.join(group.name);
    });
    socket.emit('groupsJoined', groups);
  });

  // Handle new message
  socket.on('sendMessage', async ({ userId, group, content }) => {
    const message = new Message({ user: userId, group, content });
    await message.save();
    io.to(group).emit('newMessage', { user: userId, content, timestamp: message.timestamp });
  });

  socket.on('disconnect', () => {
    console.log('Client disconnected');
  });
});

const PORT = process.env.PORT || 3000;
server.listen(PORT, () => console.log(`Server running on port ${PORT}`));
app.get('/', (req, res) => {
  res.send('Chat server is up and running');
});

