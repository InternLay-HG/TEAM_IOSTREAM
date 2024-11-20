// components/AssignmentPage.js
import React, { useState, useEffect } from 'react';
import axios from 'axios';

const AssignmentPage = () => {
    const [assignments, setAssignments] = useState([]);
    const [title, setTitle] = useState('');
    const [description, setDescription] = useState('');
    const [dueDate, setDueDate] = useState('');
    const [file, setFile] = useState(null);

    useEffect(() => {
        const fetchAssignments = async () => {
            try {
                const response = await axios.get('http://localhost:5000/api/assignments');
                setAssignments(response.data);
            } catch (error) {
                console.error('Error fetching assignments:', error);
            }
        };
        fetchAssignments();
    }, []);

    const handleFileChange = (e) => {
        setFile(e.target.files[0]);
    };

    const handleSubmitAssignment = async (e) => {
        e.preventDefault();
        const formData = new FormData();
        formData.append('title', title);
        formData.append('description', description);
        formData.append('dueDate', dueDate);
        formData.append('file', file);
        formData.append('professorId', 'YOUR_PROFESSOR_ID'); // Replace with actual ID

        try {
            await axios.post('http://localhost:5000/api/assignments', formData);
            // Reset form
            setTitle('');
            setDescription('');
            setDueDate('');
            setFile(null);
            // Fetch assignments again to update the list
            const response = await axios.get('http://localhost:5000/api/assignments');
            setAssignments(response.data);
        } catch (error) {
            console.error('Error submitting assignment:', error);
        }
    };

    return (
        <div>
            <h1>Assignments</h1>
            <form onSubmit={handleSubmitAssignment}>
                <input 
                    type="text" 
                    value={title} 
                    onChange={(e) => setTitle(e.target.value)} 
                    placeholder="Title" 
                    required 
                />
                <textarea 
                    value={description} 
                    onChange={(e) => setDescription(e.target.value)} 
                    placeholder="Description" 
                    required 
                />
                <input 
                    type="date" 
                    value={dueDate} 
                    onChange={(e) => setDueDate(e.target.value)} 
                    required 
                />
                <input 
                    type="file" 
                    onChange={handleFileChange} 
                    required 
                />
                <button type="submit">Create Assignment</button>
            </form>
            <h2>Existing Assignments</h2>
            <ul>
                {assignments.map(assignment => (
                    <li key={assignment._id}>
                        <h3>{assignment.title}</h3>
                        <p>{assignment.description}</p>
                        <p>Due Date: {new Date(assignment.dueDate).toLocaleDateString()}</p>
                        <a href={assignment.file} target="_blank" rel="noopener noreferrer">Download File</a>
                    </li>
                ))}
            </ul>
        </div>
    );
};

export default AssignmentPage;