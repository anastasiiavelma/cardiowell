import MedicalCardModel from '../models/MedicalCard.mjs';

export const getAll = async (req, res) => {
    try {
        const medCard = await MedicalCardModel.find()

        res.json(medCard)

    } catch (err) {
        console.log(err)
        res.status(500).json({
            message: 'Medical card not found',
        })
    }
}

export const getOne = async (req, res) => {
    try {
        const medCardId = req.params.id;
        const doc = await MedicalCardModel.findOne({
            _id: medCardId,
        });

        if (!doc) {
            return res.status(404).json({
                message: 'Medical card not found'
            })
        }

        res.json(doc);

    } catch (err) {
        console.log(err)
        res.status(500).json({
            message: 'Failed to retrieve medical card',
        })
    }
}

export const remove = async (req, res) => {
    try {
        const medCardId = req.params.id;

        const doc = await MedicalCardModel.findOneAndDelete({
            _id: medCardId,
        });

        if (!doc) {
            return res.status(404).json({
                message: 'Medical card not found'
            })
        }

        res.json({
            success: true,
        })

    } catch (err) {
        console.log(err)
        res.status(500).json({
            message: 'Failed to delete quiz',
        })
    }
}

export const update = async (req, res) => {
    try {
        const medCardId = req.params.id;

        const medCard = await MedicalCardModel.findOneAndUpdate({ _id: medCardId }, req.body, { new: true })

        res.json({
            success: true,
        })
    } catch (err) {
        console.log(err)
        res.status(500).json({
            message: 'Update medical card is failed',
        })
    }
}


export const create = async (req, res) => {
    const { body } = req;
    const userId = req.userId;

    try {
        const medicalCard = new MedicalCardModel({
            age: body.age,
            birth: body.birth,
            phoneNumber: body.phoneNumber,
            address: body.address,
            weight: body.weight,
            dateOfDiseaseOnset: body.dateOfDiseaseOnset,
            performedOperations: body.performedOperations,
            performedProcedures: body.performedProcedures,
            medicalPreparations: body.medicalPreparations,
            bloodType: body.bloodType,
            diagnosis: body.diagnosis,
            diseaseSeverity: body.diseaseSeverity,
            allergies: body.allergies,
            user: userId,
        });
        const savedMedicalCard = await medicalCard.save();

        res.status(201).json(savedMedicalCard);
    } catch (error) {
        console.error(error);
        res.status(500).json({
            message: 'Failed to create medical card',
            error,
        });
    }
};



