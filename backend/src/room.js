const Message = require('./models/message');  
const Group = require('./models/group');      
const User = require('./models/user');        

module.exports = (io) => {
    io.on("connection", (socket) => {
        console.log(`User connected: ${socket.id}`);

        // Extract user ID and group ID from the handshake or frontend parameters
        const userId = socket.handshake.query.userId;
        const groupId = socket.handshake.query.groupId;

        // User joins the group room
        socket.join(groupId);
        console.log(`User ${userId} joined group ${groupId}`);

        // Listen for a new message in the group
        socket.on("sendMessage", async ({ messageContent }) => {
            try {
                // Create a new message document
                const newMessage = new Message({
                    content: messageContent,
                    user: userId,
                    group: groupId
                });

                // Save message to MongoDB
                await newMessage.save();

                
                await newMessage.populate('user', 'name').execPopulate();

                // Emit message to everyone in the group
                io.to(groupId).emit("receiveMessage", {
                    content: newMessage.content,
                    user: newMessage.user.name,
                    timestamp: newMessage.createdAt
                });
            } catch (error) {
                console.error('Error saving or sending message:', error);
            }
        });

        // Handle user disconnection
        socket.on("disconnect", () => {
            console.log(`User disconnected: ${socket.id}`);
        });
    });
};
