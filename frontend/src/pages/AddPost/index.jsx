import React from 'react';
import TextField from '@mui/material/TextField';
import Paper from '@mui/material/Paper';
import Button from '@mui/material/Button';
import SimpleMDE from 'react-simplemde-editor';
import { useTranslation } from 'react-i18next';
import 'easymde/dist/easymde.min.css';
import { useSelector } from 'react-redux';
import { selectIsAuth } from "../../redux/slices/auth";
import styles from './AddPost.module.scss';
import { useNavigate, Navigate, useParams } from 'react-router-dom';
import axios from '../../axios';

export const AddPost = () => {
    const { t } = useTranslation();
    const { i18n } = useTranslation();
    const { id } = useParams();
    const navigate = useNavigate();

    const isAuth = useSelector(selectIsAuth);
    const [isLoading, setLoading] = React.useState(false);
    const [textInfo, setTextInfo] = React.useState('');
    const [title, setTitle] = React.useState('');
    const [imageUrl, setImageUrl] = React.useState('');
    const inputFileRef = React.useRef(null);
    const isEditing = Boolean(id);

    if (!window.localStorage.getItem('token') && !isAuth) {
        return <Navigate to="/" />;
    }

    const handleChangeFile = async (event) => {
        try {
            const formData = new FormData();
            const file = event.target.files[0];
            formData.append('image', file);
            const { data } = await axios.post('/upload', formData);
            console.log(data);
            setImageUrl(data.url);
        } catch (err) {
            console.warn(err);
            alert(`${t('An error occured while downloading the file')}`);
        }
    };

    const onClickRemoveImage = () => {
        setImageUrl('');
    };

    const onChange = React.useCallback((value) => {
        setTextInfo(value);
    }, []);

    const onSubmit = async () => {
        try {
            setLoading(true);
            const fields = {
                title, imageUrl, textInfo,
            };
            const { data } = isEditing ? await axios.patch(`/posts/${id}`, fields) : await axios.post('/posts', fields);
            const _id = isEditing ? id : data._id;
            navigate(`/posts/${_id}`);
        } catch (err) {
            console.warn(err);
            alert(`${t('Error when creating post')}`);
        }
    };

    React.useEffect(() => {
        if (id) {
            axios.get(`/posts/${id}`).then(({ data }) => {
                setTitle(data.title);
                setTextInfo(data.textInfo);
                setImageUrl(data.imageUrl);
            }).catch(err => {
                console.warn(err);
                alert(`${t('Error when receiving post')}`);
            });
        }
    }, []);

    const options = React.useMemo(
        () => ({
            spellChecker: false,
            maxHeight: '400px',
            autofocus: true,
            placeholder: `${t('Enter text...')}`,
            status: false,
            autosave: {
                enabled: true,
                delay: 1000,
            },
        }),
        [],
    );

    if (!window.localStorage.getItem('token') && !isAuth) {
        return <Navigate to="/" />
    }

    return (
        <Paper style={{ padding: 30 }}>
            <Button onClick={() => inputFileRef.current.click()} variant="outlined" size="large">
                {t('Download preview')}
            </Button>
            <input ref={inputFileRef} type="file" onChange={handleChangeFile} hidden />
            {imageUrl && (
                <>
                <Button variant="contained" color="error" onClick={onClickRemoveImage}>
                    {t('Delete')}
                </Button>
                <img className={styles.image} src={`http://localhost:5000${imageUrl}`} alt="Uploaded" />
                </>
            )}

            <br />
            <br />
            <TextField
                classes={{ root: styles.title }}
                variant="standard"
                placeholder={t('Post title')}
                value={title}
                onChange={(e) => setTitle(e.target.value)}
                fullWidth
            />

            <SimpleMDE className={styles.editor} value={textInfo} onChange={onChange} options={options} />
            <div className={styles.buttons}>
                <Button onClick={onSubmit} size="large" variant="contained">
                    {isEditing ? `${t('Save')}` : `${t('Create')}`}
                </Button>
                <a href="/">
                    <Button size="large">{t('Cancel')}</Button>
                </a>
            </div>
        </Paper>
    );
};