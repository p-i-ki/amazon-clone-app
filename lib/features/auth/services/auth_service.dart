// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:amazone_clone_by_rivaan/features/home/screens/home_screen.dart';
import 'package:amazone_clone_by_rivaan/provider/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:amazone_clone_by_rivaan/constants/error_handling.dart';
import 'package:amazone_clone_by_rivaan/constants/golbal_variables.dart';
import 'package:amazone_clone_by_rivaan/constants/utils.dart';
import 'package:amazone_clone_by_rivaan/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//this class will do http req to the backend with singup data and accept the res from the backend
class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        address: '',
        type: '',
        token: '',
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //signIn function
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      //passing the data as http post request and then getting the response back.
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        // we can use user model to send singin data also ,but we will directly pass them(this method is error prone)
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8 ',
        },
      );
      //handling the response
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            //we first store the user token( which will be used by the user in future for making any request to the server as a legitimate user) in the app memory persistently
            SharedPreferences prefs = await SharedPreferences.getInstance();
            //we will also store user data and this data can be accessed by any widget using provider(we don't need to pass through constructor each time)
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
            Navigator.pushNamedAndRemoveUntil(
              context, //// ignore: use build_context_synchronously
              HomeScreen.routeName,
              (route) => false,
            );
          });
    } catch (e) {
      //catch block can only handle errors regerding connection , if any response(200 or 400) came from server it try block will consider it as no error
      showSnackBar(context, e.toString());
    }
  }

  //function for validating the user token
  // and if the token is verifie then it returns the user data
  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      //Verify the user's authentication token to ensure they are logged in and authorized to access app features.
      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);
      //If the token validation response is true, the function sends a GET request to fetch the user's data.
      // The token is included again in the request headers. If the request is successful,
      //the user data is then set in the UserProvider and then  update the app state.(ie allow the user directly access the home screen by skipping the signup/signin screen)
      //response is true means the user is logged in
      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
