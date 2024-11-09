import React from "react";
import { IoSendOutline, IoAttachOutline } from "react-icons/io5"; // Import the attachment icon

function MessageInput() {
  return (
    <div className="p-4 flex items-center bg-black">
      {/* Attachment Button */}
      <button className="mr-2 text-blue-500 hover:text-gray-200">
        <span className="material-icons text-3xl">
          <IoAttachOutline />
        </span>
      </button>

      {/* Input Field */}
      <input
        type="text"
        placeholder="Type your message..."
        className="flex-1 p-2 rounded border border-blue-500 bg-black text-white placeholder-gray-300 focus:outline-none font-roboto-mono" // Add font class
      />
      
      {/* Send Button */}
      <button className="ml-2 text-blue-500 hover:text-gray-200">
        <span className="material-icons text-2xl">
          <IoSendOutline />
        </span>
      </button>
    </div>
  );
}

export default MessageInput;
