import React from 'react'

import Stat from "../../components/Stat";
import { Typography } from "@mui/material";
import { useTranslation } from "react-i18next";

const StatPage = () => {

    const { t } = useTranslation();
    return (
        <>

            <Typography variant="h3" sx={{paddingBottom: '50px', marginLeft: '470px', fontWeight: '600', color: '#ff6700'}}>{t('Statistics')}</Typography>
            <div>
                <Stat />
            </div>
        </>
    )
}

export default StatPage