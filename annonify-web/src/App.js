import React, { useState } from "react";
import Sidebar from "./components/Sidebar";
import ChatList from "./components/ChatList";
import ChatWindow from "./components/ChatWindow";
import ChatDetails from "./components/ChatDetails";
import SignupPage from "./components/SignupPage";
import AvatarPage from "./components/AvatarPage";
import LoginPage from "./components/LoginPage";


function App() {
  const [currentPage, setCurrentPage] = useState("signup");
  const [selectedChat, setSelectedChat] = useState(null);
  const [showDetails, setShowDetails] = useState(false);

  const handleSignup = () => setCurrentPage("avatar");
  const handleAvatar = () => setCurrentPage("login");
  const handleLogin = () => setCurrentPage("chat");

  const handleChatSelect = (chat) => {
    setSelectedChat(chat);
    setShowDetails(false);
  };

  const toggleChatDetails = () => {
    setShowDetails((prev) => !prev);
  };

  return (
    <div className="flex h-screen bg-gray-800">
      {currentPage === "signup" && <SignupPage onSignup={handleSignup} />}
      {currentPage === "avatar" && <AvatarPage onAvatarSelect={handleAvatar} />}
      {currentPage === "login" && <LoginPage onLogin={handleLogin} />}
      {currentPage === "chat" && (
        <>
          <Sidebar />
          <div className="flex flex-1 overflow-hidden">
            <ChatList onSelectChat={handleChatSelect} />
            <div className="w-[1px] bg-gray-700"></div>
            <div className="flex flex-1">
              <ChatWindow chat={selectedChat} toggleDetails={toggleChatDetails} />
              {selectedChat && showDetails && <ChatDetails chat={selectedChat} />}
            </div>
          </div>
        </>
      )}
    </div>
  );
}

export default App;
