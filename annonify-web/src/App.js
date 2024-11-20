import React, { useState, useEffect } from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Sidebar from "./components/Sidebar";
import ChatList from "./components/ChatList";
import ChatWindow from "./components/ChatWindow";
import ChatDetails from "./components/ChatDetails";
import SignupPage from "./components/SignupPage";
import AvatarPage from "./components/AvatarPage";
import LoginPage from "./components/LoginPage";
import BlogPage from "./components/BlogPage";
import Assignments from "./components/AssignmentPage"; // Import your Assignments component

function App() {
    const [currentPage, setCurrentPage] = useState("avatar");
    const [selectedAvatar, setSelectedAvatar] = useState(null);
    const [selectedChat, setSelectedChat] = useState(null);
    const [showDetails, setShowDetails] = useState(false);
    const [userId, setUserId] = useState(null);
    const [groupId, setGroupId] = useState(null);
    const [assignments, setAssignments] = useState([]); // State for assignments

    useEffect(() => {
        const fetchAssignments = async () => {
            try {
                const response = await fetch('/api/assignments'); // Adjust the API endpoint as needed
                const data = await response.json();
                setAssignments(data);
            } catch (error) {
                console.error("Error fetching assignments:", error);
            }
        };
        fetchAssignments();
    }, []);

    const handleAvatarSelect = (avatarUrl) => {
        setSelectedAvatar(avatarUrl);
        setCurrentPage("signup");
    };

    const handleNavigateToBlog = () => setCurrentPage("blog");

    const handleNavigateToChat = () => setCurrentPage("chat");

    const handleLogin = (data) => {
        setUserId(data.userId);
        setCurrentPage("chat");
    };

    const handleSignup = (data) => {
        setUserId(data.userId);
        setCurrentPage("chat");
    };

    const handleChatSelect = (chat) => {
        setSelectedChat(chat);
        setGroupId(chat._id);
    };

    return (
        <Router>
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
                        />
                        <BlogPage />
                    </>
                )}
                {currentPage === "assignments" && (
                    <>
                        <Sidebar
                            userAvatar={selectedAvatar}
                            onNavigateToBlog={handleNavigateToBlog}
                            onNavigateToChat={handleNavigateToChat}
                        />
                        <Assignments assignments={assignments} />
                    </>
                )}
            </div>
        </Router>
    );
}

export default App;