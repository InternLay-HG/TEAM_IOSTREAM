const express = require('express');
const jwt = require('jsonwebtoken');
const Message = require('../models/Message');
const Group = require('../models/Group');
const router = express.Router();

// Middleware to verify JWT
function verifyToken(req, res, next) {
  const token = req.headers.authorization;
  if (!token) return res.status(401).json({ error: 'No token provided' });
  jwt.verify(token, process.env.JWT_SECRET, (err, decoded) => {
    if (err) return res.status(401).json({ error: 'Token invalid' });
    req.userId = decoded.userId;
    next();
  });
}

// Get all messages for a group
router.get('/messages/:group', verifyToken, async (req, res) => {
  try {
    const messages = await Message.find({ group: req.params.group }).populate('user', 'username').exec();
    res.json(messages);
  } catch (error) {
    res.status(400).json({ error: 'Failed to retrieve messages' });
  }
});

module.exports = router;
