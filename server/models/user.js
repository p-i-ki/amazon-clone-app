const mongoose = require('mongoose');

//this is the structure or schema of our user model when they signup
//mongoose.Schema: Defines the structure of the documents within a collection, essentially a blueprint for the data.
const userSchema = mongoose.Schema(
    {
        name : {
            required : true,
            type : String,
            trim : true, // it will trim spaces at starting and ending like ' piki ' -> 'piki'
        },
        email: {
            required: true,
            type: String,
            trim: true,
            validate: {
              validator: (value) => {
                const re =
                  /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
              },
              message: "Please enter a valid email address",
            },
          },
        password : {
            required : true,
            type : String,
            //you can add here validator for length of the password to be 8 any many more..
            // validator:
            // {
            //     validator : (value) => {
            //         return value.length > 8;
            //     },
            //     message : 'Please enter a password of length 8 or more',
            // },
        },
        address : {
            type : String,
            default : '',//it is not required at the time of signup
        },
        type : {
            type : String,
            default : 'User', //we will add other types of user , but default every user is of type user when they signup
        }

    }
);

//creating a user model with the above Schema
//mongoose.model: Creates a model which allows for interacting with the documents in the collection defined by the schema.
const User = mongoose.model("User", userSchema);//1st arg is model name , 2nd one is schema

module.exports = User;


