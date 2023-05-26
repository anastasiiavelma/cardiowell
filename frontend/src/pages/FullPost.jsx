
import React from "react";
import { useParams } from 'react-router-dom';
import ReactMarkdown from "react-markdown";
import { Post } from "../components";
import axios from "../axios";

export const FullPost = () => {
    const [data, setData] = React.useState();
    const [isLoading, setLoading] = React.useState(true);
    const { id } = useParams();

    React.useEffect(() => {
        axios.get(`/posts/${id}`)
            .then(res => {
                setData(res.data);
                setLoading(false);
            })
            .catch(err => {
                console.warn(err);
                alert(`${'Error when receiving the post'}`)

            });
    }, []);

    if (isLoading) {
        return <Post isLoading={isLoading} isFullPost />;
    }

    return (
        <>
            <Post
                _id={data._id}
                title={data.title}
                imageUrl={data.imageUrl? `http://localhost:5000${data.imageUrl}` : ''}
                user= {data.user}
                createdAt={data.createdAt}
                isFullPost
            >
                <p>
                    <ReactMarkdown children={data.textInfo} />
                </p>
            </Post>

        </>
    );
};