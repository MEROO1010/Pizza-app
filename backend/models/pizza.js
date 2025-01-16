const mongoose = require('mongoose');

const pizzaSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim: true
    },
    description: {
        type: String,
        required: true,
        trim: true
    },
    price: {
        type: Number,
        required: true,
        min: 0
    },
    size: {
        type: String,
        enum: ['small', 'medium', 'large'],
        required: true
    },
    toppings: {
        type: [String],
        default: []
    }
}, {
    timestamps: true
});

const Pizza = mongoose.model('Pizza', pizzaSchema);

module.exports = Pizza;