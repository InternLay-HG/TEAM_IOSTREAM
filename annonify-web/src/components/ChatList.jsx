// ChatList.js
import React from "react";
import { FaSearch } from "react-icons/fa";

function ChatList({ onSelectChat }) {
  const chatGroups = [...Array(100)].map((_, index) => ({
    id: index,
    name: `Chat Group - ${index + 1}`,
    lastMessage: "Last message in chat...",
  }));

  return (
    <div className="w-[30%] h-full overflow-y-auto bg-black text-gray-400"> {/* Increased width */}
      <div className="p-4">
        <div className="relative">
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
            key={chat.id}
            className="flex items-center p-3 rounded hover:bg-[#1a1a1a] cursor-pointer"
            onClick={() => onSelectChat(chat)}
          >
            <img
              src={`https://via.placeholder.com/50?text=User+${chat.id + 1}`}
              alt={`User ${chat.id + 1}`}
              className="w-10 h-10 rounded-full"
            />
            <div className="ml-4">
              <h4 className="text-white font-semibold font-roboto-mono">{chat.name}</h4>
              <p className="text-gray-500 text-sm font-roboto-mono">{chat.lastMessage}</p>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

export default ChatList;
