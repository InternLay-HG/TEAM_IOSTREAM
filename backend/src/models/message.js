const mongoose = require("mongoose");

const messageSchema = new mongoose.Schema({
    content: { type: String, required: true },
    user: { type: mongoose.Schema.Types.ObjectId, ref: "User", required: true },
    group: { type: mongoose.Schema.Types.ObjectId, ref: "Group", required: true },
    timestamp: { type: Date, default: Date.now },
    attachments: [{
        filename: { type: String, required: true },  // Name of the file
        filePath: { type: String, required: true },  // Path where the file is stored
        fileType: { type: String, required: true },  // Type of file (e.g., image, pdf, etc.)
    }]
});

module.exports = mongoose.model("Message", messageSchema);
