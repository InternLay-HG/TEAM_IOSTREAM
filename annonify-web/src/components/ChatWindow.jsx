import React, { useEffect, useState, useRef } from "react";
import io from "socket.io-client";
import MessageInput from "./MessageInput";
import { FaSearch } from "react-icons/fa";
import { IoMdMore } from "react-icons/io";
import { PiSquareSplitHorizontal } from "react-icons/pi";
import windowImage from './background4.png'; // Import the image

function ChatWindow({ chat, userId, groupId, toggleDetails }) {
  const [messages, setMessages] = useState([]);
  const socket = useRef(null); // Using useRef to persist socket instance

  useEffect(() => {
    // Establish socket connection and join the group
    socket.current = io("http://localhost:5000", {
      query: {
        userId: userId,
        groupId: groupId,
      },
    });

    socket.current.emit('join group', groupId); // Ensure the user joins the group

    socket.current.on("chat message", (msg) => {
      console.log("Received message from server:", msg);
      setMessages((prevMessages) => [...prevMessages, msg]);
    });

    // socket.current.on('messageBlocked', (data) => {
    //   alert(`Your message was blocked. Reason: ${data.reason || 'Toxic content'} | Score: ${data.score}`);
    // });

    // Cleanup on unmount
    return () => {
      socket.current.emit("leave group", groupId); // Notify server about leaving the group
      socket.current.off("chat message");
      socket.current.disconnect();
    };
  }, [groupId, userId]); // This effect should run when groupId or userId changes

  useEffect(() => {
    // Fetch messages for the selected group from the backend
    const fetchMessages = async () => {
      try {
        const response = await fetch(`http://localhost:5000/api/messages/${groupId}`);
        const data = await response.json();
        if (Array.isArray(data) && data.length > 0) {
          setMessages(data);
        } else {
          console.log("No messages found for this group");
        }
      } catch (error) {
        console.error("Error fetching messages:", error);
      }
    };

    fetchMessages(); // Fetch messages when the component mounts or when groupId changes
  }, [groupId]); // This effect should run when groupId changes

  const sendMessage = (msgContent) => {
    console.log("Group ID:", groupId); // Debugging groupId
    socket.current.emit("chat message", {
      content: msgContent,
      user: {
        _id: userId,
        name: 'Your Name', // Replace with the actual user name if available
      },
      group: {
        _id: groupId,
      },
      timestamp: new Date().toISOString(),
    });
  };

  useEffect(() => {
    // Scroll to the bottom when new messages arrive
    const messageContainer = document.getElementById("messages");
    if (messageContainer) {
      messageContainer.scrollTop = messageContainer.scrollHeight;
    }
  }, [messages]);

  if (!chat) {
    return <div className="w-full bg-black text-gray-400 flex flex-col overflow-hidden"></div>;
  }

  return (
    <div className="w-full h-full overflow-y-auto bg-black text-gray-400 flex flex-col">
      {/* Header section */}
      <div className="flex items-center justify-between p-4 z-10">
        <h2 className="text-lg text-white font-semibold font-roboto-mono">
          {chat?.name || "Chat Room"}
        </h2>
        <div className="flex items-center space-x-4">
          <span className="cursor-pointer text-lg" style={{ fontSize: '1.25rem' }}>
            <FaSearch />
          </span>
          <span className="cursor-pointer text-lg" style={{ fontSize: '1.25rem' }} onClick={toggleDetails}>
            <PiSquareSplitHorizontal />
          </span>
          <span className="cursor-pointer text-lg" style={{ fontSize: '1.25rem' }}>
            <IoMdMore />
          </span>
        </div>
      </div>

      {/* Main chat area with background image */}
      <div
        className="flex-1 p-4 overflow-y-auto"
        style={{
          backgroundImage: `url(${windowImage})`,
          backgroundSize: 'cover',
          backgroundPosition: 'center',
        }}
      >
        <ul id="messages" className="flex flex-col space-y-3">
          {messages.map((msg, index) => (
            <li
            key={index}
            className={`mb-2 p-2 rounded-lg ${msg.user._id === userId ? "self-end ml-auto" : ""}`}
            style={{
                wordBreak: "break-word",
                maxWidth: "80%",
                padding: "0.5rem 1rem",
                marginBottom: "10px",
                borderRadius: "15px",
                backgroundColor: msg.user._id === userId ? "#7725AD" : "#4F84E8",
                color: "white",
                alignSelf: msg.user._id === userId ? "flex-end" : "flex-start",
            }}
        >
            <strong>{msg.user.name || "Unknown User"}: </strong>{msg.content}
        </li>
        
          ))}
        </ul>
      </div>

      {/* Input section for sending messages */}
      <MessageInput onSendMessage={sendMessage} />
    </div>
  );
}

export default ChatWindow;
