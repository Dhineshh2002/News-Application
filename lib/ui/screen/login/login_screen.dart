import 'package:dr_news/ui/screen/home/home_screen.dart';
import 'package:dr_news/ui/screen/login/sign_up_screen.dart';
import 'package:dr_news/ui/screen/login/user_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/form_validation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final Validation validation = Validation();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool visibilityOfPassword = true;

  @override
  Widget build(BuildContext context) {
    IconData icon =
        visibilityOfPassword ? Icons.visibility : Icons.visibility_off;

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
                    'Login',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: size.size.height * 0.17),
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
                        icon: Icon(icon),
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
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {},
                      radius: 35,
                      borderRadius: BorderRadius.circular(30),
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: color.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 65,
                    child: FilledButton(
                      onPressed: () {
                        pushNewsScreen(context);
                      },
                      child: const Text('LOGIN WITH EMAIL'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Don't have an account?",
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
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: Text(
                          'Sign up',
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

  void pushNewsScreen(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      UserDetailViewModel viewModel = context.read<UserDetailViewModel>();
      viewModel.gettingUsers();
      List<UserDetail> users = viewModel.users;

      for (int i = 0; i < users.length; i++) {
        if (users[i].userEmail == email.text &&
            users[i].password == password.text) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewsScreen(),
            ),
          );
        }
        return;
      }
      wrongUserCredential();
    }
  }

  Future<void> wrongUserCredential() async {
    await showDialog<String>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Login failed'),
          content: const Text(
              '''Your username or password are incorrect.\nPlease try again'''),
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
}
