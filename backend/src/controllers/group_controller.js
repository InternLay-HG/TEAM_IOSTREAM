const Group = require('../models/group');

async function addUserToGroup(groupId, userId) {
    try {
        const group = await Group.findById(groupId);
        
        if (!group) {
            return { success: false, message: 'Group not found' };
        }
        
        if (!group.userIds.includes(userId)) {
            group.userIds.push(userId); 
            await group.save();
        }
        
        return { success: true, message: 'User added to group successfully', data: group };
    } catch (error) {
        console.error("Error adding user to group:", error);
        return { success: false, message: 'Error adding user to group' };
    }
}

module.exports = { addUserToGroup };
