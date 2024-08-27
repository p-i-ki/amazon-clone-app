const mongoose = require("mongoose");

productSchema = mongoose.Schema(
    {
      name : {
        type: String,
        required : true,
        trim:true,
      },
      description : {
        type: String,
        required: true,
        trim:true,
      },
      price:{
        type: Number,
        required: true,
      },
      category:{
        type:String,
        required:true,
      },
      images:[
        {
            type:String,
            required:true
        },
      ],
      quantity:{
        type:Number,
        required:true,
      }

    }
   
);

exports.Product = mongoose.model('Product',productSchema);
//OR
// const Product = mongoose.model('Product',productSchema);
// module.exports = { Product, productSchema};