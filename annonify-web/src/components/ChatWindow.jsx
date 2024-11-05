import React from "react";
import MessageInput from "./MessageInput";
import { FaSearch } from "react-icons/fa";
import { IoMdMore } from "react-icons/io";
import { PiSquareSplitHorizontal } from "react-icons/pi";

function ChatWindow({ chat, toggleDetails }) {
  if (!chat) {
    return <div className="w-full bg-black text-gray-400 flex flex-col overflow-hidden"></div>;
  }

  return (
    <div className="w-full h-full overflow-y-auto bg-black text-gray-400 flex flex-col">
      <div className="flex items-center justify-between p-4">
        <h2 className="text-lg text-white font-semibold font-roboto-mono">
          {chat.name}
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
      <div className="flex-1 p-4 overflow-y-auto">
        <p>Messages for {chat.name} will appear here.</p>
      </div>
      {chat && <MessageInput />}
    </div>
  );
}

export default ChatWindow;
