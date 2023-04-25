import mongoose from "mongoose";

const NoteSchema = new mongoose.Schema({
        title:{
                type: String,
                required: true,
            },
        pulse:{
            type: String,
        },
        bloodPressure:{
            type: String,
        },
        oxygenLevel:{
            type: String,
        },
        textInfo:{
            type: String,
        },
        user:{
            type: mongoose.Schema.Types.ObjectId,
            ref: 'User',
            required: true,
        },
    }, {
        timestamps: true,
    },
);

export default mongoose.model('Note', NoteSchema);