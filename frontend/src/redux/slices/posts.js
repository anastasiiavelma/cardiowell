import { createSlice, createAsyncThunk } from "@reduxjs/toolkit";
import axios from "../../axios";

export const fetchPosts = createAsyncThunk('posts/fetchPosts', async () => {
    const { data } = await axios.get('/posts')
    return data;
});

export const fetchRemovePost = createAsyncThunk('posts/fetchRemovePost', async (id) => axios.delete(`/posts/${id}`)
);

export const fetchPostsByDay = createAsyncThunk('posts/fetchPostsByDay', async (createdAt) => {
    console.log('Fetching posts by day...');
    try {
        const { data } = await axios.get(`/all-post`);
        console.log('Posts fetched by day:', data);

        // Filter the data array based on the createdAt date
        const post = data.find((post) => post._id === createdAt);

        if (post) {
            console.log('Post count:', post.count);
            return post.count;
        } else {
            console.log('Post not found for the given date.');
            return 0; // or handle the case where the post is not found
        }
    } catch (error) {
        console.error('Error fetching posts by day:', error);
        throw error;
    }
});



const initialState = {
    posts: {
        items: [],
        status: 'loading',
    },
}

const postsSlice = createSlice({
    name: 'posts',
    initialState,
     reducer: {},
    extraReducers: {
        [fetchPosts.pending]: (state) => {
            state.posts.status = 'loading';
        },
        [fetchPosts.fulfilled]: (state, action) => {
            state.posts.items = action.payload;
            state.posts.status = 'loaded';
        },
        [fetchPosts.rejected]: (state) => {
            state.posts.items = [];
            state.posts.status = 'error';
        },
        [fetchRemovePost.pending]: (state, action) => {
            state.posts.items = state.posts.items.filter((obj) => obj._id !== action.meta.arg)
        },

    },

})

export const postReducer = postsSlice.reducer;