import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:notes_app/Controllers/AuthController.dart';
import 'package:notes_app/auth/registerScreen.dart';
import 'package:notes_app/widgets/textfield.dart';

class Loginscreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                  "Login",
                  style: TextStyle(
                    fontFamily: 'DancingScript',
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: colors.primary,
                  ),
                ),
                SizedBox(height: 30),
                Textfields(
                  label: 'Enter Your Email',
                  textEditingController: emailController,
                  validator: ValidationBuilder().email().build(),
                ),
                SizedBox(height: 16),
                Textfields(
                  label: 'Enter Your Password',
                  textEditingController: passwordController,
                  validator: ValidationBuilder().required().build(),
                ),

                SizedBox(height: 30),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        authcontroller.login(
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
                      "Login",
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
                    text: "Don't have an account?",
                    children: [
                      TextSpan(
                        text: "Register",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: colors.onSurface,
                        ),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                Get.offAll(Registerscreen());
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
