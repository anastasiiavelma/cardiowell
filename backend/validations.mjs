import {body} from 'express-validator';

export const registerValidation = [
    body('email', "Wrong format email").isEmail(),
    body('password', "Password must contain 8 characters").isLength({min: 8}),
    body('fullName', "Name must contain 2 characters").isLength({min: 2}),
    body('avatarUrl', 'Wrong link on avatar').optional().isURL(),
];

export const loginValidation = [
    body('email', "Wrong format email").isEmail(),
    body('password', "Password must contain 5 characters").isLength({min: 5}),
];

export const postsCreateValidation = [
    body('title', "Enter title of post (min 3 characters)").isLength({min: 3}).isString(),
    body('text', "Enter text in post (min 10 characters)").isLength({min: 10}).isString(),
    body('imageUrl', "Wrong photo link").optional().isString(),
];

export const MedicalCardCreateValidation = [
    body('birth', "Enter correct date").isDate().isString(),
    body('age', "Enter correct age (min 1 characters)").isLength({min: 1}).isString(),
    body('bloodType', "Enter correct blood type (A,B,AB etc)").isLength({min: 1}).isString(),
    body('phoneNumber', "Enter correct number (min 8 characters)").isLength({min: 8}).isString(),
    body('address', "Enter correct address").isLength({min: 5}).isString(),
    body('weight', "Enter correct weight").isDecimal().isString(),
];

export const notesCreateValidation = [
    body('title', "Enter title of note (min 3 characters)").isLength({min: 3}).isString(),
    body('text', "Enter text in note (min 10 characters)").isLength({min: 10}).isString(),

];
