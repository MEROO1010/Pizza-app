const express = require('express');

const router = express.Router();

// Mock data for pizzas
const pizzas = [
    { id: 1, name: 'Margherita', ingredients: ['tomato', 'mozzarella', 'basil'] },
    { id: 2, name: 'Pepperoni', ingredients: ['tomato', 'mozzarella', 'pepperoni'] },
    { id: 3, name: 'BBQ Chicken', ingredients: ['bbq sauce', 'chicken', 'onions', 'cheese'] }
];

// Get all pizzas
router.get('/pizzas', (req, res) => {
    res.json(pizzas);
});

// Get a single pizza by ID
router.get('/pizzas/:id', (req, res) => {
    const pizza = pizzas.find(p => p.id === parseInt(req.params.id));
    if (!pizza) return res.status(404).send('Pizza not found');
    res.json(pizza);
});

// Add a new pizza
router.post('/pizzas', (req, res) => {
    const newPizza = {
        id: pizzas.length + 1,
        name: req.body.name,
        ingredients: req.body.ingredients
    };
    pizzas.push(newPizza);
    res.status(201).json(newPizza);
});

// Update an existing pizza
router.put('/pizzas/:id', (req, res) => {
    const pizza = pizzas.find(p => p.id === parseInt(req.params.id));
    if (!pizza) return res.status(404).send('Pizza not found');

    pizza.name = req.body.name;
    pizza.ingredients = req.body.ingredients;
    res.json(pizza);
});

// Delete a pizza
router.delete('/pizzas/:id', (req, res) => {
    const pizzaIndex = pizzas.findIndex(p => p.id === parseInt(req.params.id));
    if (pizzaIndex === -1) return res.status(404).send('Pizza not found');

    pizzas.splice(pizzaIndex, 1);
    res.status(204).send();
});

module.exports = router;