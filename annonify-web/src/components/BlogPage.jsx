import React, { useState, useEffect } from "react";

function BlogPage() {
  const [posts, setPosts] = useState([]);
  const [newPost, setNewPost] = useState({
    title: "",
    description: "",
    image: null,
  });
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    loadPosts();
  }, []);

  const loadPosts = async () => {
    setLoading(true);
    try {
      const response = await fetch("http://localhost:5000/api/posts");
      if (!response.ok) {
        throw new Error("Failed to fetch posts");
      }
      const data = await response.json();
      setPosts(data);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setNewPost({
      ...newPost,
      [name]: value,
    });
  };

  const handleFileChange = (e) => {
    setNewPost({
      ...newPost,
      image: e.target.files[0],
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    const formData = new FormData();
    formData.append("title", newPost.title);
    formData.append("description", newPost.description);
    formData.append("image", newPost.image);

    try {
      const response = await fetch("http://localhost:5000/api/posts", {
        method: "POST",
        body: formData,
      });

      if (!response.ok) {
        throw new Error("Failed to create post");
      }
      loadPosts();
    } catch (err) {
      setError(err.message);
    }
  };

  const handleLike = async (postId) => {
    try {
      const response = await fetch(`http://localhost:5000/api/posts/${postId}/like`, {
        method: "POST",
      });
      if (!response.ok) {
        throw new Error("Failed to like post");
      }
      setPosts((prevPosts) =>
        prevPosts.map((post) =>
          post._id === postId ? { ...post, likes: post.likes + 1 } : post
        )
      );
    } catch (err) {
      setError(err.message);
    }
  };

  const handleAddComment = async (postId, commentContent) => {
    if (!commentContent.trim()) return;

    try {
      const response = await fetch(`http://localhost:5000/api/posts/${postId}/comment`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ content: commentContent }),
      });

      if (!response.ok) {
        const errorData = await response.json();
        console.log("Error response from server:", errorData);
        throw new Error("Failed to add comment");
      }

      const newComment = await response.json();
      setPosts((prevPosts) =>
        prevPosts.map((post) =>
          post._id === postId
            ? { ...post, comments: [...post.comments, newComment] }
            : post
        )
      );
    } catch (err) {
      setError(err.message);
    }
  };

  return (
    <div className="flex-1 p-8 bg-black h-full text-white">
      <h1 className="text-2xl font-semibold">Blog Page</h1>

      {error && <div className="text-red-500">{error}</div>}

      <form onSubmit={handleSubmit} encType="multipart/form-data">
        <input
          type="text"
          name="title"
          placeholder="Title"
          value={newPost.title}
          onChange={handleInputChange}
          required
        />
        <textarea
          name="description"
          placeholder="Description"
          value={newPost.description}
          onChange={handleInputChange}
          required
        />
        <input
          type="file"
          onChange={handleFileChange}
          required
        />
        <button type="submit">Post</button>
      </form>

      {loading && <div>Loading posts...</div>}

      <div id="posts">
        {posts.map((post) => (
          <div key={post._id}>
            <h3>{post.title}</h3>
            <p>{post.description}</p>
            {post.image && (
              <img
                src={`http://localhost:5000/uploads/${post.image}`}
                alt="Post Image"
                style={{ maxWidth: "100%", height: "auto" }}
              />
            )}
            <button onClick={() => handleLike(post._id)}>Like ({post.likes})</button>

            <form
              onSubmit={(e) => {
                e.preventDefault();
                const commentInput = e.target.elements.commentContent;
                handleAddComment(post._id, commentInput.value);
                commentInput.value = ""; // Clear input field after successful submission
              }}
            >
              <input
                type="text"
                name="commentContent"
                placeholder="Add a comment"
                required
              />
              <button type="submit">Comment</button>
            </form>

            <div>
              {post.comments.map((comment) => (
                <div key={comment._id}>{comment.content}</div>
              ))}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

export default BlogPage;
