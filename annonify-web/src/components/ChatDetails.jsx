import React from "react";
import { FaRegHeart, FaBellSlash, FaPhotoVideo } from "react-icons/fa";
import { AiOutlineFile } from "react-icons/ai";
import { RiLink } from "react-icons/ri";

function ChatDetails({ chat }) {
  return (
    <div
      className={`w-[40%] h-full ${
        chat ? "bg-[#1a1a1a]" : "bg-black"
      } text-gray-300 flex flex-col items-center p-4 space-y-8`}
    >
      {chat ? (
        <>
          <h2 className="text-blue-500 text-lg font-semibold font-roboto-mono">
            {chat.name} Details
          </h2>
          <div className="flex space-x-6 text-gray-400">
            <FaRegHeart className="cursor-pointer text-xl hover:text-white" />
            <FaBellSlash className="cursor-pointer text-xl hover:text-white" />
          </div>
          <p className="text-sm text-center text-gray-400 font-roboto-mono">
            {chat.description || "No description available for this chat."}
          </p>
          <div className="w-full">
            <h3 className="text-blue-500 text-sm font-semibold mb-2 font-roboto-mono text-center">
              Photos and Videos
            </h3>
            <div className="flex justify-center space-x-2 overflow-x-auto">
              {[...Array(3)].map((_, idx) => (
                <FaPhotoVideo key={idx} className="w-10 h-10 text-gray-600" />
              ))}
            </div>
          </div>
          <div className="w-full">
            <h3 className="text-blue-500 text-sm font-semibold mb-2 font-roboto-mono text-center">
              Shared Documents
            </h3>
            <div className="space-y-2 text-gray-400">
              {[...Array(2)].map((_, idx) => (
                <div key={idx} className="flex items-center justify-center space-x-2 hover:text-white cursor-pointer">
                  <AiOutlineFile />
                  <span>Document {idx + 1}</span>
                </div>
              ))}
            </div>
          </div>
          <div className="w-full">
            <h3 className="text-blue-500 text-sm font-semibold mb-2 font-roboto-mono text-center">
              Shared Links
            </h3>
            <div className="space-y-2 text-gray-400">
              {[...Array(2)].map((_, idx) => (
                <div key={idx} className="flex items-center justify-center space-x-2 hover:text-white cursor-pointer">
                  <RiLink />
                  <span>Link {idx + 1}</span>
                </div>
              ))}
            </div>
          </div>
        </>
      ) : null}
    </div>
  );
}

export default ChatDetails;
