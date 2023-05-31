import { createSlice, createAsyncThunk } from "@reduxjs/toolkit";
import axios from "../../axios";

export const fetchUsers = createAsyncThunk('user/fetchUsers', async () => {
    console.log('Fetching users...');
    try {
        const { data } = await axios.get('/users');
        console.log('Users fetched:', data);
        return data;
    } catch (error) {
        console.error('Error fetching users:', error);
        throw error;
    }
});

export const fetchUserByDay = createAsyncThunk('user/fetchUserByDay', async (createdAt) => {
    console.log('Fetching user by day...');
    try {
        const { data } = await axios.get(`/all-user`);
        console.log('Users fetched by day:', data);

        const user = data.find((user) => user._id === createdAt);

        if (user) {
            console.log('user count:', user.count);
            return user.count;
        } else {
            console.log('user not found for the given date.');
            return 0; // or handle the case where the post is not found
        }
    } catch (error) {
        console.error('Error fetching user by day:', error);
        throw error;
    }
});


const initialState = {
    users: {
        items: [],
        status: 'loading',
        dailyCount: 0,
    }
};

const userSlice = createSlice({
    name: 'users',
    initialState,
    reducer: {},
    extraReducers: {
        [fetchUsers.pending]: (state) => {
            state.users.status = 'loading';
        },
        [fetchUsers.fulfilled]: (state, action) => {
            state.users.items = action.payload;
            state.users.status = 'loaded';
        },
        [fetchUsers.rejected]: (state) => {
            state.users.items = [];
            state.users.status = 'error';
        },

    },

})

export const userReducer = userSlice.reducer;