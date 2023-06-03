import mongoose from 'mongoose'

const DeviceResultSchema = new mongoose.Schema({
    deviceId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Device',
    },
    value: Number,
    dateTime: String
});

export default mongoose.model('DeviceResult', DeviceResultSchema);