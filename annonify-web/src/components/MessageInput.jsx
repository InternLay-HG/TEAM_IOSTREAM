import React, { useState } from "react";
import { IoSendOutline, IoAttachOutline } from "react-icons/io5"; // Import the attachment icon

function MessageInput({ onSendMessage }) {
  const [message, setMessage] = useState("");

  const handleSend = () => {
    if (message.trim()) {
      onSendMessage(message);
      setMessage(""); // Clear input field after sending
    }
  };

  const handleKeyPress = (e) => {
    if (e.key === "Enter") {
      e.preventDefault();
      handleSend();
    }
  };

  return (
    <div className="p-4 flex items-center bg-black">
      {/* Attachment Button */}
      <button className="mr-2 text-blue-500 hover:text-gray-200">
        <IoAttachOutline className="text-3xl" />
      </button>

      {/* Input Field */}
      <input
        type="text"
        value={message}
        onChange={(e) => setMessage(e.target.value)}
        onKeyPress={handleKeyPress}
        placeholder="Type your message..."
        className="flex-1 p-2 rounded border border-blue-500 bg-black text-white placeholder-gray-300 focus:outline-none font-roboto-mono"
      />
      
      {/* Send Button */}
      <button onClick={handleSend} className="ml-2 text-blue-500 hover:text-gray-200">
        <IoSendOutline className="text-2xl" />
      </button>
    </div>
  );
}

export default MessageInput;
