import NoteModel from '../models/Note.mjs';
import mongoose from "mongoose";

export const getAll = async (req, res) => {
    try {
        const notes = await NoteModel.find().populate('user');

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

        const doc = await NoteModel.findOneAndDelete({ _id: noteId }).populate('user');

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
        const doc = await new NoteModel({
            title: req.body.title,
            pulse: req.body.pulse,
            bloodPressure: req.body.bloodPressure,
            oxygenLevel: req.body.oxygenLevel,
            textInfo: req.body.textInfo,
            photoUrl: req.body.photoUrl,
            user: req.userId,

        }).populate('user');

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
export const getUserNotes = async (req, res) => {
    try {
        const userId = req.params.id; // Convert the user ID to an ObjectId
        const notes = await NoteModel.find({ user: userId });
        res.status(200).json(notes);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Failed to fetch user notes' });
    }
};

