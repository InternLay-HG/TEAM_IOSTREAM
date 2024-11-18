import React, { useState } from "react";
import Sidebar from "./components/Sidebar";
import ChatList from "./components/ChatList";
import ChatWindow from "./components/ChatWindow";
import ChatDetails from "./components/ChatDetails";
import SignupPage from "./components/SignupPage";
import AvatarPage from "./components/AvatarPage";
import LoginPage from "./components/LoginPage";
import BlogPage from "./components/BlogPage"; // Import BlogPage

function App() {
  const [currentPage, setCurrentPage] = useState("avatar"); // Start on AvatarPage
  const [selectedAvatar, setSelectedAvatar] = useState(null);
  const [selectedChat, setSelectedChat] = useState(null);
  const [showDetails, setShowDetails] = useState(false);

  // Handle avatar selection
  const handleAvatarSelect = (avatarUrl) => {
    setSelectedAvatar(avatarUrl);
    setCurrentPage("signup"); // Move to signup page after avatar selection
  };

  // Navigate to the Blog page when "BLOGS" is clicked in Sidebar
  const handleNavigateToBlog = () => {
    setCurrentPage("blog");
  };

  // Navigate to the Chat page when "ALL CHATS" is clicked
  const handleNavigateToChat = () => {
    setCurrentPage("chat");
  };

  return (
    <div className="flex h-screen bg-gray-800">
      {currentPage === "avatar" && (
        <AvatarPage onAvatarSelect={handleAvatarSelect} />
      )}
      {currentPage === "signup" && (
        <SignupPage
          onSignup={() => setCurrentPage("chat")}
          onLoginClick={() => setCurrentPage("login")}
          selectedAvatar={selectedAvatar}
        />
      )}
      {currentPage === "login" && (
        <LoginPage
          onLogin={() => setCurrentPage("chat")}
          onSignupClick={() => setCurrentPage("signup")}
        />
      )}
      {currentPage === "chat" && (
        <>
          <Sidebar 
            userAvatar={selectedAvatar} 
            onNavigateToBlog={handleNavigateToBlog} 
            onNavigateToChat={handleNavigateToChat}  // Pass the navigate function to Sidebar
          />
          <div className="flex flex-1 overflow-hidden">
            <ChatList onSelectChat={(chat) => setSelectedChat(chat)} />
            <div className="w-[1px] bg-gray-700"></div>
            <div className="flex flex-1">
              <ChatWindow
                chat={selectedChat}
                toggleDetails={() => setShowDetails((prev) => !prev)}
              />
              {selectedChat && showDetails && <ChatDetails chat={selectedChat} />}
            </div>
          </div>
        </>
      )}
      {currentPage === "blog" && (
        <>
          <Sidebar 
            userAvatar={selectedAvatar} 
            onNavigateToBlog={handleNavigateToBlog} 
            onNavigateToChat={handleNavigateToChat}  // Pass the navigate function to Sidebar
          />
          <BlogPage /> {/* Display BlogPage with full background */}
        </>
      )}
    </div>
  );
}

export default App;