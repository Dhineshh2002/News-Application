import 'package:dr_news/ui/screen/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/form_validation.dart';
import '../../../data/model/user_detail_view_model.dart';
import '../../../data/providers/user_detail.dart';
import 'alert_messages.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final Validation validation = Validation();

  final TextEditingController _userName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  bool _visibilityOfPassword = true;
  bool _visibilityOfConfirmPassword = true;
  bool _checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    IconData iconForPassword =
        _visibilityOfPassword ? Icons.visibility : Icons.visibility_off;
    IconData iconForConfirmPassword =
        _visibilityOfConfirmPassword ? Icons.visibility : Icons.visibility_off;

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
                    controller: _userName,
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
                    controller: _email,
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
                    obscureText: _visibilityOfPassword,
                    controller: _password,
                    decoration: InputDecoration(
                      fillColor: color.primaryContainer,
                      hintText: 'Enter your password',
                      prefixIcon: const Icon(Icons.key),
                      suffixIcon: IconButton(
                        icon: Icon(iconForPassword),
                        color: color.primary,
                        onPressed: () {
                          setState(() {
                            _visibilityOfPassword = !_visibilityOfPassword;
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
                    controller: _confirmPassword,
                    obscureText: _visibilityOfConfirmPassword,
                    decoration: InputDecoration(
                      fillColor: color.primaryContainer,
                      hintText: 'Confirm password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(iconForConfirmPassword),
                        color: color.primary,
                        onPressed: () {
                          setState(() {
                            _visibilityOfConfirmPassword =
                                !_visibilityOfConfirmPassword;
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
                        _password.text,
                        confirmPassword,
                      );
                    },
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _checkBoxValue,
                        onChanged: (a) {
                          setState(() {
                            _checkBoxValue = !_checkBoxValue;
                          });
                        },
                      ),
                      RichText(
                        text: const TextSpan(children: [
                          TextSpan(
                            text: 'I have read and agree to the',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: ' terms of service',
                            style: TextStyle(color: Colors.blueAccent),
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
    final Alert alert = Alert();

    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => const LoginScreen());

    SnackBar snackBar =
        const SnackBar(content: Text('You successfully Signed up'));

    UserDetail user = UserDetail(
      userName: _userName.text,
      userEmail: _email.text,
      password: _password.text,
    );

    if (_formKey.currentState!.validate()) {
      if (_confirmPassword.text == _password.text && _checkBoxValue) {
        UserDetailViewModel viewModel = context.read<UserDetailViewModel>();

        viewModel.insertingUserDetail(user);

        if (viewModel.flag) {
          Navigator.push(context, route);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          setState(() {
            _userName.text = '';
            _email.text = '';
            _password.text = '';
            _confirmPassword.text = '';
            _checkBoxValue = false;
          });
          alert.emailAlreadyTakenAlert(context);
        }
      } else {
        alert.termsAndServiceAlert(context);
      }
    }
  }
}
