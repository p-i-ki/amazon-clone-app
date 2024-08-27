const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const auth = require('../middleware/auth');

authRouter = express.Router();

authRouter.post('/api/signup', async (req,res)=>{

   //always use async/wait with try-catch
   try{
        //Get the signup data from the client
   const {name,email,password} = req.body;    //here body is in map format where these three are the keys so we are destructuring the map.

   //now we have to create data model(we will use mongoose for this) to handle features like -> weak password, atleast 8 character, account with same email and them store them in the database accordingly as user document
   //now if we have any task related to User signup , we can do it with the help of 'User' model we have created like save a user in the DB, access a user in the DB etc..
   const existingUser = await User.findOne({email});   //we are checking is there any user with the same email in the database
   if(existingUser)
    {
        //by default res retuns a status code of 200
        return res.status(400).json({msg : "User with the same email already exists!"});
    }

    //here we will do hashing the password so that if some third person access the data he will not understand passwords.
    const hashPassword = await bcryptjs.hash(password,8); //salt is added so that the generated is not predictable and also same passwords will have different hash values/string
     
    //now if the user's email is not match then we can allow him to sign up and store his info in the database.
    //first create a instance of the User model and pass the values extracted out from the http request body..
    let user = new User(
        {
          name,
          email,
          password : hashPassword, //here you just need to pass the required fields only , the others fileds will take defaults values
          //now mongoDB will automatically add two fields to this user model one is id -> unique identifier for the model or document other is _v -> version of the the document ,ie how many times the document got updated
        }
    );

    //and then save the user to the DB
    user = await user.save();

    //send the copy of the user info to the user(front end)
    return res.json(user); //{user:user}
   }
   catch(e)
   {
       return res.status(500).json({error : e.message});// if we only pass e then it will give -> "user validation failed" (which is given by mongoose.Schema() internally)
    //e.message will have access to messgae filed in the validator of email inside mongoose.Schema() -> "Please enter a valid email address"
   }
});

//signin route
authRouter.post('/api/signin', async (req, res) => {
  try {
    const { email, password } = req.body;

    let user = await User.findOne({ email });//findOne will find the first user with the provided email and returns the user document from DB
    if (!user) {
      return res.status(400).json({ msg: "User wiht same email already exists!" });
    }
   //if the user email exits then we have to match the password
    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Incorret password!" });
    }
  
    //jwt is used to verify the users
    const token = jwt.sign({id : user._id},"passwordKey");//we are including user id in the token as payload
    //we are sending the token back to the client side so that it can be stored in the app memory and user object is accessible through out the app
   return res.json({token, ...user._doc});//... will add token to user object as a key-value pair and sending it to the client,and _doc will give us only the required part of the document.

  } catch (e) {
    return res.status(500).json({ error: e.message });
  }

}
)

//get token and then verify it

authRouter.post('/tokenIsValid', async (req,res)=>{
try {
  const token = req.header("x-auth-token");
  //is the token null
  if (!token) {
   return res.status(400).json(false);
  }
  const verifiedUser = jwt.verify(token, "passwordKey"); //verify() will return the user documnet if the token matches
  //is the user verified one
  if (!verifiedUser) {
    return res.status(400).json(false);
  }
  //now we will check one step furthur by verfiying the user id(because the user may enter the token by hit and trial)
  const user = await User.findById(verifiedUser.id);
  //is the id exists
  if (!user) return res.json(false);
  //if all the conditions satisfied
  return res.json(true);
} catch (e) {
 return res.status(500).json({ error: e.message });
}
})


authRouter.get('/',auth,async (req,res)=>{
  const user = await User.findById(req.user);//here req.user containst user id (refer to /middleware/auth.js)
  return res.json({ ...user._doc, token: req.token });
});



module.exports = authRouter; //for improting multiple things you have to use object {authRouter:authRouter,name:piki,age:33} etc
//in js when you import the same key and value , you don't need to specify key .ex- here authRouter.
