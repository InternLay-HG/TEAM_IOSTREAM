const express = require('express');
const { signup, login, getUserById, updateUser, deleteUser } = require('../controllers/auth_controller');
const { addUserToGroup } = require('../controllers/group_controller');
const Message = require('../models/message');
const Group = require("../models/group");
const passport = require("passport");
const multer = require('multer');
const Comment = require('../models/comment');
const Post = require('../models/post');
const mongoose = require('mongoose')

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

router.get('/groups/:userId', async (req, res) => {
  try {
      const groups = await Group.find({ members: req.params.userId })
          .select('name description') 
          .sort('name'); 

      res.json(groups);
  } catch (error) {
      console.error('Error fetching user groups:', error);
      res.status(500).json({ error: 'Error fetching user groups' });
  }
});

router.get('/messages/:groupId', async (req, res) => {
  try {
    const groupId = new mongoose.Types.ObjectId(req.params.groupId); 
    const messages = await Message.find({ group: groupId })
      .populate('user', 'name')  // Assuming 'user' is the reference field in your Message model
      .sort({ timestamp: 'asc' }); 

    if (!messages.length) {
      return res.status(404).json({ error: 'No messages found for this group.' });
    }

    res.json(messages);
  } catch (error) {
    console.error('Error fetching messages:', error);
    res.status(500).json({ error: 'Error fetching messages' });
  }
});


const storage = multer.diskStorage({
    destination: (req, file, cb) => {
      cb(null, 'uploads/');
    },
    filename: (req, file, cb) => {
      cb(null, Date.now() + '-' + file.originalname);
    }
  });
  const upload = multer({ storage: storage });
  
  // Post a new blog post
  router.post('/posts', upload.single('image'), async (req, res) => {
    try {
      const post = new Post({
        title: req.body.title,
        description: req.body.description,
        image: req.file.path,
      });
      await post.save();
      res.status(201).json(post);
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  });
  // Fetch authenticated user info
  router.get('/user', passport.authenticate('jwt', { session: false }), async (req, res) => {
    try {
        const user = await User.findById(req.user._id); // Extract user ID from JWT
        if (!user) {
            return res.status(404).json({ error: "User not found" });
        }
        res.json(user); // Respond with user data
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Error fetching user info" });
    }
});

  // Get all blog posts
  router.get('/posts', async (req, res) => {
    try {
      const posts = await Post.find().populate('comments');
      res.status(200).json(posts);
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  });
  
  // Like a post
  router.post('/posts/:id/like', async (req, res) => {
    try {
      const post = await Post.findById(req.params.id);
      post.likes += 1;
      await post.save();
      res.status(200).json(post);
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  });
  
  router.post('/comments', async (req, res) => {
    try {
      const { content, postId } = req.body;
      const post = await Post.findById(postId);
      
      const comment = new Comment({ content, postId });
      await comment.save();
      
      post.comments.push(comment);
      await post.save();
      
      res.status(201).json(comment);
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  });
  

router.get('/:id', getUserById);


router.put('/:id', updateUser);


router.delete('/:id', deleteUser);

module.exports = router;
