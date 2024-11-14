const Message = require('./models/message');
const Group = require('./models/group');
const User = require('./models/user');
const mongoose = require('mongoose')
module.exports = (io) => {
    io.on("connection", async (socket) => {
        console.log(`User connected: ${socket.id}`);

        
        const userId = socket.handshake.query.userId;

        try {
            const user = await User.findById(userId);
            if (!user) {
                console.error("User not found");
                socket.disconnect();
                return;
            }

            const userGroups = await Group.find({ members: userId });
            const availableGroups = userGroups.map(group => group.name);

            
            availableGroups.forEach((groupName) => {
                socket.join(groupName);
                console.log(`${socket.id} joined group: ${groupName}`);
            });
            socket.emit("joinedGroups", availableGroups);
        } catch (error) {
            console.error("Error fetching user groups from MongoDB:", error);
        }

        socket.on("groupMessage", async ({ groupName, message }) => {
            try {
                const group = await Group.findOne({ name: groupName });
                if (!group) {
                    return console.error(`Group not found: ${groupName}`);
                }
                const newMessage = new Message({
                    content: message,
                    user: userId,
                    group: group._id
                });
                console.log('User ID:', userId); // Log userId
                console.log('Group ID:', group._id); // Log group ID

                console.log('Saving message:', newMessage);
                await newMessage.save();
                console.log('Message saved:', newMessage);
                io.to(groupName).emit("newGroupMessage", {
                    sender: userId,
                    message,
                    group: groupName,
                    timestamp: newMessage.timestamp
                });
            } catch (error) {
                console.error('Error saving message:', error);
            }
        });

        socket.on("disconnect", () => {
            console.log(`User disconnected: ${socket.id}`);
        });
    });
};
