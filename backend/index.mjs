import express from 'express';
import dotenv from 'dotenv';
import cors from "cors";
import mongoose from 'mongoose';
import {
  loginValidation,
  registerValidation,
  postsCreateValidation,
  MedicalCardCreateValidation, notesCreateValidation
} from './validations.mjs';
import * as UserController from "./controllers/UserController.mjs";
import * as PostController from "./controllers/PostController.mjs";
import checkAuth from './utilies/checkAuth.mjs';
import multer from 'multer';
import * as QuizController from "./controllers/QuizController.mjs";
import * as NoteController from "./controllers/NoteController.mjs";
import * as MedicalCardController from "./controllers/MedicalCardController.mjs";

mongoose.connect('mongodb+srv://admin:admin123@cluster0.cwd0bau.mongodb.net/cardiowell?retryWrites=true&w=majority').then(() => console.log('db ok')).catch((err) => console.log('bb err', err));
const app = express();
const port = process.env.PORT || 5000;

dotenv.config();
app.use(cors());
app.use(express.json());
app.use('/uploads', express.static('uploads'));

const storage = multer.diskStorage({
  destination: (_,__, cb) => {
    cb(null, 'uploads');
  },
  filename: (_,file, cb) => {
    cb(null, file.originalname);
  },
});

const upload = multer({storage});

app.post('/uploads', checkAuth, upload.single('image'), (req, res) => {
  res.json({
    url: '/uploads/${req.file.originalname}',
  });
})
app.post('/auth/register', registerValidation, UserController.register);
app.post('/auth/login',loginValidation, UserController.login);
app.get('/auth/me',checkAuth, UserController.getMe);
app.get('/auth/me',UserController.getAll);

app.get('/posts', PostController.getAll);
app.get('/posts/:id', PostController.getOne);
app.delete('/posts/:id', checkAuth, PostController.remove);
app.patch('/posts/:id', checkAuth, PostController.update);
app.post('/posts', checkAuth, postsCreateValidation, PostController.create);

app.get('/quizzes', QuizController.getAll);
app.get('/quizzes/:id', checkAuth, QuizController.getOne);
app.post('/quizzes', checkAuth, QuizController.create);
app.delete('/quizzes/:id',checkAuth,QuizController.remove);
app.patch('/quizzes/:id',checkAuth, QuizController.update);

app.get('/med-cards', MedicalCardController.getAll);
app.get('/med-cards/:id', checkAuth, MedicalCardController.getOne);
app.post('/med-cards', checkAuth,MedicalCardCreateValidation, MedicalCardController.create);
app.delete('/med-cards/:id',checkAuth,MedicalCardController.remove);
app.patch('/med-cards/:id',checkAuth, MedicalCardController.update);

app.get('/notes', NoteController.getAll);
app.get('/notes/:id', checkAuth, NoteController.getOne);
app.post('/notes', checkAuth, notesCreateValidation, NoteController.create);
app.delete('/notes/:id',checkAuth,NoteController.remove);
app.patch('/notes/:id',checkAuth, NoteController.update);

app.listen(port, () => {
  console.log(`App listening on port ${port}`);
});
