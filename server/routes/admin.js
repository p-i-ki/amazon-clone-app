const mongoose = require("mongoose");
const jwt = require("jsonwebtoken");
const Product = require("../models/product");
const express = require("express");
const admin = require("../middleware/admin");

const adminRouter = express.Router();

// Add product
adminRouter.post("/admin/add-product", admin, async (req, res) => {
  try {
    const { name, description, images, quantity, price, category } = req.body;
    let product = new Product({
      name,
      description,
      images,
      quantity,
      price,
      category,
    });
    product = await product.save();
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Get all your products
adminRouter.get("/admin/get-products", admin, async (req, res) => {
  try {
    const products = await Product.find({});//we are not passing any condition to find() means it will match and return all the products saved in the DB by the admin..
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Delete the product
adminRouter.post("/admin/delete-product", admin, async (req, res) => {
  try {
    const { id } = req.body;
    let product = await Product.findByIdAndDelete(id);
    res.json(product);//returns the deleted product..
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = adminRouter;
