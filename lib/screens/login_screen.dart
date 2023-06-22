import 'package:e_commerce_app/constants/colors.dart';
import 'package:e_commerce_app/events/auth_event.dart';
import 'package:e_commerce_app/screens/register_screen.dart';
import 'package:e_commerce_app/widgets/vl_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:e_commerce_app/constants/validations.dart';
import 'package:e_commerce_app/networks/locals/shared_pref.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Validations {
  @override
  void dispose() {
    userNameTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  final userNameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final sharedPreferences = SharedPref();
  final authEvent = AuthEvent();

  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VLColors.vlMainColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Card(
                  color: Colors.white,
                  margin: const EdgeInsets.only(
                    top: 40,
                    bottom: 40,
                    right: 10,
                    left: 10,
                  ),
                  shadowColor: Colors.white70,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Hi, Welcome Back!',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        TextFormField(
                          controller: userNameTextController,
                          validator: validateUsername,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueAccent,
                                width: 1.0,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueAccent,
                                width: 1.0,
                              ),
                            ),
                            hintText: "Input your username",
                            labelText: "Username",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: passwordTextController,
                          validator: validatePasswordLogin,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.key),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueAccent,
                                width: 1.0,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueAccent,
                                width: 1.0,
                              ),
                            ),
                            hintText: "Input your password",
                            labelText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        VLButton(
                          textLabelButton: const Text("LOGIN"),
                          colorTextLabelButton: Colors.white,
                          iconButton: const Icon(Icons.login_outlined),
                          colorButton: Colors.blueAccent,
                          iconColorButton: Colors.white,
                          onPress: () {
                            if (formKey.currentState!.validate()) {
                              authEvent.loginAction(
                                userNameTextController.text,
                                passwordTextController.text,
                                context,
                                mounted,
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: "Don't you have an account?",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                TextSpan(
                                  text: " Sign up!",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const RegisterScreen(),
                                          ),
                                        ),
                                  style: const TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        VLButton(
                          textLabelButton: const Text("Login with Google"),
                          colorTextLabelButton: Colors.white,
                          iconButton: const Icon(FontAwesomeIcons.google),
                          colorButton: Colors.redAccent,
                          iconColorButton: Colors.white,
                          onPress: () {},
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        VLButton(
                          textLabelButton: const Text("Login with Facebook"),
                          colorTextLabelButton: Colors.white,
                          iconButton: const Icon(FontAwesomeIcons.facebook),
                          colorButton: const Color.fromARGB(255, 10, 17, 122),
                          iconColorButton: Colors.white,
                          onPress: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
