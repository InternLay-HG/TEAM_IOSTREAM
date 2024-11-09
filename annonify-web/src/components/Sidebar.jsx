import React from "react";
import { PiChatsBold } from "react-icons/pi";
import { IoLinkSharp } from "react-icons/io5"; 
import { MdOutlinePermMedia } from "react-icons/md";
import { IoSettingsOutline } from "react-icons/io5";

function Sidebar() {
  return (
    <aside className="w-[10%] bg-[#1a1a1a] text-gray-300 flex flex-col justify-between">
      <div>
        <div className="pt-8 pb-12 flex items-center justify-center">
          <span className="text-2xl font-semibold font-roboto-mono">TL</span> {/* Apply font */}
        </div>
        <div className="p-4 space-y-10">
          <nav className="flex flex-col items-center space-y-8">
            <div className="flex flex-col items-center text-blue-500 hover:text-white cursor-pointer">
              <PiChatsBold size={24} />
              <span className="text-sm mt-2 font-roboto-mono">ALL CHATS</span>
            </div>
            <div className="flex flex-col items-center text-blue-500 hover:text-white cursor-pointer">
              <MdOutlinePermMedia size={24} />
              <span className="text-sm mt-2 font-roboto-mono">MEDIA</span>
            </div>
            <div className="flex flex-col items-center text-blue-500 hover:text-white cursor-pointer">
              <IoLinkSharp size={24} />
              <span className="text-sm mt-2 font-roboto-mono">LINKS</span>
            </div>
          </nav>
        </div>
      </div>
      <div className="p-6 flex flex-col items-center">
        {/* Settings Icon and Text Below it */}
        <div className="flex flex-col items-center mb-6"> {/* Increased bottom margin here */}
          <IoSettingsOutline size={32} className="text-gray-300 hover:text-white cursor-pointer" />
          <span className="text-sm mt-2 font-roboto-mono text-gray-300 hover:text-white">SETTINGS</span>
        </div>

        {/* User Avatar with increased size */}
        <div>
          <img
            src="https://via.placeholder.com/60" // Increased size for the avatar
            alt="User Avatar"
            className="rounded-full w-13 h-13" // Increased width and height
          />
        </div>
      </div>
    </aside>
  );
}

export default Sidebar;
