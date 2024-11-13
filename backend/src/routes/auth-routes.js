const express = require('express');
const { signup, login, getUserById, updateUser, deleteUser } = require('../controllers/auth_controller');
const { addUserToGroup } = require('../controllers/group_controller');
const Message = require('../models/message');
const Group = require("../models/group");
const passport = require("passport");
const router = express.Router();


router.post('/signup', signup);


router.post('/login', login);

router.post('/groups/:groupId/add-user', async (req, res) => {
    const { userId } = req.body;
    const { groupId } = req.params;
    
    const result = await addUserToGroup(groupId, userId);
    return res.status(result.success ? 200 : 400).json(result);
});
router.post("/join-group/:groupId", passport.authenticate("jwt", { session: false }), async (req, res) => {
    try {
        const { groupId } = req.params;
        const userId = req.user.id;
        
        await Group.findByIdAndUpdate(groupId, { $addToSet: { members: userId } });
        res.json({ message: "Joined group successfully" });
    } catch (error) {
        console.error("Error joining group:", error);
        res.status(500).json({ error: "Error joining group" });
    }
});

router.get('/messages/:groupId', async (req, res) => {
    try {
        const messages = await Message.find({ group: req.params.groupId })
            .populate('user', 'username')
            .sort('timestamp'); 
        res.json(messages);
    } catch (error) {
        res.status(500).json({ error: 'Error fetching messages' });
    }
});

module.exports = router;



router.get('/:id', getUserById);


router.put('/:id', updateUser);


router.delete('/:id', deleteUser);

module.exports = router;
