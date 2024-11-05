import React from "react";
import { PiChatsBold } from "react-icons/pi";
import { IoLinkSharp } from "react-icons/io5";
import { MdOutlinePermMedia } from "react-icons/md";

function Sidebar() {
  return (
    <aside className="w-[10%] bg-[#1a1a1a] text-gray-300 flex flex-col justify-between">
      <div>
        <div className="pt-8 pb-12 flex items-center justify-center">
          <span className="text-2xl font-semibold font-roboto-mono">TL</span> {/* Apply font */}
        </div>
        <div className="p-4 space-y-10">
          <nav className="flex flex-col items-center space-y-8">
            <div className="flex flex-col items-center text-gray-200 hover:text-white cursor-pointer">
              <PiChatsBold size={24} />
              <span className="text-sm mt-2 font-roboto-mono">ALL CHATS</span> {/* Apply font */}
            </div>
            <div className="flex flex-col items-center text-gray-200 hover:text-white cursor-pointer">
              <MdOutlinePermMedia size={24} />
              <span className="text-sm mt-2 font-roboto-mono">MEDIA</span> {/* Apply font */}
            </div>
            <div className="flex flex-col items-center text-gray-200 hover:text-white cursor-pointer">
              <IoLinkSharp size={24} />
              <span className="text-sm mt-2 font-roboto-mono">LINKS</span> {/* Apply font */}
            </div>
          </nav>
        </div>
      </div>
      <div className="p-6">
        <div className="flex items-center justify-center">
          <img
            src="https://via.placeholder.com/40"
            alt="User Avatar"
            className="rounded-full w-8 h-8"
          />
        </div>
      </div>
    </aside>
  );
}

export default Sidebar;
