const Post = require('../models/post');

const toggleLike = async (req, res) => {
  const { userId, postId } = req.body;

  try {
    const post = await Post.findById(postId);

    if (!post) {
      return res.status(404).json({ error: 'Post not found' });
    }

    // Check if user has already liked the post
    const isLiked = post.likedBy.includes(userId);

    if (isLiked) {
      // Unlike
      post.likedBy = post.likedBy.filter(id => id.toString() !== userId);
      post.likes -= 1;
    } else {
      // Like
      post.likedBy.push(userId);
      post.likes += 1;
    }

    await post.save();
    res.status(200).json({ message: isLiked ? 'Like removed' : 'Liked successfully', post });
  } catch (error) {
    res.status(500).json({ error: 'Something went wrong', details: error.message });
  }
};
