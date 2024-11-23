import React, { useState } from "react";
import { MdDriveFileRenameOutline, MdAlternateEmail, MdOutlineRemoveRedEye, MdVisibilityOff } from "react-icons/md";
import image from "./info.jpg";

function SignupPage({ onSignup, selectedAvatar, onLoginClick }) {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [name, setName] = useState("");
  const [passwordVisible, setPasswordVisible] = useState(false);
  const [confirmPasswordVisible, setConfirmPasswordVisible] = useState(false);

  const handleSubmit = async (event) => {
    event.preventDefault();

    if (password !== confirmPassword) {
      alert("Passwords do not match!");
      return;
    }

    const userData = {
      email,
      password,
      name,
      avatar: selectedAvatar,
    };

    try {
      const response = await fetch("http://localhost:5000/api/signup", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(userData),
      });

      const data = await response.json();

      if (response.ok) {
        console.log("Signup successful:", data);
        alert("Account created successfully! Please log in.");
        onLoginClick(); // Redirect to login page after successful signup
      } else {
        console.error("Signup failed:", data);
        alert("Signup failed! Please try again.");
      }
    } catch (error) {
      console.error("Error during signup:", error);
      alert("An error occurred. Please try again later.");
    }
  };

  return (
    <div className="signup-page flex h-screen w-screen bg-[#1a1a1a] font-roboto-mono">
      <div className="w-[40%] p-10 flex flex-col items-center justify-center">
        <h2 className="text-blue-500 text-3xl font-bold mb-6">WELCOME TO ANNONIFY</h2>
        <p className="text-gray-400 mb-6">CREATE NEW ACCOUNT</p>

        <form onSubmit={handleSubmit} className="w-full flex flex-col items-center">
          {/* Input fields */}
          <div className="relative mb-6 w-full">
            <input
              type="email"
              placeholder="E-mail"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className="input-field border-b border-gray-700 text-white placeholder-gray-500 focus:outline-none focus:border-blue-500 px-4 py-2 w-full bg-transparent pr-10"
            />
            <MdAlternateEmail className="absolute right-4 top-1/2 transform -translate-y-1/2 text-gray-500 text-xl" />
          </div>

          <div className="relative mb-6 w-full">
            <input
              type={passwordVisible ? "text" : "password"}
              placeholder="Password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              className="input-field border-b border-gray-700 text-white placeholder-gray-500 focus:outline-none focus:border-blue-500 px-4 py-2 w-full bg-transparent pr-10"
            />
            <span
              className="absolute right-4 top-1/2 transform -translate-y-1/2 text-gray-500 text-xl cursor-pointer"
              onClick={() => setPasswordVisible(!passwordVisible)}
            >
              {passwordVisible ? <MdOutlineRemoveRedEye /> : <MdVisibilityOff />}
            </span>
          </div>

          <div className="relative mb-6 w-full">
            <input
              type={confirmPasswordVisible ? "text" : "password"}
              placeholder="Confirm Password"
              value={confirmPassword}
              onChange={(e) => setConfirmPassword(e.target.value)}
              className="input-field border-b border-gray-700 text-white placeholder-gray-500 focus:outline-none focus:border-blue-500 px-4 py-2 w-full bg-transparent pr-10"
            />
            <span
              className="absolute right-4 top-1/2 transform -translate-y-1/2 text-gray-500 text-xl cursor-pointer"
              onClick={() => setConfirmPasswordVisible(!confirmPasswordVisible)}
            >
              {confirmPasswordVisible ? <MdOutlineRemoveRedEye /> : <MdVisibilityOff />}
            </span>
          </div>

          <div className="relative mb-6 w-full">
            <input
              type="text"
              placeholder="Name"
              value={name}
              onChange={(e) => setName(e.target.value)}
              className="input-field border-b border-gray-700 text-white placeholder-gray-500 focus:outline-none focus:border-blue-500 px-4 py-2 w-full bg-transparent"
            />
            <MdDriveFileRenameOutline className="absolute right-4 top-1/2 transform -translate-y-1/2 text-gray-500 text-xl" />
          </div>

          <button
            type="submit"
            className="signup-btn mt-6 bg-blue-500 text-[#1a1a1a] font-semibold px-0 py-2.5 rounded-3xl hover:bg-blue-600 transition duration-300 w-full max-w-xs mx-auto"
          >
            SIGN UP
          </button>
        </form>

        <p className="text-gray-400 mt-6 text-center">
          Already have an account?{" "}
          <span
            className="text-blue-500 cursor-pointer"
            onClick={onLoginClick} // Redirect to login page
          >
            LOGIN
          </span>
        </p>
      </div>

      <div className="flex-1 h-full">
        <img src={image} alt="Info" className="w-full h-full object-cover" />
      </div>
    </div>
  );
}

export default SignupPage;
