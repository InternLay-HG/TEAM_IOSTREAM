import React from "react";
import { MdDriveFileRenameOutline,MdAlternateEmail, MdOutlineRemoveRedEye } from "react-icons/md";
import image from "./info.jpg";

function SignupPage({ onSignup }) {
  return (
    <div className="signup-page flex h-screen w-screen bg-[#1a1a1a] font-roboto-mono">
      {/* Left Signup Form - 40% width */}
      <div className="w-[40%] p-10 flex flex-col items-center justify-center">
        <h2 className="text-blue-500 text-3xl font-bold mb-6">WELCOME TO ANNONIFY</h2>
        <p className="text-gray-400 mb-6">CREATE NEW ACCOUNT</p>

        {/* E-mail Input Field */}
        <div className="relative mb-6 w-full">
          <input 
            type="email" 
            placeholder="E-mail" 
            className="input-field border-b border-gray-700 text-white placeholder-gray-500 focus:outline-none focus:border-blue-500 px-4 py-2 w-full bg-transparent pr-10" 
          />
          <MdAlternateEmail className="absolute right-4 top-1/2 transform -translate-y-1/2 text-gray-500 text-xl" />
        </div>

        {/* Password Input Field */}
        <div className="relative mb-6 w-full">
          <input 
            type="password" 
            placeholder="Password" 
            className="input-field border-b border-gray-700 text-white placeholder-gray-500 focus:outline-none focus:border-blue-500 px-4 py-2 w-full bg-transparent pr-10" 
          />
          <MdOutlineRemoveRedEye className="absolute right-4 top-1/2 transform -translate-y-1/2 text-gray-500 text-xl" />
        </div>

        {/* Confirm Password Input Field */}
        <div className="relative mb-6 w-full">
          <input 
            type="password" 
            placeholder="Confirm Password" 
            className="input-field border-b border-gray-700 text-white placeholder-gray-500 focus:outline-none focus:border-blue-500 px-4 py-2 w-full bg-transparent pr-10" 
          />
          <MdOutlineRemoveRedEye className="absolute right-4 top-1/2 transform -translate-y-1/2 text-gray-500 text-xl" />
        </div>

        {/* Name Input Field */}
        <div className="relative mb-6 w-full">
          <input 
            type="text" 
            placeholder="Name" 
            className="input-field border-b border-gray-700 text-white placeholder-gray-500 focus:outline-none focus:border-blue-500 px-4 py-2 w-full bg-transparent" 
          />
          <MdDriveFileRenameOutline className="absolute right-4 top-1/2 transform -translate-y-1/2 text-gray-500 text-xl" />
        </div>

        {/* Signup Button */}
        <button 
          onClick={onSignup} 
          className="signup-btn mt-6 bg-blue-500 text-bg-[#1a1a1a] font-semibold px-0 py-2.5 rounded-3xl hover:bg-blue-600 transition duration-300 w-full max-w-xs mx-auto"
        >
          SIGN UP
        </button>

        <p className="text-gray-400 mt-6 text-center">
          Already have an account? <span className="text-blue-500 cursor-pointer">LOGIN</span>
        </p>
      </div>

      {/* Right Image Section - covers the entire right side */}
      <div className="flex-1 h-full">
        <img src={image} alt="Info" className="w-full h-full object-cover" />
      </div>
    </div>
  );
}

export default SignupPage;
