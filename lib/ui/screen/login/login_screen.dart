import 'package:dr_news/ui/screen/home/news_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final String _password = 'Dinesh1@';
  final String _mail = 'dhineshramadoss10@gmail.com';

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
                    'DRNews',
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
                      return validateEmail(email);
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
                      return validatePassword(password);
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
                        // pushNewsScreen();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NewsScreen(),
                          ),
                        );
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
                        onTap: () {},
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

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "Email can't be empty";
    } else if (!(RegExp(
            r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""")
        .hasMatch(email))) {
      return 'Invalid email';
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return "Password can't be empty";
    } else if (password.length < 8) {
      return 'Password must contain 8 characters';
    } else if (!(password.contains(RegExp(r'[A-Z]')))) {
      return 'Password must contain least 1 capital letter';
    } else if (!(password.contains(RegExp(r'[a-z]')))) {
      return 'Password must contain least 1 small letter';
    } else if (!(password.contains(RegExp(r'[0-9]')))) {
      return 'Password must contain least 1 numeric';
    } else if (!(password.contains(RegExp(r'''[!@#$%^&*()',.?":{}|<>]''')))) {
      return 'Password must contain least 1 special character';
    }
    return null;
  }

  void pushNewsScreen() {
    if (_formKey.currentState!.validate()) {
      if (password.text == _password && email.text == _mail) {
      } else {
        showDialog<String>(
          barrierLabel: 'What is this',
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
  }
}
