import 'package:amazone_clone_by_rivaan/common/widgets/custom_button.dart';
import 'package:amazone_clone_by_rivaan/common/widgets/custom_textfield.dart';
import 'package:amazone_clone_by_rivaan/constants/golbal_variables.dart';
import 'package:amazone_clone_by_rivaan/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  //_auth variable is used to keep track of the current authentication state
  Auth _auth = Auth.signup; //so that for new users signup appears as default.

  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  void signUpUser() {
    authService.signUpUser(
        //don't need to provide context here since we are in the State class
        context: context,
        name: _nameController.text, //you can also perform trim here.
        email: _emailController.text,
        password: _passwordController.text);
  }

  void signInUser() {
    authService.signInUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23),
              ),
              ListTile(
                tileColor: _auth == Auth.signup
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  'Create Account',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  activeColor: GlobalVariables
                      .secondaryColor, // Sets the active color of the radio button
                  value:
                      Auth.signup, // The value represented by this radio button
                  groupValue:
                      _auth, // The currently selected value for the group of radio buttons
                  onChanged: (Auth? val) {
                    // Callback when the radio button is selected
                    setState(() {
                      _auth = val!; // Update the state with the selected value
                    });
                  },
                ),
              ),
              //when using if-else , for loop etc inside the UI code don't need to use brackets{}.
              if (_auth == Auth.signup)
                Container(
                  padding: const EdgeInsets.all(12),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [
                        CustomTextfield(
                          controller: _nameController,
                          hintText: 'Name',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextfield(
                          controller: _emailController,
                          hintText: 'Email',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextfield(
                          controller: _passwordController,
                          hintText: 'Password',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                            onTap: () {
                              if (_signUpFormKey.currentState!.validate()) {
                                signUpUser();
                              }
                            },
                            text: 'Sign Up'),
                      ],
                    ),
                  ),
                ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                tileColor: _auth == Auth.signin
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  'Sign-In',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  activeColor: GlobalVariables
                      .secondaryColor, // Sets the active color of the radio button
                  value:
                      Auth.signin, // The value represented by this radio button
                  groupValue:
                      _auth, // The currently selected value for the group of radio buttons
                  onChanged: (Auth? val) {
                    // Callback when the radio button is selected
                    setState(() {
                      _auth = val!; // Update the state with the selected value
                    });
                  },
                ),
              ),
              if (_auth == Auth.signin)
                Container(
                  padding: const EdgeInsets.all(12),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signInFormKey,
                    child: Column(
                      children: [
                        CustomTextfield(
                          controller: _emailController,
                          hintText: 'Email',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextfield(
                          controller: _passwordController,
                          hintText: 'Password',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                            onTap: () {
                              if (_signInFormKey.currentState!.validate()) {
                                signInUser();
                              }
                            },
                            text: 'Sign In'),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
