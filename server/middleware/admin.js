const jwt = require("jsonwebtoken");
const User = require("../models/user");

const admin = async (req, res, next) => {
  try {
    const token = req.header("x-auth-token");
    if (!token)
      return res.status(401).json({ msg: "No auth token, access denied" });

    const verified = jwt.verify(token, "passwordKey");
    if (!verified)
      return res
        .status(401)
        .json({ msg: "Token verification failed, authorization denied." });
    
    const user = await User.findById(verified.id);//we are using User model to find a user by id
    if (user.type == "user" || user.type == "seller") {
      return res.status(401).json({ msg: "You are not an admin!" });
    }

    req.user = verified.id;//due to express.json() , req become an JS object and here we are creating a new property to req object with name 'user' and assigning id to it..and same for token..
    req.token = token;
    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

module.exports = admin;