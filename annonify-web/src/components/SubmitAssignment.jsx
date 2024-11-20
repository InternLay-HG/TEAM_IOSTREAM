import React, { useState } from 'react';

function SubmitAssignment({ assignmentId }) {
    const [file, setFile] = useState(null);

    const handleFileChange = (e) => {
        setFile(e.target.files[0]);
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        const formData = new FormData();
        formData.append('file', file);

        try {
            const response = await fetch(`/api/assignments/${assignmentId}/submit`, {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${localStorage.getItem('token')}`,
                },
                body: formData,
            });

            if (response.ok) {
                alert('Assignment submitted successfully!');
                setFile(null);
            } else {
                console.error('Error submitting assignment:', await response.text());
            }
        } catch (error) {
            console.error('Error submitting assignment:', error);
        }
    };

    return (
        <form onSubmit={handleSubmit}>
            <h2>Submit Assignment</h2>
            <input
                type="file"
                onChange={handleFileChange}
                required
            />
            <button type="submit">Submit Assignment</button>
        </form>
    );
}

export default SubmitAssignment;