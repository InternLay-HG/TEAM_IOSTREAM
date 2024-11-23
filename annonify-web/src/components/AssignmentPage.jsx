import React, { useState, useEffect } from "react";
import { toast } from "react-toastify";

function AssignmentsPage({ userId }) {  // Accept userId as prop
  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [dueDate, setDueDate] = useState("");
  const [file, setFile] = useState(null);
  const [assignments, setAssignments] = useState([]);
  const [error, setError] = useState("");
  const [submissionFile, setSubmissionFile] = useState(null);
  const [selectedAssignmentId, setSelectedAssignmentId] = useState(null);
  const [showCreateForm, setShowCreateForm] = useState(false);
  const [submissionSuccessMessage, setSubmissionSuccessMessage] = useState("");

  // Set studentId and professorId based on userId (assuming you have logic to determine this)
  const [studentId, setStudentId] = useState(userId); // Default userId can be set as studentId
  const [professorId, setProfessorId] = useState(userId); // Default userId can be set as professorId

  // Example logic to differentiate between student and professor
  useEffect(() => {
    // You can implement more sophisticated logic here
    // For instance, if the user is a professor, you could query your backend or check user data
    if (userId === "673e241fe07ff92d8f8499fc") {
      // If userId matches a professor ID, assume they are a professor
      setProfessorId(userId);
      setStudentId(null); // No student ID
    } else {
      // Otherwise, assume the user is a student
      setStudentId(userId);
      setProfessorId(null); // No professor ID
    }
  }, [userId]);

  // Fetch assignments from the API
  useEffect(() => {
    const fetchAssignments = async () => {
      try {
        const response = await fetch("http://localhost:5000/api/assignments");
        const data = await response.json();
        setAssignments(data);
      } catch (err) {
        toast.error("Failed to fetch assignments.");
      }
    };

    fetchAssignments();
  }, []);

  // Handle file change for assignment creation
  const handleFileChange = (e) => {
    setFile(e.target.files[0]);
  };

  // Handle file change for assignment submission
  const handleSubmissionFileChange = (e) => {
    setSubmissionFile(e.target.files[0]);
  };

  // Handle creating a new assignment
  const handleSubmit = async (e) => {
    e.preventDefault();

    if (!title || !description || !dueDate || !file) {
      toast.error("All fields are required.");
      return;
    }

    const formData = new FormData();
    formData.append("title", title);
    formData.append("description", description);
    formData.append("dueDate", dueDate);
    formData.append("professorId", professorId); // Send professorId
    formData.append("file", file);

    try {
      const response = await fetch("http://localhost:5000/api/assignments", {
        method: "POST",
        body: formData,
      });

      if (!response.ok) {
        throw new Error("Failed to create assignment.");
      }

      const data = await response.json();
      setAssignments((prevAssignments) => [...prevAssignments, data]);
      toast.success("Assignment created successfully!");
      setTitle("");
      setDescription("");
      setDueDate("");
      setFile(null);
    } catch (err) {
      toast.error(err.message || "An error occurred while creating the assignment.");
      setError(err.message || "An error occurred while creating the assignment.");
    }
  };

  // Handle assignment submission
  const handleAssignmentSubmit = async (e) => {
    e.preventDefault();

    if (!submissionFile) {
      toast.error("Please choose a file to submit.");
      return;
    }

    if (!selectedAssignmentId) {
      toast.error("Please select an assignment to submit.");
      return;
    }

    const formData = new FormData();
    formData.append("file", submissionFile);
    formData.append("studentId", studentId); // Send studentId
    formData.append("assignmentId", selectedAssignmentId);

    try {
      const response = await fetch("http://localhost:5000/api/assignments/submit", {
        method: "POST",
        body: formData,
      });

      if (!response.ok) {
        throw new Error("Failed to submit the assignment.");
      }

      const data = await response.json();
      toast.success("Assignment submitted successfully!");
      setSubmissionFile(null);
    } catch (err) {
      toast.error(err.message || "An error occurred while submitting the assignment.");
      setError(err.message || "An error occurred while submitting the assignment.");
    }
  };

  return (
    <div className="p-8 bg-[#1a1a1a] text-blue-500 min-h-screen">
      <h1 className="text-5xl font-bold mb-8 text-center">Assignments Portal</h1>

      {error && <div className="bg-red-600 text-white p-4 rounded-lg mb-4">{error}</div>}

      <button
        onClick={() => setShowCreateForm(!showCreateForm)}
        className="w-full bg-blue-500 text-white p-3 rounded-lg mt-4"
      >
        {showCreateForm ? "Cancel" : "Create Assignment"}
      </button>

      {showCreateForm && (
        <form
          onSubmit={handleSubmit}
          className="bg-gray-800 p-6 rounded-lg shadow-lg max-w-2xl mx-auto mt-6"
        >
          <div>
            <label className="block text-lg font-medium mb-2">Title</label>
            <input
              type="text"
              value={title}
              onChange={(e) => setTitle(e.target.value)}
              className="w-full p-3 rounded-lg border border-gray-600 bg-gray-700 text-white focus:outline-none focus:ring-2 focus:ring-blue-500"
              placeholder="Assignment Title"
            />
          </div>

          <div>
            <label className="block text-lg font-medium mb-2">Description</label>
            <textarea
              value={description}
              onChange={(e) => setDescription(e.target.value)}
              className="w-full p-3 rounded-lg border border-gray-600 bg-gray-700 text-white focus:outline-none focus:ring-2 focus:ring-blue-500"
              placeholder="Assignment Description"
              rows="4"
            />
          </div>

          <div>
            <label className="block text-lg font-medium mb-2">Due Date</label>
            <input
              type="datetime-local"
              value={dueDate}
              onChange={(e) => setDueDate(e.target.value)}
              className="w-full p-3 rounded-lg border border-gray-600 bg-gray-700 text-white focus:outline-none focus:ring-2 focus:ring-blue-500"
            />
          </div>

          <div>
            <label className="block text-lg font-medium mb-2">Upload File</label>
            <input
              type="file"
              onChange={handleFileChange}
              className="w-full p-3 rounded-lg border border-gray-600 bg-gray-700 text-white focus:outline-none focus:ring-2 focus:ring-blue-500"
            />
          </div>

          <button
            type="submit"
            className="w-full bg-green-500 text-white p-3 rounded-lg mt-4"
          >
            Create Assignment
          </button>
        </form>
      )}

      <h2 className="text-3xl font-bold mt-12">Existing Assignments</h2>
      <div
        className="mt-6 space-y-6 overflow-y-auto max-h-[60vh]" // Adding scroll functionality here
        style={{ maxHeight: '60vh' }} // Restricting the height of the assignments list to 60% of the viewport
      >
        {assignments.map((assignment) => (
          <div
            key={assignment._id}
            className={`p-6 rounded-lg shadow-lg bg-gray-800 transition-transform duration-200 ${
              selectedAssignmentId === assignment._id
                ? "scale-105 border-2 border-blue-500"
                : "scale-100 border border-gray-700"
            }`}
          >
            <h3 className="text-2xl font-semibold">{assignment.title}</h3>
            <p className="mt-2">{assignment.description}</p>
            <p className="mt-2">Due Date: {new Date(assignment.dueDate).toLocaleString()}</p>
            <a
              href={`http://localhost:5000/${assignment.file}`}
              target="_blank"
              rel="noopener noreferrer"
              className="text-blue-500 mt-4 inline-block"
            >
              Download File
            </a>

            <div className="mt-6">
              <label className="block text-lg font-medium">Submit Assignment</label>
              <input
                type="file"
                onChange={handleSubmissionFileChange}
                className="w-full p-3 mt-2 rounded-lg border border-gray-600 bg-gray-700 focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
              <button
                onClick={() => setSelectedAssignmentId(assignment._id)}
                className="w-full bg-blue-500 text-white p-3 rounded-lg mt-4"
              >
                Select Assignment
              </button>
              <button
                onClick={handleAssignmentSubmit}
                className="w-full bg-green-500 text-white p-3 rounded-lg mt-4"
              >
                Submit Assignment
              </button>
            </div>
          </div>
        ))}
      </div>

      {submissionSuccessMessage && (
        <div className="bg-green-600 text-white p-4 mt-6 rounded-lg">{submissionSuccessMessage}</div>
      )}
    </div>
  );
}

export default AssignmentsPage;