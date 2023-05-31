import {
    Box,
} from '@mui/material';
import React, {useEffect, useState} from 'react';
import {fetchPosts, fetchPostsByDay} from "../../redux/slices/posts";
import { useSelector } from "react-redux";
import { useDispatch } from 'react-redux';
import { useTranslation } from "react-i18next";
import {fetchUsers, fetchUserByDay } from "../../redux/slices/users";
import {StatCard} from "./StatCard";


const Stat = (_id) => {

    const {t} = useTranslation();
    const {i18n} = useTranslation();
    const {posts} = useSelector((state) => state.posts);
    const postsDailyCount = useSelector((state) => state.posts.dailyCount);
    const usersDailyCount = useSelector((state) => state.users.dailyCount);
    const [postCount, setPostCount] = useState(0);
    const [userCount, setUserCount] = useState(0);
    const {users} = useSelector(state => state.users);
    const dispatch = useDispatch();


    useEffect(() => {
        dispatch(fetchUsers());
        dispatch(fetchPosts());
        fetchPostsByCurrentDay();
        fetchUserByCurrentDay();
    }, [dispatch]);

    const fetchPostsByCurrentDay = async () => {
        const today = new Date().toISOString().split("T")[0];
        const result = await dispatch(fetchPostsByDay(today));
        const count = result.payload;
        setPostCount(count);
    };


    const fetchUserByCurrentDay = async () => {
        const today = new Date().toISOString().split("T")[0];
        const result = await dispatch(fetchUserByDay(today));
        const count = result.payload;
        setUserCount(count);
    };

    const chartDataUser = [
        {name: 'user', value: users.items.length},
    ];

    const chartDataPost = [
        {name: 'post', value: posts.items.length},
    ];

    const chartDataDailyPost = [
        {name: 'Posts added today', value: postCount},
    ];

    const chartDataDailyUser = [
        {name: 'Users added today', value: userCount},
    ];


    return (

        <Box sx={{display: 'flex', gap: 3, flexDirection: 'column',}}>
            <StatCard
                title={t('Total Users')}
                value={users.items.length}
                data={chartDataUser}
            />

            <StatCard
                title={t('Total Posts')}
                value={posts.items.length}
                data={chartDataPost}
            />

            <StatCard
                title={t('Posts by current day')}
                value={postCount}
                data={chartDataDailyPost}

            />
            <StatCard
                title={t('Users by current day')}
                value={userCount}
                data={chartDataDailyUser}

            />

        </Box>
    );
};

export default Stat;