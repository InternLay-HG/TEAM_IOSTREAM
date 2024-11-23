import React, { useState } from "react";
import { IoSendOutline, IoAttachOutline } from "react-icons/io5"; // Import the attachment icon

function MessageInput({ onSendMessage }) {
  const [message, setMessage] = useState("");
  const [attachment, setAttachment] = useState(null); // State to handle attachment
  const handleSend = () => {
    if (message.trim() || attachment) {
      onSendMessage(message, attachment); // Send both message and attachment
      setMessage(""); // Clear input field after sending
      setAttachment(null); // Reset attachment after sending
    }
  };
  

  const handleKeyPress = (e) => {
    if (e.key === "Enter") {
      e.preventDefault();
      handleSend();
    }
  };

  const handleAttachmentChange = (e) => {
    const file = e.target.files[0];
    if (file) {
      setAttachment(file); // Set the selected file as the attachment
    }
  };

  return (
    <div className="p-4 flex items-center bg-black">
      {/* Attachment Button */}
      <label htmlFor="attachment" className="mr-2 text-blue-500 hover:text-gray-200 cursor-pointer">
        <IoAttachOutline className="text-3xl" />
      </label>
      <input
        id="attachment"
        type="file"
        onChange={handleAttachmentChange}
        className="hidden" // Hide the actual file input field
      />

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
