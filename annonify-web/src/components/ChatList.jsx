import React, { useState, useEffect } from "react";
import { FaSearch } from "react-icons/fa";
import "./ChatList.css";

function ChatList({ userId, onSelectChat }) {
  const [selectedChat, setSelectedChat] = useState(null);
  const [chatGroups, setChatGroups] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchGroups = async () => {
      try {
        const response = await fetch(`http://localhost:5000/api/groups/${userId}`);
        if (!response.ok) {
          throw new Error("Failed to fetch groups");
        }
        const data = await response.json();
        setChatGroups(data); // Set the fetched groups
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    if (userId) {
      fetchGroups(); // Fetch groups when userId changes
    }
  }, [userId]);

  const handleSelectChat = (chat) => {
    setSelectedChat(chat._id); // Update selected chat with the group ID
    onSelectChat(chat); // Pass the selected chat to the parent
  };

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error}</div>;

  return (
    <div className="w-[30%] h-full overflow-y-auto bg-black text-gray-400">
      <div className="p-4">
        <div className="relative mt-4">
          <input
            type="text"
            placeholder="Search"
            className="w-full p-2 pl-10 rounded bg-[#1a1a1a] text-gray-300 placeholder-gray-500 font-roboto-mono"
          />
          <span className="absolute top-1/2 left-3 transform -translate-y-1/2 text-gray-500">
            <FaSearch />
          </span>
        </div>
      </div>
      <div className="space-y-4 p-4">
        {chatGroups.map((chat) => (
          <div
            key={chat._id}
            className={`flex items-center p-4 rounded cursor-pointer min-h-[80px] 
              ${selectedChat === chat._id ? "bg-[#1a1a1a]" : "hover:bg-[#2c2c2c]"}`}
            onClick={() => handleSelectChat(chat)}
          >
            <img
              src={`https://via.placeholder.com/50?text=Group+${chat.name}`}
            alt={chat.name}
            className="w-12 h-12 rounded-lg"
            />
            <div className="ml-4">
              <h4 className="text-white font-semibold font-roboto-mono">{chat.name}</h4>
              <p className="text-gray-500 text-sm font-roboto-mono">Last message in chat...</p>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

export default ChatList;