import mongoose from 'mongoose'

const QuestionType = {
    questionTest: String,
    answers: [{
        isRight: Boolean,
        text: String,
    }]
}

const QuizSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
    },
    description: String,
    questions: {
        type: [QuestionType],
        required: true,
    },
}, { timestamps: true })

export default mongoose.model('Quiz', QuizSchema)