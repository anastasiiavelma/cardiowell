import DeviceModel from '../../models/Device/Device.mjs'
import DeviceResult from '../../models/Device/DeviceResult.mjs'

export const deviceResultPost = async (req, res) => {
    try {
        const value = req.body.value;
        const deviceId = req.body.deviceId;
        const dateTime = req.body.dateTime;

        const device = await DeviceModel.findById(deviceId);
        if (!device) {
            return res.status(404).json({ error: 'Device not found' });
        }

        const result = new DeviceResult({ deviceId, value, dateTime });
        await result.save();

        res.status(201).json(result);
    } catch (error) {
        res.status(500).json({ error: 'Failed to save result' });
    }
};