import 'package:flutter/material.dart';
import 'package:news_app_project/view/bottomnavbar_screen/bottomnavbar_screen.dart';
import 'package:news_app_project/view/registerscreen.dart';
import 'package:news_app_project/widgets/app_name.dart';
import 'package:news_app_project/widgets/custom_textfield.dart';
import 'package:news_app_project/widgets/text_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late SharedPreferences preferences;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> checkLogin(String email, String password) async {
    final preferences = await SharedPreferences.getInstance();
    final storedEmail = preferences.getString('email');
    final storedPassword = preferences.getString('password');

    print('Entered: $email | $password');
    print('Stored : $storedEmail | $storedPassword');

    if (email == storedEmail && password == storedPassword) {
      await preferences.setBool('isLoggedIn', true);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login Successful'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) =>BottomnavbarScreen()),
              (route) => false,
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Failed'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> validation() async {
    if (formKey.currentState!.validate()) {
      await checkLogin(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppName(),
                const SizedBox(height: 100),
                CustomTextField(
                  labelText: 'Email',
                  hintText: 'example@gmail.com',
                  prefixIcon: Icons.email,
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    } else if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 20.0),
                CustomTextField(
                  labelText: 'Password',
                  hintText: 'Password',
                  prefixIcon: Icons.lock,
                  controller: passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: size.height * 0.02),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                    },
                    child: const TextBuilder(
                      text: 'Forgot Password',
                      fontSize: 16,
                      color: Color(0xFF16C47F),
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                Center(
                  child: MaterialButton(
                    height: 60,
                    color: Colors.black,
                    minWidth: size.width * 0.8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onPressed: validation,
                    child: const TextBuilder(
                      text: 'Login',
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TextBuilder(
                      text: "Don't have an account? ",
                      color: Colors.black,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>RegistrationScreen(),
                          ),
                        );
                      },
                      child: const TextBuilder(
                        text: 'Sign Up',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
