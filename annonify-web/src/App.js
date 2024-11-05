import React, { useState } from "react";
import Sidebar from "./components/Sidebar";
import ChatList from "./components/ChatList";
import ChatWindow from "./components/ChatWindow";
import ChatDetails from "./components/ChatDetails";

function App() {
  const [selectedChat, setSelectedChat] = useState(null);
  const [showDetails, setShowDetails] = useState(false); // New state for toggling details

  const handleChatSelect = (chat) => {
    setSelectedChat(chat);
    setShowDetails(false); // Reset details visibility when selecting a new chat
  };

  const toggleChatDetails = () => {
    setShowDetails((prev) => !prev); // Toggle visibility
  };

  return (
    <div className="flex h-screen bg-gray-800">
      <Sidebar />
      <div className="flex flex-1 overflow-hidden">
        <ChatList onSelectChat={handleChatSelect} />
        <div className="w-[1px] bg-gray-700"></div>
        <div className="flex flex-1">
          <ChatWindow chat={selectedChat} toggleDetails={toggleChatDetails} />
          {selectedChat && showDetails && <ChatDetails chat={selectedChat} />}
        </div>
      </div>
    </div>
  );
}

export default App;
