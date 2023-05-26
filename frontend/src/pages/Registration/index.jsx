import React from 'react';
import Typography from '@mui/material/Typography';
import TextField from '@mui/material/TextField';
import Paper from '@mui/material/Paper';
import Button from '@mui/material/Button';
import styles from './Registration.module.scss';
import {useDispatch, useSelector} from "react-redux";
import {useForm} from "react-hook-form";
import { fetchRegister, selectIsAuth} from "../../redux/slices/auth";
import {Navigate} from "react-router-dom";

export const Registration = () => {

    const isAuth = useSelector(selectIsAuth);
    const dispatch = useDispatch();
    const { register, handleSubmit, formState: { errors, isValid } } = useForm({
        defaultValues: {
            fullName: '',
            email: '',
            password: '',
        },
        mode: 'onChange'
    });

    const onSubmit = async (values) => {
        const data = await dispatch(fetchRegister(values));

        if (!data.payload) {
            return alert('Register failed')
        }

        if ('token' in data.payload) {
            window.localStorage.setItem('token', data.payload.token);
        }
    };

    if (isAuth) {
        return <Navigate to="/" />;
    }


    return (
        <Paper classes={{ root: styles.root }}>

            <div className={styles.avatar}>
                <img style={{ width: 150, height: 150 }} src="avatar.png" />
            </div>
            <Typography classes={{ root: styles.title }} variant="h6">
                Create your account
            </Typography>
            <form onSubmit={handleSubmit(onSubmit)}>
            <TextField
                className={styles.field}
                label="Full name"
                error={Boolean(errors.fullName?.message)}
                helperText={errors.fullName?.message}
                {...register('fullName', { required: 'Enter the full name' })}
                fullWidth
            />
            <TextField
                className={styles.field}
                label="E-Mail"
                error={Boolean(errors.email?.message)}
                helperText={errors.email?.message}
                type="email"
                {...register('email', { required: 'Enter the e-mail' })}
                fullWidth
            />
            <TextField className={styles.field} label='Password'
                       error={Boolean(errors.password?.message)}
                       helperText={errors.password?.message}
                       type="password"
                       {...register('password', { required: 'Enter the password' })}
                       fullWidth />

            <Button disabled={!isValid} type="submit" size="large" variant="contained" fullWidth style={{ backgroundColor: '#ff6700', borderRadius: '20px' }}>
                Register
            </Button>
            </form>
        </Paper>
    );
};