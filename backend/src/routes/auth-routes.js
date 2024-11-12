const express = require('express');
const { signup, login, getUserById, updateUser, deleteUser } = require('../controllers/auth_controller');
const { addUserToGroup } = require('../controllers/group_controller');
const router = express.Router();


router.post('/signup', signup);


router.post('/login', login);

router.post('/groups/:groupId/add-user', async (req, res) => {
    const { userId } = req.body;
    const { groupId } = req.params;
    
    const result = await addUserToGroup(groupId, userId);
    return res.status(result.success ? 200 : 400).json(result);
});


router.get('/:id', getUserById);


router.put('/:id', updateUser);


router.delete('/:id', deleteUser);

module.exports = router;
