socket.on("joinedGroups", (groups) => {
    console.log("You have been automatically added to the following groups:", groups);
});

// Function to send messages to a group
function sendMessageToGroup(groupName, message) {
    socket.emit("groupMessage", { groupName, message });
}

// Listen for new messages in any group
socket.on("newGroupMessage", (data) => {
    console.log(`Message from ${data.sender} in ${data.group}: ${data.message}`);
});
