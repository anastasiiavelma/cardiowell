import mongoose from "mongoose";

const MedicalCardSchema = new mongoose.Schema({
        age: {
            type: String,
        },
        birth: {
            type: String,
        },
        phoneNumber: {
            type: String,
        },
        address: {
            type: String,
        },
        dateOfDiseaseOnset: {
            type: String,
        },
        performedOperations:{
            type: String,
        },
        performedProcedures:{
            type: String,
        },
        weight: {
            type: String,
        },
        medicalPreparations: [{
            nameOfMedicine: String,
            dosage: String,
            mode: String,
            durationOfAdmission:String,
            sideEffects:String,
        }],
        bloodType: {
            type: String,
        },
        diagnosis: {
            type: String,
        },
        diseaseSeverity: {
            type: String,
        },
        allergies: {
            type: String,
        },
        user: {
            type: mongoose.Schema.Types.ObjectId,
            ref: "User",
            required: true,
        },
    }, {
        timestamps: true,
    },
);

export default mongoose.model('MedicalCard', MedicalCardSchema);