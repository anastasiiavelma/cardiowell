import {configureStore} from '@reduxjs/toolkit';
import {postReducer} from "./slices/posts";
import {authReducer} from "./slices/auth";
import {userReducer} from "./slices/users";

export const store = configureStore({
    reducer:{
        users: userReducer,
        posts: postReducer,
        auth: authReducer
    },
});
