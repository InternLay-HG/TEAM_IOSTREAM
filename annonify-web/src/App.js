import React, { useState } from "react";
import Sidebar from "./components/Sidebar";
import ChatList from "./components/ChatList";
import ChatWindow from "./components/ChatWindow";
import ChatDetails from "./components/ChatDetails";
import SignupPage from "./components/SignupPage";
import AvatarPage from "./components/AvatarPage";
import LoginPage from "./components/LoginPage";
import BlogPage from "./components/BlogPage";
import AssignmentsPage from "./components/AssignmentPage"; // Import AssignmentsPage

function App() {
  const [currentPage, setCurrentPage] = useState("avatar");
  const [selectedAvatar, setSelectedAvatar] = useState(null);
  const [selectedChat, setSelectedChat] = useState(null);
  const [showDetails, setShowDetails] = useState(false);
  const [userId, setUserId] = useState(null);
  const [groupId, setGroupId] = useState(null); // Initialize as null

  const handleAvatarSelect = (avatarUrl) => {
    setSelectedAvatar(avatarUrl);
    setCurrentPage("signup");
  };

  const handleNavigateToBlog = () => setCurrentPage("blog");
  const handleNavigateToChat = () => setCurrentPage("chat");

  const handleNavigateToAssignments = () => setCurrentPage("assignments");

  const handleLogin = (data) => {
    setUserId(data.userId);
    setCurrentPage("chat");
  };

  const handleSignup = (data) => {
    setUserId(data.userId);
    setCurrentPage("chat");
  };

  const handleChatSelect = (chat) => {
    setSelectedChat(chat); // Store selected chat details
    setGroupId(chat._id); // Dynamically update groupId from selected chat
  };

  return (
    <div className="flex h-screen bg-gray-800">
      {currentPage === "avatar" && (
        <AvatarPage onAvatarSelect={handleAvatarSelect} />
      )}
      {currentPage === "signup" && (
        <SignupPage
          onSignup={handleSignup}
          onLoginClick={() => setCurrentPage("login")}
          selectedAvatar={selectedAvatar}
        />
      )}
      {currentPage === "login" && (
        <LoginPage
          onLogin={handleLogin}
          onSignupClick={() => setCurrentPage("signup")}
        />
      )}
      {currentPage === "chat" && (
        <>
          <Sidebar
            userAvatar={selectedAvatar}
            onNavigateToBlog={handleNavigateToBlog}
            onNavigateToChat={handleNavigateToChat}
            onNavigateToAssignments={handleNavigateToAssignments}
          />
          <div className="flex flex-1 overflow-hidden">
            <ChatList
              userId={userId}
              onSelectChat={handleChatSelect}
            />
            <div className="w-[1px] bg-gray-700"></div>
            <div className="flex flex-1">
              <ChatWindow
                chat={selectedChat}
                userId={userId}
                groupId={groupId}
                toggleDetails={() => setShowDetails((prev) => !prev)}
              />
              {selectedChat && showDetails && (
                <ChatDetails chat={selectedChat} />
              )}
            </div>
          </div>
        </>
      )}
      {currentPage === "blog" && (
        <>
          <Sidebar
            userAvatar={selectedAvatar}
            onNavigateToBlog={handleNavigateToBlog}
            onNavigateToChat={handleNavigateToChat}
            onNavigateToAssignments={handleNavigateToAssignments}
          />
          <div className="flex-1 overflow-hidden">
            <BlogPage userId={userId} /> {/* Pass userId prop to BlogPage */}
          </div>
        </>
      )}
      {currentPage === "assignments" && (
        <>
          <Sidebar
            userAvatar={selectedAvatar}
            onNavigateToBlog={handleNavigateToBlog}
            onNavigateToChat={handleNavigateToChat}
            onNavigateToAssignments={handleNavigateToAssignments}
          />
          <div className="flex-1 overflow-hidden">
            <AssignmentsPage userId={userId} />
          </div>
        </>
      )}
    </div>
  );
}

export default App;