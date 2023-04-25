import NoteModel from '../models/Note.mjs';

export const getAll = async (req, res) => {
    try {
        const notes = await NoteModel.find().populate('user').exec();

        res.json(notes);
    } catch (err) {
        console.log(err);
        res.status(500).json({
            message: 'Failed get note',
        });
    }
}
export const getOne = async (req, res) => {
    try {
        const noteId = req.params.id;

        const doc = await NoteModel.findOne({ _id: noteId }).populate('user');

        if (!doc) {
            return res.status(404).json({
                message: 'Note not found',
            });
        }

        res.json(doc);
    } catch (err) {
        console.log(err);
        res.status(500).json({
            message: 'Failed to get note',
        });
    }
}
export const remove = async (req, res) => {
    try {
        const noteId = req.params.id;

        const doc = await NoteModel.findOneAndDelete({ _id: noteId });

        if (!doc) {
            return res.status(404).json({
                message: 'Note not found',
            });
        }

        res.json({
            success: true,
        });
    } catch (err) {
        console.log(err);
        res.status(500).json({
            message: 'Failed to delete note',
        });
    }
}
export const create = async (req, res) => {
    try {
        const doc = new NoteModel({
            title: req.body.title,
            pulse: req.body.pulse,
            bloodPressure: req.body.bloodPressure,
            oxygenLevel: req.body.oxygenLevel,
            textInfo: req.body.textInfo,
            photoUrl: req.body.photoUrl,
            user: req.userId,

        });

        const note = await doc.save();

        res.json(note);
    } catch (err) {
        console.log(err);
        res.status(500).json({
            message: 'Failed create note',
        });
    }

}
export const update = async (req, res) => {
    try {
        const noteId = req.params.id;
        await NoteModel.updateOne({
                _id: noteId,
            }, {
                title: req.body.title,
                pulse: req.body.pulse,
                bloodPressure: req.body.bloodPressure,
                oxygenLevel: req.body.oxygenLevel,
                textInfo: req.body.textInfo,
                photoUrl: req.body.photoUrl,
                user: req.userId,
            },
        );

        res.json({
            success: true,
        });
    } catch (err) {
        console.log(err);
        res.status(500).json({
            message: 'Failed update notes',
        });
    }
}