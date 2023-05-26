import React from 'react';
import Grid from '@mui/material/Grid';
import {useDispatch, useSelector} from 'react-redux';
import { Post } from '../components';
import {fetchPosts} from "../redux/slices/posts";


export const Home = () => {
    const dispatch = useDispatch();
    const {posts} = useSelector(state => state.posts)

    const isPostLoading = posts.status === 'Loading';

    React.useEffect(() => {
        dispatch(fetchPosts());
    }, [])
    return (
        <>
            <Grid container spacing={4}>

                <Grid xs={8} item>
                    {(isPostLoading ? [...Array(5)] : posts.items).map((obj) => isPostLoading ? <Post key={obj._id} isLoading={true} /> : (
                        <Post
                            key={obj._id}
                            _id={obj._id}
                            title={obj.title}
                            imageUrl={obj.imageUrl? `http://localhost:5000${obj.imageUrl}` : ''}
                            user={obj.user}
                            createdAt={obj.createdAt}
                            isEditable

                        />
                    ))}
                </Grid>
                <Grid item xs={4} container justifyContent="space-between">
                    <img src='doctor3.png' alt='Works' style={{ float: 'right', marginLeft: '150px', marginTop: '50px', width: "400px", height: "350px"  }} />

                </Grid>
            </Grid>

        </>
    );
};