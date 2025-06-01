import 'package:flutter/material.dart';
import 'package:news_app_project/widgets/app_name.dart';
import 'package:news_app_project/widgets/custom_textfield.dart';
import 'package:news_app_project/widgets/text_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginscreen.dart';

class RegistrationScreen extends StatefulWidget {
   RegistrationScreen({super.key});

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController cpassword = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late SharedPreferences preferences;

   storedData() async {
     final name1 = name.text.trim();
     final email1 = email.text.trim();
     final password1 = password.text.trim();
     preferences = await SharedPreferences.getInstance();
     preferences.setString('name', name1);
     preferences.setString('email', email1);
     preferences.setString('password', password1);
     print("Saved Name: ${preferences.getString('name')}");
     print("Saved Email: ${preferences.getString('email')}");
     print("Saved Password: ${preferences.getString('password')}");
   }

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {

    Future<void> validation() async{
      if(widget.formKey.currentState!.validate()){
        await widget.storedData();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false,
        );
      }
    }

    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: widget.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppName(),
                const SizedBox(height: 100),
                 CustomTextField(
                  labelText: 'Full Name',
                  hintText: 'Mohanlal',
                  prefixIcon: Icons.person,
                  controller: widget.name,
                  validator: (value){
                    if (value!.isEmpty){
                      return 'Please enter your full name';
                    }
                    else {
                      return null;
                    }
                  }
                ),
                const SizedBox(height: 20.0),
                 CustomTextField(
                  labelText: 'Email',
                  hintText: 'example@gmail.com',
                  prefixIcon: Icons.email,
                   controller: widget.email,
                   validator: (value){
                     if(value!.isEmpty){
                       return 'Please enter your email';
                     }
                     else if(!value.contains('@')){
                       return 'Please enter a valid email';
                     }
                     else{
                       return null;
                     }
                   },
                ),
                const SizedBox(height: 20.0),
                 CustomTextField(
                  labelText: 'Password',
                  hintText: 'Password',
                  prefixIcon: Icons.lock,
                controller: widget.password,
                validator: (value){
                if(value!.isEmpty){
                return 'Please enter your password';
                }
                else if(value.length < 6){
                return 'Password must be at least 6 characters';
                }
                else{
                return null;
                }}
                ),
                const SizedBox(height: 20.0),
                 CustomTextField(
                  labelText: 'Confirm Password',
                  hintText: 'Confirm Password',
                  prefixIcon: Icons.lock,
                   controller: widget.cpassword,
                   validator: (value){
                    if(value != widget.password.text){
                      return 'Password does not match';
                    }
                    else{
                      return null;
                    }
                   },
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
                    onPressed: () {
                     validation();
                    },
                    child: const TextBuilder(
                      text: 'Sign Up',
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
                      text: "Have have an account? ",
                      color: Colors.black,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                        );
                      },
                      child: const TextBuilder(
                        text: 'Login',
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
}
