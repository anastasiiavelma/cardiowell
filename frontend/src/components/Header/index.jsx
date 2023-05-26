import React from 'react';
import Button from '@mui/material/Button';
import styles from './Header.module.scss';
import Container from '@mui/material/Container';
import { MenuItem, Select} from "@mui/material";
import {Link} from 'react-router-dom';
import {useDispatch, useSelector} from "react-redux";
import {logout, selectIsAuth} from "../../redux/slices/auth";

export const Header = () => {

    const dispatch = useDispatch();
    const isAuth = useSelector(selectIsAuth);


    const onClickLogout = () => {
        if (window.confirm('Are you sure you want to logout ?')){
            dispatch(logout());
            window.localStorage.removeItem('token')
        }
    };

    return (
        <div className={styles.root}>
            <Container maxWidth="lg">
                <div className={styles.inner}>
                    <Link className={styles.logo} to="/">
                        <div>Cardi<span style={{ color: '#ff6700' }}>o</span>well</div>
                    </Link>
                    <div className={styles.navbarItems} >
                        <Link to="/">
                            <Button variant="text" style={{ fontSize: '18px', marginLeft: '10px',  color: '#003366'  }}>Post</Button>
                        </Link>
                        <Link to="/item2">
                            <Button variant="text" style={{ fontSize: '18px', marginLeft: '10px',  color: '#003366' }}>Statistics</Button>
                        </Link>
                    </div>
                    <div className={styles.buttons}>
                        {isAuth ? (
                            <>
                                <Link to="/posts/create">
                                    <Button variant="contained" style={{ backgroundColor: '#003366' }}>Написать статью</Button>
                                </Link>
                                <Button onClick={onClickLogout} variant="contained" style={{ backgroundColor: '#ff6700' }}>
                                    Выйти
                                </Button>
                            </>
                        ) : (
                            <>
                                <Link to="/login">
                                    <Button variant="outlined" style={{ color: '#003366' }}>Войти</Button>
                                </Link>
                                <Link to="/register">
                                    <Button variant="contained"  style={{ backgroundColor: '#003366' }}>Создать аккаунт</Button>
                                </Link>
                            </>
                        )}
                    </div>
                    <Select
                       // value={i18n.language}
                       // onChange={handleChangeLanguage}
                        sx={{ minWidth: 35, height: 42,
                            paddingTop: '4px',
                            borderRadius: '15px', marginLeft: '20px', color: '#003366'}}
                    >
                        <MenuItem value='en'>EN</MenuItem>
                        <MenuItem value='ua'>UA</MenuItem>
                    </Select>
                </div>
            </Container>
        </div>
    );
};