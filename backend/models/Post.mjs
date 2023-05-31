import mongoose from "mongoose";

const PostSchema = new mongoose.Schema({
        title: {
            type: String,
        },
        textInfo: {
            type: String,
        },
        user: {
            type: mongoose.Schema.Types.ObjectId,
            ref: "User",
            required: true,
        },
        imageUrl: String,
    }, {
        timestamps: true,
    },
);

export default mongoose.model('Post', PostSchema);