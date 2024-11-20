import React, { useState } from "react";

function AvatarPage({ onAvatarSelect }) {
  const avatarSeeds = [
    "Brian", "Kimberly", "Kingston", "Eden", "Easton", "Brooklynn", "Oliver", "Chase",
    "Maria", "Sarah", "Avery", "Sadie", "Emery", "Sara", "Ryan", 
    "Robert",
  ];

  const [selectedAvatar, setSelectedAvatar] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const generateAvatarUrl = (seed) => {
    const baseUrl = seed === "Chase" || seed === "Eden" || seed === "Sadie" || seed === "Robert" 
      ? "https://api.dicebear.com/9.x/bottts/svg?seed=" 
      : "https://api.dicebear.com/9.x/adventurer/svg?seed=";
    return `${baseUrl}${seed}`;
  };

  const handleContinue = () => {
    if (!selectedAvatar) {
      alert("Please select an avatar before continuing.");
      return;
    }

    const avatarUrl = generateAvatarUrl(selectedAvatar); // Generate the avatar URL

    // Pass the selected avatar URL to the parent (App.js)
    onAvatarSelect(avatarUrl);
  };

  return (
    <div className="avatar-page flex h-screen w-screen bg-[#1a1a1a] font-roboto-mono relative">
      <div className="w-1/2 p-10 flex flex-col items-center justify-center">
        <h2 className="text-blue-500 text-6xl font-bold mb-6 text-center">CHOOSE YOUR AVATAR</h2>
      </div>

      <div className="w-1/2 p-6 flex flex-wrap items-center justify-center gap-3">
        {avatarSeeds.map((seed) => (
          <div
            key={seed}
            onClick={() => setSelectedAvatar(seed)}
            className={`avatar-item cursor-pointer relative ${
              selectedAvatar === seed ? "scale-110" : ""
            }`}
          >
            <div className={`w-28 h-28 bg-white rounded-full flex items-center justify-center transition-all ${selectedAvatar === seed ? "border-4 border-blue-500" : "hover:ring-2 hover:ring-blue-300"}`}>
              <img
                src={generateAvatarUrl(seed)}
                alt={seed}
                className="w-22 h-22 rounded-full"
              />
            </div>
          </div>
        ))}
      </div>

      {error && <div className="absolute bottom-20 left-1/2 transform -translate-x-1/2 text-red-500">{error}</div>}
      {loading && <div className="absolute bottom-20 left-1/2 transform -translate-x-1/2 text-blue-500">Updating avatar...</div>}

      <div className="absolute bottom-10 right-10">
        <button onClick={handleContinue} className="continue-btn bg-blue-500 text-[#1a1a1a] font-semibold px-8 py-3 rounded-3xl hover:bg-blue-600" disabled={loading}>
          CONTINUE
        </button>
      </div>
    </div>
  );
}

export default AvatarPage;