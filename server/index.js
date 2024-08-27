//IMPORT FROM PACKAGES
const express = require("express");
const mongoose = require("mongoose");
const jwt = require("jsonwebtoken");

//IMPORTS FROM OTHER FILES
const authRouter = require('./routes/auth');
const adminRouter = require("./routes/admin");

//INITIALIZATION
const app = express();
const PORT = 4000;
const DB ='mongodb+srv://pikisaikia12:UGkRdBp5IxwOI4Vw@cluster0.7y64nsa.mongodb.net/ecommerceDataBase?retryWrites=true&w=majority';

//MIDDLEWARE
app.use(express.json()); // for parsing the body (like in signup)
app.use(authRouter); // we are using custom middleware for setting our routes or endpoints or API because defining the routes directly at application level is not good way
app.use(adminRouter);

//Mongoose connection options
const options = {
  useNewUrlParser: true,
  useUnifiedTopology: true,
  connectTimeoutMS: 40000, // 40 seconds
  socketTimeoutMS: 65000,  // 65 seconds
};

// Enable Mongoose debug mode
mongoose.set('debug', true);

//CONNECTIONS
mongoose.connect(DB, options)
  .then(() => { 
    console.log('Connection to the database is successful');
  })
  .catch((err) => {
    console.log(`Can't connect to the database: ${err}`);
  });

// Start the server
app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server is listening at port ${PORT}`);
});
