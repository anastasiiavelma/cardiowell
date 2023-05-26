import React from "react";
import Typography from "@mui/material/Typography";
import TextField from "@mui/material/TextField";
import Paper from "@mui/material/Paper";
import Button from "@mui/material/Button";
import { useDispatch, useSelector } from "react-redux";
import { fetchAuth, selectIsAuth } from "../../redux/slices/auth";
import { useForm } from 'react-hook-form'
import styles from "./Login.module.scss";
import {Navigate} from "react-router-dom";

export const Login = () => {

    const isAuth = useSelector(selectIsAuth);
    const dispatch = useDispatch();
    const { register, handleSubmit, formState: { errors, isValid } } = useForm({
        defaultValues: {
            email: '',
            password: '',
        },
        mode: 'onChange'
    });

    const onSubmit = async (values) => {
        const data = await dispatch(fetchAuth(values));

        if (!data.payload) {
            return alert('Login failed')
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
            <img style={{ width: 180, height: 140, marginLeft: '110px' }} src="doctor1.png" />
            <Typography classes={{ root: styles.title }} variant="h6">
                Nice to meet you again!
                 Please, <span style={{ color: '#ff6700' }}>login</span>

            </Typography>
            <form onSubmit={handleSubmit(onSubmit)}>
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
                Войти
            </Button>
        </form>
        </Paper>
    );
};