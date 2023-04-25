import QuizModel from '../models/Quiz.mjs'

export const getAll = async (req, res) => {
    try {
        const quizzes = await QuizModel.find()

        res.json(quizzes)

    } catch (err) {
        console.log(err)
        res.status(500).json({
            message: 'Quiz not found',
        })
    }
}

export const getOne = async (req, res) => {
    try {
        const quizId = req.params.id;
        const doc = await QuizModel.findOne({
            _id: quizId,
        });

        if (!doc) {
            return res.status(404).json({
                message: 'Quiz not found'
            })
        }

        res.json(doc);

    } catch (err) {
        console.log(err)
        res.status(500).json({
            message: 'Failed to retrieve quiz',
        })
    }
}

export const remove = async (req, res) => {
    try {
        const quizId = req.params.id;

        const doc = await QuizModel.findOneAndDelete({
            _id: quizId,
        });

        if (!doc) {
            return res.status(404).json({
                message: 'Quiz not found'
            })
        }

        res.json({
            success: true,
        })

    } catch (err) {
        console.log(err)
        res.status(500).json({
            message: 'Failed to delete quiz',
        })
    }
}

export const update = async (req, res) => {
    try {
        const quizId = req.params.id

        const quiz = await QuizModel.findOneAndUpdate({ _id: quizId }, req.body, { new: true })

        res.json({
            success: true,
        })
    } catch (err) {
        console.log(err)
        res.status(500).json({
            message: 'Update quiz is failed',
        })
    }
}

export const create = async (req, res) => {
    const fields = Object.fromEntries(Object.entries(req.body).filter(([_, value]) => !!value))
    try {
        const quizDoc = new QuizModel(fields);
        const quiz = await quizDoc.save();
        res.json(quiz);

    } catch (err) {
        console.log(err)
        res.status(500).json({
            message: 'Failed create quiz',
        })
    }
}