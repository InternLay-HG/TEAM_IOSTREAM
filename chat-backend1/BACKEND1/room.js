const availableGroups = ["a","b","c","d"];
io.on("connection", (socket) => {
    console.log(`User connected: ${socket.id}`);

    // Automatically join all available groups
    availableGroups.forEach((groupName) => {
        socket.join(groupName);
        console.log(`${socket.id} automatically joined group: ${groupName}`);
    });

    // Notify the user that they've joined the groups
    socket.emit("joinedGroups", availableGroups);

    // Listen for group messages
    socket.on("groupMessage", ({ groupName, message }) => {
        io.to(groupName).emit("newGroupMessage", {
            sender: socket.id,
            message: message,
            group: groupName,
        });
    });

    // Handle disconnect
    socket.on("disconnect", () => {
        console.log(`User disconnected: ${socket.id}`);
    });
});