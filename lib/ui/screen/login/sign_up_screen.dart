import 'package:dr_news/ui/screen/login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/form_validation.dart';
import '../../../data/model/user_detail_view_model.dart';
import '../../../data/providers/user_detail.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final Validation validation = Validation();

  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  bool visibilityOfPassword = true;
  bool visibilityOfConfirmPassword = true;
  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    IconData iconForPassword =
        visibilityOfPassword ? Icons.visibility : Icons.visibility_off;
    IconData iconForConfirmPassword =
        visibilityOfConfirmPassword ? Icons.visibility : Icons.visibility_off;

    ColorScheme color = Theme.of(context).colorScheme;

    MediaQueryData size = MediaQuery.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: size.size.height * 0.17),
                  TextFormField(
                    controller: userName,
                    decoration: InputDecoration(
                      fillColor: color.primaryContainer,
                      prefixIcon: const Icon(Icons.account_circle),
                      prefixIconColor: color.primary,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      hintText: 'Enter your name',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: email,
                    decoration: InputDecoration(
                      fillColor: color.primaryContainer,
                      prefixIcon: const Icon(Icons.mail_rounded),
                      prefixIconColor: color.primary,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      hintText: 'Enter your email',
                    ),
                    validator: (email) {
                      return Validation().validateEmail(email);
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    obscureText: visibilityOfPassword,
                    controller: password,
                    decoration: InputDecoration(
                      fillColor: color.primaryContainer,
                      hintText: 'Enter your password',
                      prefixIcon: const Icon(Icons.key),
                      suffixIcon: IconButton(
                        icon: Icon(iconForPassword),
                        color: color.primary,
                        onPressed: () {
                          setState(() {
                            visibilityOfPassword = !visibilityOfPassword;
                          });
                        },
                      ),
                      prefixIconColor: color.primary,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                    ),
                    validator: (password) {
                      return validation.validatePassword(password);
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: confirmPassword,
                    obscureText: visibilityOfConfirmPassword,
                    decoration: InputDecoration(
                      fillColor: color.primaryContainer,
                      hintText: 'Confirm password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(iconForConfirmPassword),
                        color: color.primary,
                        onPressed: () {
                          setState(() {
                            visibilityOfConfirmPassword =
                                !visibilityOfConfirmPassword;
                          });
                        },
                      ),
                      prefixIconColor: color.primary,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (confirmPassword) {
                      return validation.validateConfirmPassword(
                        password.text,
                        confirmPassword,
                      );
                    },
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: checkBoxValue,
                        onChanged: (a) {
                          setState(() {
                            checkBoxValue = !checkBoxValue;
                          });
                        },
                      ),
                      RichText(
                        text: const TextSpan(children: [
                          TextSpan(
                            text: 'I have read and agree to the',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: ' terms of service',
                            style: TextStyle(
                              color: Colors.blueAccent,
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 65,
                    child: FilledButton(
                      onPressed: () {
                        pushLoginScreen(context);
                      },
                      child: const Text('SIGN UP'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: Text(
                          'Log in',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: color.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void pushLoginScreen(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      if (confirmPassword.text == password.text && checkBoxValue) {
        UserDetailViewModel viewModel = context.read<UserDetailViewModel>();

        UserDetail user = UserDetail(
          userName: userName.text,
          userEmail: email.text,
          password: password.text,
        );

        viewModel.insertingUserDetail(user);

        if (viewModel.flag) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('You successfully Signed up'),
            ),
          );
        } else {
          setState(() {
            userName.text = '';
            email.text = '';
            password.text = '';
            confirmPassword.text = '';
            checkBoxValue = false;
          });
          emailAlreadyTakenAlert();
        }
      } else {
        termsAndServiceAlert();
      }
    }
  }

  Future<void> termsAndServiceAlert() async {
    await showDialog<String>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Sign in failed'),
          content: const Text(
              '''Please indicate that you are accept the terms and service'''),
          actions: [
            CupertinoButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }

  Future<void> emailAlreadyTakenAlert() async {
    await showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Sign in failed'),
          content: const  Text('The email you entered have been already in use'),
          actions: [
            CupertinoButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
