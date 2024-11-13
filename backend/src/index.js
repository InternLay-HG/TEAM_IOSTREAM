const express = require('express');
const http = require('http');
const path = require('path'); // Make sure to import path
const { connect } = require('./config/database'); // Assuming you have a database connection function
const passport = require('passport');
const passportAuth = require('./config/jwt-middleware'); 
const apiRoutes = require('./routes/auth-routes');
const {Server} = require("socket.io");

const app = express();
const server = http.createServer(app);
const io = new Server(server);
// Serve static files from the public directory
app.use(express.static('public')); // Ensure your HTML file is in the 'public' directory

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(passport.initialize());
passportAuth(passport); 
app.use('/api', apiRoutes);


app.get('/', (req, res) => {
    res.sendFile(__dirname + '/public/index.html');
});

io.on('connection', (socket) => {
    console.log('A user connected');

    socket.on('disconnect', () => {
        console.log('A user disconnected');
    });

    socket.on('chat message', (msg) => {
        console.log('Message received: ' + msg);
        io.emit('chat message', msg);
    });
});
const { PORT } = require('./config/server_config');

server.listen(PORT, async () => {
    console.log(`Server started on PORT: ${PORT}`);
    try {
        await connect();
        console.log('MongoDB connected');
    } catch (error) {
        console.error('Failed to connect to MongoDB:', error);
        process.exit(1);
    }
});