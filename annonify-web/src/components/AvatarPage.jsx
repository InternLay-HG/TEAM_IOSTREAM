import React, { useState } from "react";

function AvatarPage({ onAvatarSelect }) {
  const avatarSeeds = [
    "Leo", "George", "Eliza", "Aiden", "Jessica", "Aidan", "Amaya", "Emery", 
    "Adrian", "Alexander", "Jade", "Andrea", "Jocelyn", "Brian", "Jameson", "Liliana", 
    "Liam", "Kimberly", "Kingston", "Easton",
  ]; // Updated seeds for different avatars
  const [selectedAvatar, setSelectedAvatar] = useState(null); // Track the selected avatar

  // Function to generate the correct avatar URL
  const generateAvatarUrl = (seed) => {
    const baseUrl = seed === "Chase" || seed === "Eden" || seed === "Sadie" || seed === "Robert" 
      ? "https://api.dicebear.com/9.x/bottts/svg?seed=" 
      : "https://api.dicebear.com/9.x/adventurer/svg?seed=";

    return `${baseUrl}${seed}`;
  };

  return (
    <div className="avatar-page flex h-screen w-screen bg-[#1a1a1a] font-roboto-mono relative">
      {/* Left Section - centered content */}
      <div className="w-1/2 p-10 flex flex-col items-center justify-center">
        <h2 className="text-blue-500 text-6xl font-bold mb-6 text-center">
          <span className="block">CHOOSE YOUR</span>
          <span className="block">AVATAR</span>
        </h2>
      </div>

      {/* Right Section - avatar selection */}
      <div className="w-1/2 p-10 flex flex-wrap items-center justify-center" style={{ gap: "10px", alignItems: "flex-start", columnGap: "16px" }}>
        {avatarSeeds.map((seed) => (
          <div
            key={seed}
            onClick={() => setSelectedAvatar(seed)}
            className={`avatar-item cursor-pointer relative transition-all duration-300 ease-in-out transform ${
              selectedAvatar === seed ? "scale-110" : "" // Optional: Scale effect on select
            }`}
            style={{
              margin: "0", // Ensure no extra margins are applied
            }}
          >
            {/* Wrapper div for the same-size white background circle */}
            <div
              className={`w-28 h-28 bg-white rounded-full flex items-center justify-center transition-all duration-300 ${
                selectedAvatar === seed
                  ? "border-4 border-blue-500" // Blue border for selected avatar
                  : "hover:ring-2 hover:ring-blue-300" // Slight blue ring on hover
              }`}
            >
              <img
                src={generateAvatarUrl(seed)} // Use the correct avatar URL
                alt={seed}
                className="w-22 h-22 rounded-full" // Decreased avatar size (22x22) within the same-size circle
              />
            </div>
          </div>
        ))}
      </div>

      {/* Continue Button positioned at the bottom right */}
      <div className="absolute bottom-10 right-10">
        <button
          onClick={() => onAvatarSelect(selectedAvatar)}
          className="continue-btn bg-blue-500 text-[#1a1a1a] font-semibold px-8 py-3 rounded-3xl hover:bg-blue-600 transition duration-300"
        >
          CONTINUE
        </button>
      </div>
    </div>
  );
}

export default AvatarPage;
