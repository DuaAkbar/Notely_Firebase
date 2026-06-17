import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:notes_app/Controllers/AuthController.dart';
import 'package:notes_app/auth/loginScreen.dart';
import 'package:notes_app/widgets/textfield.dart';

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final Authcontroller authcontroller = Get.put(Authcontroller());

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  RegExp regex = RegExp(
    r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*\W)(?!.* ).{8,16}$',
  );

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign Up",
                  style: TextStyle(
                    fontFamily: 'DancingScript',
                    fontSize: 27,
                    fontWeight: FontWeight.w700,
                    color: colors.primary,
                  ),
                ),
                SizedBox(height: 30),
                Textfields(
                  label: 'Enter Your Name',
                  textEditingController: nameController,
                  validator:
                      ValidationBuilder().minLength(3).maxLength(20).build(),
                ),
                SizedBox(height: 16),
                Textfields(
                  label: 'Enter Your Email',
                  textEditingController: emailController,
                  validator: ValidationBuilder().email().build(),
                ),
                SizedBox(height: 16),
                Textfields(
                  label: 'Enter Your Password',
                  textEditingController: passwordController,
                  validator:
                      ValidationBuilder()
                          .regExp(regex, "Use a strong password")
                          .build(),
                ),
                SizedBox(height: 16),
                Textfields(
                  label: 'Enter Your Confirm Password',
                  textEditingController: confirmPasswordController,
                  validator: (value) {
                    if (value != passwordController.text) {
                      return "Confirm Password and Password should match";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        authcontroller.register(
                          nameController.text.trim(),
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primary,
                      foregroundColor: colors.onPrimary,
                    ),
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),

                Text.rich(
                  TextSpan(
                    text: "Already have an account?",
                    children: [
                      TextSpan(
                        text: "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: colors.onSurface,
                        ),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                Get.offAll(Loginscreen());
                              },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
