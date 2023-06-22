import 'package:e_commerce_app/constants/colors.dart';
import 'package:e_commerce_app/events/auth_event.dart';
import 'package:e_commerce_app/screens/login_screen.dart';
import 'package:e_commerce_app/widgets/vl_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/constants/validations.dart';
import 'package:e_commerce_app/networks/locals/shared_pref.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Validations {
  @override
  void dispose() {
    userNameTextController.dispose();
    passwordTextController.dispose();
    firstNameTextController.dispose();
    lastNameTextController.dispose();
    emailTextController.dispose();
    phoneNumberTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final phoneNumberTextController = TextEditingController();
  final userNameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final sharedPreferences = SharedPref();
  final authEvent = AuthEvent();

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
                          'Hallo, Create an account now!',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: firstNameTextController,
                          validator: validateFirstName,
                          decoration: InputDecoration(
                            prefixIcon:
                                const Icon(Icons.text_rotation_none_outlined),
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
                            hintText: "Input your first name",
                            labelText: "First Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: lastNameTextController,
                          validator: validateLastName,
                          decoration: InputDecoration(
                            prefixIcon:
                                const Icon(Icons.text_rotation_none_outlined),
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
                            hintText: "Input your last name",
                            labelText: "Last Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: emailTextController,
                          validator: validateEmail,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.mail_outline_rounded),
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
                            hintText: "Input your email",
                            labelText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: phoneNumberTextController,
                          validator: validatePhoneNumber,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.phone_iphone_rounded),
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
                            hintText: "Input your phone number",
                            labelText: "Phone",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
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
                          validator: validatePasswordRegister,
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
                        const SizedBox(
                          height: 15,
                        ),
                        VLButton(
                          textLabelButton: const Text("REGISTER"),
                          colorTextLabelButton: Colors.white,
                          iconButton: const Icon(Icons.login_outlined),
                          colorButton: Colors.blueAccent,
                          iconColorButton: Colors.white,
                          onPress: () {
                            if (formKey.currentState!.validate()) {
                              authEvent.registerAction(
                                firstNameTextController.text,
                                lastNameTextController.text,
                                emailTextController.text,
                                phoneNumberTextController.text,
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
                                  text: "Do you have an account?",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                TextSpan(
                                  text: " Sign in!",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const LoginScreen(),
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
