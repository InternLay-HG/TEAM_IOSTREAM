import React, { useState } from "react";
import { FaSearch } from "react-icons/fa";
import "./ChatList.css";

function ChatList({ onSelectChat }) {
  const [selectedChat, setSelectedChat] = useState(null);

  // List of group names
  const chatGroups = [
    { id: 1, name: "HOUSE OF GEEKS", lastMessage: "Last message in chat..." },
    { id: 2, name: "SPORTS SOCIETY", lastMessage: "Last message in chat..." },
    { id: 3, name: "HOSTEL COMMITTEE", lastMessage: "Last message in chat..." },
    { id: 4, name: "MESS COMMITTEE", lastMessage: "Last message in chat..." },
    { id: 5, name: "E-CELL", lastMessage: "Last message in chat..." },
    { id: 6, name: "SAAZ", lastMessage: "Last message in chat..." },
    { id: 7, name: "RANGBAAZ", lastMessage: "Last message in chat..." },
    { id: 8, name: "KIRTI", lastMessage: "Last message in chat..." },
    { id: 9, name: "CONFESSION GROUP", lastMessage: "Last message in chat..." },
    { id: 10, name: "1ST YEAR", lastMessage: "Last message in chat..." },
    { id: 11, name: "2ND YEAR", lastMessage: "Last message in chat..." },
    { id: 12, name: "3RD YEAR", lastMessage: "Last message in chat..." },
    { id: 13, name: "4TH YEAR", lastMessage: "Last message in chat..." },
  ];

  const handleSelectChat = (chat) => {
    setSelectedChat(chat.id); // Update selected chat
    onSelectChat(chat); // Pass the selected chat to the parent
  };

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
            key={chat.id}
            className={`flex items-center p-4 rounded cursor-pointer min-h-[80px] 
              ${selectedChat === chat.id ? "bg-[#1a1a1a]" : "hover:bg-[#2c2c2c]"}`}
            onClick={() => handleSelectChat(chat)}
          >
            <img
              src={`https://via.placeholder.com/50?text=User+${chat.id}`}
              alt={`User ${chat.id}`}
              className="w-12 h-12 rounded-lg"
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
