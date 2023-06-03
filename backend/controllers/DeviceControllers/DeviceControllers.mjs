import DeviceModel from '../../models/Device/Device.mjs';

export const devicePost = async (req, res) => {
    try {
        const { name, deviceId, userId } = req.body;

        const device = new DeviceModel({ name, deviceId, userId });
        await device.save();

        res.status(201).json(device);
    } catch (error) {
        res.status(500).json({ error: 'Failed to add device' });
    }
};

// Видалення пристрою за його ідентифікатором
export const deviceDelete = async (req, res) => {
    try {
        const deviceId = req.params.id;

        const device = await DeviceModel.findById(deviceId);
        if (!device) {
            return res.status(404).json({ error: 'Device not found' });
        }

        await device.remove();

        res.json({ message: 'Device deleted' });
    } catch (error) {
        res.status(500).json({ error: 'Failed to delete device' });
    }
};