const mongoose = require('mongoose');

// Define the Resource Sharing Schema
const resourceSchema = new mongoose.Schema({
    resourceType: {
        type: String,
        enum: ['document', 'image', 'link', 'other'], // Restrict to these types
        required: true
    },
    sharedBy: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true // The user who shared the resource
    },
    sharedWithGroup: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Group',
        required: true // The group the resource is shared with
    },
    resourceData: {
        type: mongoose.Schema.Types.Mixed, // Use Mixed for flexibility depending on resource type
        required: true,
        // Example content:
        // - 'link': URL
        // - 'image': file path, metadata like size, resolution
        // - 'document': file path, size, document metadata
    },
    createdAt: {
        type: Date,
        default: Date.now
    }
}, { timestamps: true });

// Index fields for better performance
resourceSchema.index({ sharedBy: 1 });
resourceSchema.index({ sharedWithGroup: 1 });
resourceSchema.index({ resourceType: 1 });

const Resource = mongoose.model('Resource', resourceSchema);

module.exports = Resource;
