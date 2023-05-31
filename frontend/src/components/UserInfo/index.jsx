import React from 'react';
import styles from './UserInfo.module.scss';

export const UserInfo = ({email, additionalText}) => {
    const formattedDate = additionalText ? new Date(additionalText).toLocaleDateString('en-GB') : '';

    return (
        <div className={styles.root}>
            <img className={styles.avatar} src={'/avatar.png'} alt={email} />
            <div className={styles.userDetails}>
                <span className={styles.email}>{email}</span>
                <span className={styles.additional}>{formattedDate}</span>
            </div>
        </div>
    );
};
