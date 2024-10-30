const express = require("express");
const { MongoClient } = require("mongodb");
const bcrypt = require("bcrypt");
require("dotenv").config();

const app = express();
app.use(express.json());

// MongoDB Client setup
const port = process.env.PORT;
const uri = process.env.MONGODB_URI;
const client = new MongoClient(uri);
let db;

// Connect to MongoDB
client.connect()
  .then(() => {
    db = client.db("myDatabase"); // Replace with your database name
    console.log("Connected to MongoDB Atlas");
  })
  .catch(err => {
    console.error("Failed to connect to MongoDB:", err);
  });

// Endpoint to handle login
app.post("/login", async (req, res) => {
  const { email, password } = req.body;

  try {
    const user = await db.collection("users").findOne({ email });
    if (user) {
      const match = await bcrypt.compare(password, user.password);
      if (match) {
        res.status(200).json({ message: "Login successful" });
      } else {
        res.status(400).json({ message: "Invalid credentials" });
      }
    } else {
      res.status(400).json({ message: "User not found" });
    }
  } catch (error) {
    console.error("Error during login:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});

// Endpoint to handle account creation
app.post("/create-account", async (req, res) => {
  const { name, email, password} = req.body;
  console.log("create account");
  try {
    // Check if the user already exists
    const existingUser = await db.collection("users").findOne({ email });
    if (existingUser) {
      return res.status(400).json({ message: "Email already in use" });
    }

    // Hash the password before saving
    const hashedPassword = await bcrypt.hash(password, 10);
    await db.collection("users").insertOne({ email, password : hashedPassword, name });
    res.status(201).json({ message: "Account created" });
  } catch (error) {
    console.error("Error during account creation:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});

// Start the server
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
