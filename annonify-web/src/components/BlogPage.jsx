import React, { useState, useEffect } from "react";
import { ObjectId } from "bson"; // Import ObjectId from bson package

function BlogPage({ userId }) {
  const [posts, setPosts] = useState([]);
  const [newPost, setNewPost] = useState({
    title: "",
    description: "",
    image: null,
  });
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [showCreateForm, setShowCreateForm] = useState(false);

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
      setShowCreateForm(false);
    } catch (err) {
      setError(err.message);
    }
  };

  // Handle Like functionality
  const handleLike = async (postId) => {
    if (!userId) {
      alert("You must be logged in to like a post.");
      return;
    }

    try {
      // Convert userId to ObjectId to ensure it's in the correct format
      const objectIdUserId = new ObjectId(userId);

      const response = await fetch(`http://localhost:5000/api/posts/${postId}/like`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ userId: objectIdUserId.toString() }), // Pass ObjectId as string
      });

      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.message || "Failed to like/unlike post");
      }

      const updatedPost = await response.json();

      // Update the post's like count in state
      setPosts((prevPosts) =>
        prevPosts.map((post) =>
          post._id === postId ? { ...post, likes: updatedPost.likes } : post
        )
      );
    } catch (err) {
      setError(err.message);
    }
  };

  const handleAddComment = async (postId, commentContent) => {
    if (!commentContent.trim()) return;

    try {
      const requestBody = {
        content: commentContent,
        postId: postId,
      };

      const response = await fetch("http://localhost:5000/api/comments", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(requestBody),
      });

      if (!response.ok) {
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
    <div className="flex min-h-screen bg-black">
      <main className="flex-1 flex flex-col bg-black text-white">
        <button
          onClick={() => setShowCreateForm((prev) => !prev)}
          className="bg-blue-600 text-white p-3 rounded-lg mb-6 mx-4 mt-6 hover:bg-blue-700 hover:shadow-lg transition duration-300"
        >
          {showCreateForm ? "Cancel" : "Create New Post"}
        </button>

        {showCreateForm && (
          <div className="p-6 bg-gray-800 shadow-lg rounded-lg mb-6">
            <form
              onSubmit={handleSubmit}
              encType="multipart/form-data"
              className="bg-gray-800 p-6 rounded-lg shadow-lg"
            >
              <h2 className="text-3xl font-bold text-blue-600 mb-4">Create a New Post</h2>
              <input
                type="text"
                name="title"
                placeholder="Title"
                value={newPost.title}
                onChange={handleInputChange}
                required
                className="w-full p-3 border border-gray-600 rounded-lg mb-4 text-white bg-gray-700 focus:outline-none focus:ring-2 focus:ring-blue-400 focus:border-blue-400"
              />
              <textarea
                name="description"
                placeholder="Description"
                value={newPost.description}
                onChange={handleInputChange}
                required
                className="w-full p-3 border border-gray-600 rounded-lg mb-4 text-white bg-gray-700 focus:outline-none focus:ring-2 focus:ring-blue-400 focus:border-blue-400"
              />
              <input
                type="file"
                onChange={handleFileChange}
                required
                className="w-full p-3 border border-gray-600 rounded-lg mb-6"
              />
              <button
                type="submit"
                className="w-full bg-blue-600 hover:bg-blue-700 text-white py-3 rounded-lg transition duration-300"
              >
                Post
              </button>
            </form>
          </div>
        )}

        <div
          id="posts"
          className="flex-1 overflow-y-auto p-6"
          style={{ height: "calc(100vh - 200px)", maxHeight: "calc(100vh - 150px)" }}
        >
          {loading && <div className="text-center text-gray-500">Loading posts...</div>}
          <div className="flex flex-col gap-6">
            {posts.map((post) => (
              <div key={post._id} className="bg-gray-800 p-6 rounded-lg shadow-lg border border-gray-600 flex flex-col md:flex-row">
                <div className="flex-1">
                  <h3 className="text-2xl font-bold text-white mb-4">{post.title}</h3>
                  <p className="text-gray-400 mb-4">{post.description}</p>
                  {post.image && (
                    <img
                      src={`http://localhost:5000/${post.image}`}
                      alt="Post Image"
                      className="rounded-lg mb-4 w-full object-cover"
                    />
                  )}
                  <div className="flex items-center justify-between">
                    <button
                      onClick={() => handleLike(post._id)}
                      className="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-full"
                    >
                      👍 {post.likes}
                    </button>
                  </div>
                </div>

                <div className="w-full md:w-1/3 ml-6 mt-4 md:mt-0">
                  <form
                    onSubmit={(e) => {
                      e.preventDefault();
                      const commentInput = e.target.elements.commentContent;
                      handleAddComment(post._id, commentInput.value);
                      commentInput.value = "";
                    }}
                    className="mt-4"
                  >
                    <input
                      type="text"
                      name="commentContent"
                      placeholder="Add a comment"
                      required
                      className="w-full p-3 bg-gray-700 border border-gray-600 rounded-lg text-white mb-4"
                    />
                    <button
                      type="submit"
                      className="w-full bg-blue-500 text-white py-2 rounded-lg hover:bg-blue-600"
                    >
                      Add Comment
                    </button>
                  </form>

                  <div className="mt-4">
                    {post.comments.map((comment) => (
                      <div key={comment._id} className="bg-gray-700 p-3 rounded-lg mb-4">
                        <p className="text-white">{comment.content}</p>
                      </div>
                    ))}
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </main>
    </div>
  );
}

export default BlogPage;