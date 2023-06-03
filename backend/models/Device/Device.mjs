import mongoose from "mongoose";

const { ObjectId } = mongoose.Schema.Types;

const DeviceSchema = new mongoose.Schema({
    name: String,
    deviceId: String,
    userId: {
        type: ObjectId,
        ref: "User",
    },
});

export default mongoose.model("Device", DeviceSchema);
