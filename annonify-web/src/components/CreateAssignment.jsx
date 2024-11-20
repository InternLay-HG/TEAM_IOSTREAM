import React, { useState, useEffect } from 'react';

function AssignmentPage({ userId }) {
  const [assignments, setAssignments] = useState([]);
  const [newAssignment, setNewAssignment] = useState({
    title: "",
    description: "",
    dueDate: "",
    file: null, // File state to store the file object
  });

  const token = localStorage.getItem('token'); // Get the token from localStorage

  // Function to fetch assignments
  const getAssignments = async () => {
    try {
      const response = await fetch('http://localhost:5000/api/assignments', {
        headers: {
          'Authorization': `Bearer ${token}`,
        },
      });
      const data = await response.json();
      if (Array.isArray(data)) {
        setAssignments(data);
      } else {
        console.error('Received data is not an array:', data);
      }
    } catch (error) {
      console.error('Error fetching assignments:', error);
    }
  };

  useEffect(() => {
    if (token) {
      getAssignments();
    }
  }, [token]);

  // Handle the file input change
  const handleFileChange = (e) => {
    setNewAssignment({ ...newAssignment, file: e.target.files[0] });
  };

  const handleCreateAssignment = async () => {
    const { title, description, dueDate, file } = newAssignment;
    const formData = new FormData();

    formData.append('title', title);
    formData.append('description', description);
    formData.append('dueDate', dueDate);
    formData.append('userId', userId);

    if (file) {
      formData.append('file', file);
    }

    try {
      const response = await fetch('/api/assignments', {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${token}`,
        },
        body: formData,
      });
      if (response.ok) {
        setNewAssignment({ title: "", description: "", dueDate: "", file: null });
        await getAssignments(); // Reload the assignments list
      } else {
        console.error('Error creating assignment:', await response.text());
      }
    } catch (error) {
      console.error('Error creating assignment:', error);
    }
  };

  return (
    <div>
      <h1>Assignments</h1>
      <div>
        <h2>Create New Assignment</h2>
        <input
          type="text"
          placeholder="Title"
          value={newAssignment.title}
          onChange={(e) => setNewAssignment({ ...newAssignment, title: e.target.value })}
        />
        <textarea
          placeholder="Description"
          value={newAssignment.description}
          onChange={(e) => setNewAssignment({ ...newAssignment, description: e.target.value })}
        />
        <input
          type="date"
          value={newAssignment.dueDate}
          onChange={(e) => setNewAssignment({ ...newAssignment, dueDate: e.target.value })}
        />
        <input
          type="file"
          onChange={handleFileChange}
        />
        <button onClick={handleCreateAssignment}>Create Assignment</button>
      </div>

      <h2>Assignments List</h2>
      <ul>
        {assignments.length === 0 ? (
          <p>No assignments available</p>
        ) : (
          assignments.map((assignment) => (
            <li key={assignment._id}>
              <h3>{assignment.title}</h3>
              <p>{assignment.description}</p>
              <p>Due: {new Date(assignment.dueDate).toLocaleDateString()}</p>
              {assignment.file && (
                <a href={assignment.file} target="_blank" rel="noopener noreferrer">
                  Download File
                </a>
              )}
            </li>
          ))
        )}
      </ul>
    </div>
  );
}

export default AssignmentPage;
