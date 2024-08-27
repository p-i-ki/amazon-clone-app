import 'dart:convert';

import 'package:amazone_clone_by_rivaan/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      //the response body is in json format ,so we decode it when we require to treat it as String
      showSnackBar(context, jsonDecode(response.body)['msg']);
      // return res.status(400).json({msg : "User with the same email already exists!"}); in auth.js
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
      // res.status(500).json({error : e.message}); in auth.js
      break;
    default:
      showSnackBar(context, response.body);
  }
}
