import express from 'express';
import dotenv from 'dotenv';
import cors from "cors";
import mongoose from 'mongoose';
import {loginValidation, registerValidation} from './validations/auth.mjs';
import * as UserController from "./controllers/UserController.mjs";
import checkAuth from './utilies/checkAuth.mjs';


mongoose.connect('mongodb+srv://admin:admin123@cluster0.cwd0bau.mongodb.net/cardiowell?retryWrites=true&w=majority').then(() => console.log('db ok')).catch((err) => console.log('bb err', err));
const app = express();
const port = process.env.PORT || 5000;

dotenv.config();
app.use(cors());
app.use(express.json());

app.post('/auth/register', registerValidation, UserController.register)
app.post('/auth/login',loginValidation, UserController.login)
app.get('/auth/me',checkAuth, UserController.getMe);
app.get('/auth/me',UserController.getAll);


app.listen(port, () => {
  console.log(`App listening on port ${port}`);
});
